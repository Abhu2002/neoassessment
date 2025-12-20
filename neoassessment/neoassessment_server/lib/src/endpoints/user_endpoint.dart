import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:neoassessment_server/src/utils/kconstant.dart';
import 'package:serverpod/server.dart';

import '../generated/protocol.dart';

class UserEndpoint extends Endpoint {
  Future<Map<String, dynamic>> register(Session session, User user) async {
    session as MethodCallSession;

    if (session.httpRequest.method != 'POST') {
      return response400(
          message: badRequestMsg, userMsg: methodNotAllowedMsg, body: []);
    }
    try {
      if (user.email.isEmpty) {
        return response400(
            message: "Email should not be empty",
            userMsg: "Add your email address",
            body: []);
      }

      final User? emailExist = await User.findSingleRow(session,
          where: (t) => t.email.equals(user.email));

      if (emailExist != null) {
        return response405(
            message: emailAlreadyExistError,
            userMsg: emailAlreadyExistError,
            body: []);
      }

      if (user.password.isEmpty || user.password.length < 8) {
        return response400(
            message: passwordLengthError, userMsg: passwordLengthError);
      }

      await User.insert(session, user);

      final User? regUser = await User.findSingleRow(session,
          where: (t) => t.email.equals(user.email));

      return response200(
          message: "User created successfully",
          userMsg: "Registered successfully",
          body: [regUser!.toJson()]);
    } catch (e) {
      return response500(
          message: e.toString(), userMsg: internalServerError, body: []);
    }
  }

  Future<Map<String, dynamic>> login(
      Session session, String email, String password) async {
    session as MethodCallSession;

    if (session.httpRequest.method != "POST") {
      return response400(
          message: badRequestMsg, userMsg: methodNotAllowedMsg, body: []);
    }
    try {
      final User? regUser = await User.findSingleRow(session,
          where: (t) => t.email.equals(email));
      print(regUser);

      if (regUser == null) {
        return response404(
            message: "User not found",
            userMsg: "Email does not exist. Register first.",
            body: []);
      }

      if (regUser.password != password) {
        return response405(
            message: "Password does not match",
            userMsg: "Incorrect password",
            body: []);
      }

      final jwt = JWT(
        // Payload
        {'user_id': regUser.id},
        issuer: 'https://github.com/jonasroussel/dart_jsonwebtoken',
      );
      var token = jwt.sign(SecretKey(userJWTSecretKey),
          expiresIn: Duration(minutes: 50));

      regUser.access_token = token;

      await User.update(session, regUser);

      return response200(
          message: "User logged in",
          userMsg: "Logged in successfully",
          body: [regUser.toJson()]);
    } catch (e) {
      return response500(
          message: e.toString(), userMsg: internalServerError, body: []);
    }
  }

  Future<Map<String, dynamic>> getUsers(Session session) async {
    session as MethodCallSession;

    if (session.httpRequest.method != 'GET') {
      return response400(
          message: badRequestMsg, userMsg: methodNotAllowedMsg, body: []);
    }

    try {
      final List<List<dynamic>> userList =
          await session.db.query("SELECT * FROM users");
      List<Map<String, dynamic>> users = [];

      for (var user in userList) {
        users.add({
          "id": user[0],
          "first_name": user[1],
          "last_name": user[2],
          "email": user[3],
          "phone": user[4],
          "dob": user[5],
          "domain_id": user[6],
          "role_id": user[7],
          "experience": user[8],
          "password": user[9],
          "access_token": user[10],
        });
      }

      return response200(
          message: "Users fetched successfully",
          userMsg: "Users info fetched",
          body: users);
    } catch (e) {
      return response500(
          message: e.toString(), userMsg: internalServerError, body: []);
    }
  }

