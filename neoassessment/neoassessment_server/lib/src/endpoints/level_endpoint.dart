import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:serverpod/server.dart';

import '../generated/protocol.dart';
import '../utils/kconstant.dart';

class LevelEndpoint extends Endpoint {
  Future<Map<String, dynamic>> create(Session session, Level level) async {
    session as MethodCallSession;
    if (session.httpRequest.method != 'POST') {
      return response400(
          message: badRequestforPost, userMsg: usrNotCreated, body: []);
    }

    var authenticate = authenticateUser(session);
    if (!authenticate['isAuthenticated']) {
      return response402(message: invaltokmsg, userMsg: invaltokmsg);
    }

    try {
      final jwt =
          JWT.verify(authenticate['access'], SecretKey(userJWTSecretKey));
      int isPermitted = await isUserPermitted(session, jwt.payload['user_id']);
      print("is Permitted:${isPermitted}");

      if (isPermitted == 0) {
        return response402(
            message: notPermittedMsg, userMsg: notPermittedUserMsg, body: []);
      } else if (isPermitted == -1) {
        return response404(
            message: "User not found", userMsg: "User not found", body: []);
      }

      await Level.insert(session, level);

      return response200(
          message: "Level created successfully",
          userMsg: "Level created successfully",
          body: []);
    } on JWTExpiredException {
      return response402(
          message: jwtExpiredMsg, userMsg: loginAgainMsg, body: []);
    } catch (e) {
      return response500(
          message: e.toString(), userMsg: internalServerError, body: []);
    }
  }

  Future<Map<String, dynamic>> update(
      Session session, int levelId, Level level) async {
    session as MethodCallSession;
    if (session.httpRequest.method != 'POST') {
      return response400(
          message: badRequestforPost, userMsg: usrNotCreated, body: []);
    }

    var authenticate = authenticateUser(session);
    if (!authenticate['isAuthenticated']) {
      return response402(message: invaltokmsg, userMsg: invaltokmsg);
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
      Level? reqLevel = await Level.findSingleRow(session,
          where: (t) => t.id.equals(levelId));

      if (reqLevel == null) {
        return response404(
          message: "Level not found",
          userMsg: "Requested level not found",
          body: [],
        );
      }

      reqLevel.number = level.number;

      await Level.update(session, reqLevel);

      return response200(
        message: "Level updated successfully",
        userMsg: "Level updated successfully",
        body: [],
      );
    } on JWTExpiredException {
      return response402(
        message: jwtExpiredMsg,
        userMsg: loginAgainMsg,
        body: [],
      );
    } catch (e) {
      return response500(
        message: e.toString(),
        userMsg: internalServerError,
        body: [],
      );
    }
  }

  Future<Map<String, dynamic>> getLevels(Session session) async {
    session as MethodCallSession;
    if (session.httpRequest.method != 'GET') {
      return response400(
          message: badRequestforPost, userMsg: usrNotCreated, body: []);
    }

    var authenticate = authenticateUser(session);
    if (!authenticate['isAuthenticated']) {
      return response402(message: invaltokmsg, userMsg: invaltokmsg);
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

      List<List<dynamic>> allLevels =
          await session.db.query("SELECT * FROM level");

      List<Map<String, dynamic>> body = [];

      for (var level in allLevels) {
        body.add({"id": level[0], "number": level[1]});
      }
      return response200(
          message: "Levels fetched successfully",
          userMsg: "Levels fetched successfully",
          body: body);
    } on JWTExpiredException {
      return response402(
          message: jwtExpiredMsg, userMsg: loginAgainMsg, body: []);
    } catch (e) {
      return response500(
          message: e.toString(), userMsg: internalServerError, body: []);
    }
  }

  Future<Map<String, dynamic>> delete(Session session, int levelId) async {
    session as MethodCallSession;
    if (session.httpRequest.method != 'POST') {
      return response400(
          message: badRequestforPost, userMsg: usrNotCreated, body: []);
    }

    var authenticate = authenticateUser(session);
    if (!authenticate['isAuthenticated']) {
      return response402(message: invaltokmsg, userMsg: invaltokmsg);
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
      Level? reqLevel = await Level.findSingleRow(session,
          where: (t) => t.id.equals(levelId));

      if (reqLevel == null) {
        return response404(
          message: "Level not found",
          userMsg: "Requested level not found",
          body: [],
        );
      }

      await Level.delete(session, where: (t) => t.id.equals(levelId));

      return response200(
        message: "Level deleted successfully",
        userMsg: "Level deleted successfully",
        body: [],
      );
    } on JWTExpiredException {
      return response402(
        message: jwtExpiredMsg,
        userMsg: loginAgainMsg,
        body: [],
      );
    } catch (e) {
      return response500(
        message: e.toString(),
        userMsg: internalServerError,
        body: [],
      );
    }
  }
}
