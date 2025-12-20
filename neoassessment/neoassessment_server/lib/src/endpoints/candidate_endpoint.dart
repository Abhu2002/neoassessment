import 'package:neoassessment_server/src/generated/protocol.dart';
import 'package:serverpod/server.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import '../utils/kconstant.dart';

class CandidateEndpoint extends Endpoint {
  Future<Map<String, dynamic>> register(
      Session session, Candidate candidate) async {
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

      var emailAlreadyExist = await Candidate.find(
        session,
        where: (p) => p.email.equals(candidate.email),
      );
      // var usernameAlreadyExist = await Candidate.find(
      //   session,
      //   where: (p) => p.first_name.equals(candidate.first_name),
      // );
      if (emailAlreadyExist.isEmpty) {
        Candidate candinfo = Candidate(
            first_name: candidate.first_name,
            last_name: candidate.last_name,
            email: candidate.email,
            dob: candidate.dob,
            domain_id: candidate.domain_id,
            experience: candidate.experience,
            password: candidate.password,
            access_token: null,
            phone: candidate.phone);
        await Candidate.insert(session, candinfo);
        return response200(
            message: candidateRegSuc, userMsg: candidateRegSuc, body: candinfo);
      } else {
        return response500(
            message: candidateRegUnSuc,
            body: {
              "first_name": candidate.first_name,
              "last_name": candidate.last_name,
              "email": candidate.email,
              "phn_no": candidate.phone
            },
            userMsg: emailAlreadyExistMsg);
      }
    } on JWTExpiredException {
      return response402(
          message: jwtExpiredMsg, userMsg: loginAgainMsg, body: []);
    } catch (e) {
      return response500(
          message: e.toString(), userMsg: internalServerError, body: []);
    }
  }

  Future<Map<String, dynamic>> loginCandidate(
      Session session, String email, String password) async {
    session as MethodCallSession;
    if (session.httpRequest.method != 'POST') {
      return response400(
          message: badRequestforPost, userMsg: usrNotCreated, body: []);
    }
    try {
      var emailExists =
          await Candidate.find(session, where: (p) => p.email.equals(email));
      if (emailExists.isNotEmpty) {
        var password = await Candidate.find(session,
            where: (p) => p.password.equals(emailExists[0].password));
        if (password != password[0].password) {
          final jwt = JWT(
            {
              'candidateId': emailExists[0].id,
              'exp':
                  DateTime.now().add(Duration(hours: 1)).millisecondsSinceEpoch
            },
            issuer: 'https://github.com/jonasroussel/dart_jsonwebtoken',
          );
          var token = jwt.sign(SecretKey(candidatejwtSectetKey));
          print("Signed token: $token");
          emailExists[0].access_token = token;
          await Candidate.update(session, emailExists[0]);
          return response200(
              message: candLoginSuc,
              userMsg: "Logged In successfully",
              body: emailExists[0]);
        } else {
          return response500(
              body: [],
              message: candLoginUnSuc,
              userMsg: "Candidate Credentials are invalid");
        }
      } else {
        return response500(
            message: candLoginUnSuc,
            userMsg:
                "Email or Password is wrong,Try again or else register first");
      }
    } on JWTExpiredException {
      return response402(
          message: jwtExpiredMsg, userMsg: loginAgainMsg, body: []);
    } catch (e) {
      return response500(message: e.toString(), userMsg: e.toString());
    }
  }

  Future<Map<String, dynamic>> deleteCandidate(
      Session session, int candidateId) async {
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

      Candidate? candidate = await Candidate.findById(session, candidateId);

      if (candidate == null) {
        return response404(
            message: "Candidate  doesn't exists",
            userMsg: "No Candidate exits of this id ",
            body: []);
      }
      await Candidate.delete(session, where: (t) => t.id.equals(candidateId));
      return response200(
          message: "Candidate deleted successfully!",
          body: [],
          userMsg: "Candidate deleted successfully");
    } on JWTExpiredException {
      return response402(
          message: jwtExpiredMsg, userMsg: loginAgainMsg, body: []);
    } catch (e) {
      return response500(
          message: e.toString(), userMsg: internalServerError, body: []);
    }
  }

  Future<Map<String, dynamic>> getallCandidates(Session session) async {
    session as MethodCallSession;
    if (session.httpRequest.method != 'GET') {
      return response400(
          message: badRequestforGet, userMsg: badRequestforGet, body: []);
    }

    var authenticate = authenticateUser(session);
    if (!authenticate['isAuthenticated']) {
      return response402(message: invaltokmsg, userMsg: invaltokmsg);
    }

    try {
      final jwt =
          JWT.verify(authenticate['access'], SecretKey(userJWTSecretKey));

      int isPermitted = await isUserPermitted(session, jwt.payload['user_id']);

      int isRecruiter = await isUserRecruiter(session, jwt.payload['user_id']);

      print("ADMIN:::$isPermitted");
      print("RECRUITER:::$isRecruiter");
      if (isPermitted == 0 && isRecruiter == 0) {
        return response402(
            message: notPermittedMsg, userMsg: notPermittedUserMsg, body: []);
      } else if (isPermitted == -1) {
        return response404(
            message: "Candidate not found", userMsg: "Candidate not found", body: []);
      }

      final List<List<dynamic>> candidateList =
          await session.db.query("SELECT * FROM candidate");

      List<Map<String, dynamic>> candidates = [];
      for (var candidate in candidateList) {
        candidates.add({
          "id": candidate[0],
          "first_name": candidate[1],
          "last_name": candidate[2],
          "email": candidate[3],
          "dob": candidate[4],
          "domain_id": candidate[5],
          "experience": candidate[6],
          "password": candidate[7],
          "access_token": candidate[8],
          "phone": candidate[9]
        });
      }
      return response200(
          message: "Candidates Fetched Successfully",
          userMsg: "Candidate Info Fetched",
          body: candidates);
    } on JWTExpiredException {
      return response402(
          message: jwtExpiredMsg, userMsg: loginAgainMsg, body: []);
    } catch (e) {
      return response500(
          message: e.toString(), userMsg: internalServerError, body: []);
    }
  }

  Future<Map<String, dynamic>> getSingleCandidate(
      Session session, int candidateId) async {
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

      int isRecruiter = await isUserRecruiter(session, jwt.payload['user_id']);

      print("ADMIN:::$isPermitted");
      print("RECRUITER:::$isRecruiter");
      if (isPermitted == 0 && isRecruiter == 0) {
        return response402(
            message: notPermittedMsg, userMsg: notPermittedUserMsg, body: []);
      } else if (isPermitted == -1) {
        return response404(
            message: "Candidate not found", userMsg: "Candidate not found", body: []);
      }

      Candidate? user = await Candidate.findById(session, candidateId);

      if (user == null) {
        return response404(
            message: "Candidate not found", body: [], userMsg: "Candidate not found");
      }

      return response200(
        message: "Candidate fetched successful",
        userMsg: "Candidate fetched successfully",
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

  Future<Map<String, dynamic>> updateCandidate(
      Session session, int candidateId, Candidate candidate) async {
    session as MethodCallSession;
    if (session.httpRequest.method != 'POST') {
      return response400(
          message: badRequestforPost, userMsg: badRequestforPost, body: []);
    }
    var authenticate = authenticateUser(session);

    if (!authenticate["isAuthenticated"]) {
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
      Candidate? regcandidate = await Candidate.findSingleRow(session,
          where: (t) => t.id.equals(candidateId));

      regcandidate!.first_name = candidate.first_name;
      regcandidate.last_name = candidate.last_name;
      regcandidate.email = candidate.email;
      regcandidate.dob = candidate.dob;
      regcandidate.domain_id = candidate.domain_id;
      regcandidate.experience = candidate.experience;
      regcandidate.password = candidate.password;
      regcandidate.phone = candidate.phone;

      await Candidate.update(session, regcandidate);
      return response200(
          message: "Candidate Updated Successfully",
          userMsg: "Candidate updated");
    } on JWTExpiredException {
      return response402(
          message: jwtExpiredMsg, userMsg: loginAgainMsg, body: []);
    } catch (e) {
      return response500(
          message: e.toString(), userMsg: internalServerError, body: []);
    }
  }
}