  Future<Map<String, dynamic>> updateUser(
      Session session, int userId, User user) async {
    session as MethodCallSession;

    if (session.httpRequest.method != 'POST') {
      return response400(
          message: badRequestMsg, userMsg: methodNotAllowedMsg, body: []);
    }

    var authenticate = authenticateUser(session);
    print(authenticate["isAuthenticated"]);
    if (!authenticate['isAuthenticated']) {
      return response402(
          message: invalidTokenMsg, userMsg: loginAgainMsg, body: []);
    }

    try {
      final jwt =
          JWT.verify(authenticate['access'], SecretKey(userJWTSecretKey));

      int isPermitted = await isUserPermitted(session, jwt.payload['user_id']);

      if (isPermitted == 0) {
        return response402(
            message: notPermittedMsg, userMsg: notPermittedUserMsg, body: []);
      } else if (isPermitted == -1) {
        return response404(
            message: "User not found", userMsg: "User not found", body: []);
      }
      User? reqUser =
          await User.findSingleRow(session, where: (t) => t.id.equals(userId));

      if (reqUser == null) {
        return response404(
            message: "User not found",
            userMsg: "Requested user does not exist",
            body: []);
      }
      reqUser.first_name = user.first_name;
      reqUser.last_name = user.last_name;
      reqUser.email = user.email;
      reqUser.phone = user.phone;
      reqUser.dob = user.dob;
      reqUser.domain_id = user.domain_id;
      reqUser.role_id = user.role_id;
      reqUser.experience = user.experience;
      reqUser.password = user.password;

      await User.update(session, reqUser);

      return response200(
          message: "User updated successfully",
          userMsg: "Info updated",
          body: []);
    } on JWTExpiredException {
      return response402(
          message: jwtExpiredMsg, userMsg: loginAgainMsg, body: []);
    } catch (e) {
      return response500(
          message: e.toString(), userMsg: internalServerError, body: []);
    }
  }

  Future<Map<String, dynamic>> deleteUser(Session session, int userId) async {
    session as MethodCallSession;

    if (session.httpRequest.method != 'POST') {
      return response400(
          message: badRequestMsg, userMsg: methodNotAllowedMsg, body: []);
    }

    var authenticate = authenticateUser(session);

    if (!authenticate['isAuthenticated']) {
      return response402(
          message: invalidTokenMsg, userMsg: loginAgainMsg, body: []);
    }

    try {
      final jwt =
          JWT.verify(authenticate['access'], SecretKey(userJWTSecretKey));

      int isPermitted = await isUserPermitted(session, jwt.payload['user_id']);

      if (isPermitted == 0) {
        return response402(
            message: notPermittedMsg, userMsg: notPermittedUserMsg, body: []);
      } else if (isPermitted == -1) {
        return response404(
            message: "User not found", userMsg: "User not found", body: []);
      }

      await User.delete(session, where: (t) => t.id.equals(userId));

      return response200(
        message: "Delete operation successful",
        userMsg: "User deleted successfully",
        body: [],
      );
    } on JWTExpiredException {
      return response402(
          message: jwtExpiredMsg, userMsg: loginAgainMsg, body: []);
    } catch (e) {
      return response500(
          message: e.toString(), userMsg: internalServerError, body: []);
    }
  }

  Future<Map<String, dynamic>> getSingleUser(
      Session session, int userId) async {
    session as MethodCallSession;

    if (session.httpRequest.method != 'GET') {
      return response400(
          message: badRequestMsg, userMsg: methodNotAllowedMsg, body: []);
    }

    var authenticate = authenticateUser(session);

    if (!authenticate['isAuthenticated']) {
      return response402(
          message: invalidTokenMsg, userMsg: loginAgainMsg, body: []);
    }
    try {
      final jwt =
          JWT.verify(authenticate['access'], SecretKey(userJWTSecretKey));

      int isPermitted = await isUserPermitted(session, jwt.payload['user_id']);

      if (isPermitted == 0) {
        return response402(
            message: notPermittedMsg, userMsg: notPermittedUserMsg, body: []);
      } else if (isPermitted == -1) {
        return response404(
            message: "User not found", userMsg: "User not found", body: []);
      }

      User? user = await User.findById(session, userId);

      if (user == null) {
        return response404(
            message: "User not found", body: [], userMsg: "User not found");
      }

      return response200(
        message: "User fetched successful",
        userMsg: "User fetched successfully",
        body: [
          user.toJson(),
        ],
      );
    } on JWTExpiredException {
      return response402(
          message: jwtExpiredMsg, userMsg: loginAgainMsg, body: []);
    } catch (e) {
      return response500(
          message: e.toString(), userMsg: internalServerError, body: []);
    }
  }

  Future<Map<String, dynamic>> verifyToken(
      Session session, String tokenData) async {
    try {
      final jwt = JWT.verify(tokenData, SecretKey(userJWTSecretKey));
      return response200(
          message: "Valid Token",
          userMsg: "Token verification Successful ",
          body: jwt.payload);
    } on JWTExpiredException {
      return response402(
          body: null,
          userMsg: "Token Verification Unsuccessful",
          message: "Token Expired");
    } on JWTException catch (e) {
      return response500(message: e.toString(), userMsg: e.toString());
    }
  }
}
