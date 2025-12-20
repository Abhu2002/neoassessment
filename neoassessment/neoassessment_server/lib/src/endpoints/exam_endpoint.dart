import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:serverpod/server.dart';

import '../generated/protocol.dart';
import '../utils/kconstant.dart';

class ExamEndpoint extends Endpoint {
  Future<Map<String, dynamic>> create(Session session, Exam exam) async {
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

      await Exam.insert(session, exam);

      return response200(
          message: "Exam created successfully",
          userMsg: "Exam created successfully",
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
      Session session, int examId, Exam exam) async {
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

      Exam? examPresent =
          await Exam.findSingleRow(session, where: (t) => t.id.equals(examId));

      if (examPresent == null) {
        return response404(
          message: "Exam not present",
          userMsg: "Exam not found",
          body: [],
        );
      }

      examPresent.name = exam.name;
      examPresent.domain_id = exam.domain_id;
      examPresent.no_of_questions = exam.no_of_questions;
      examPresent.level = exam.level;
      examPresent.question_ids = exam.question_ids;
      examPresent.passing_score = exam.passing_score;
      examPresent.description = exam.description;

      await Exam.update(session, examPresent);

      return response200(
          message: "Exam updated successfully",
          userMsg: "Exam updated successfully",
          body: []);
    } on JWTExpiredException {
      return response402(
          message: jwtExpiredMsg, userMsg: loginAgainMsg, body: []);
    } catch (e) {
      return response500(
          message: e.toString(), userMsg: internalServerError, body: []);
    }
  }

  Future<Map<String, dynamic>> getExams(Session session) async {
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

      List<List<dynamic>> allExams =
          await session.db.query('SELECT * FROM exams');
      List<Map<String, dynamic>> result = [];

      for (var exam in allExams) {
        result.add({
          'id': exam[0],
          'name': exam[1],
          'description': exam[2],
          'domain_id': exam[3],
          'no_of_questions': exam[4],
          'level': exam[5],
          'question_ids': exam[6],
          'passing_score': exam[7]
        });
      }

      return response200(
          message: "Exams fetched successfully",
          userMsg: "Exams fetched successfully",
          body: result);
    } on JWTExpiredException {
      return response402(
          message: jwtExpiredMsg, userMsg: loginAgainMsg, body: []);
    } catch (e) {
      return response500(
          message: e.toString(), userMsg: internalServerError, body: []);
    }
  }

  Future<Map<String, dynamic>> delete(Session session, int examId) async {
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

      Exam? exam =
          await Exam.findSingleRow(session, where: (t) => t.id.equals(examId));

      if (exam == null) {
        return response404(
          message: "Exam not found",
          userMsg: "Exam not found",
          body: [],
        );
      }

      await Exam.delete(session, where: (t) => t.id.equals(examId));

      return response200(
        message: "Exam deleted successfully",
        userMsg: "Exam deleted successfully",
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
}
