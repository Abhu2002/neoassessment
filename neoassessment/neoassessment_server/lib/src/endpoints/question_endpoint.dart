import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:neoassessment_server/src/generated/protocol.dart';
import 'package:neoassessment_server/src/utils/kconstant.dart';
import 'package:serverpod/server.dart';

class QuestionEndpoint extends Endpoint {
  Future<Map<String, dynamic>> create(
      Session session, Question question) async {
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

      final Domain? domainexists = await Domain.findSingleRow(session,
          where: (p) => p.id.equals(question.domain_id));
      if (domainexists == null) {
        return response404(
            userMsg: "Domain doesn't exists",
            message: "Please give appropriate domain Id");
      }
      final Level? levelexists = await Level.findSingleRow(session,
          where: (p) => p.id.equals(question.level_id));
      if (levelexists == null) {
        return response404(
            userMsg: "Level doesn't exists",
            message: "Please give appropriate Level");
      }
      final QuestionCategory? questioncat =
          await QuestionCategory.findSingleRow(session,
              where: (p) => p.id.equals(question.question_category_id));
      if (questioncat == null) {
        return response404(
            userMsg: "Question Category doesn't exists",
            message: "Please give appropriate Question Category Id");
      }
      // Question questioninfo = Question( domain_id: question.domain_id, level_id: question.level_id, question: question.question, question_category_id: question.question_category_id, op1: question.op1, op2: question.op2, op3: question.op3, op4: question.op4, correct_op: question.correct_op);
      await Question.insert(session, question);
      return response200(
          message: "Question Created",
          userMsg: "Question Successfully Created",
          body: question);
    } on JWTExpiredException {
      return response402(
          message: jwtExpiredMsg, userMsg: loginAgainMsg, body: []);
    } catch (e) {
      return response500(
          message: e.toString(), userMsg: internalServerError, body: []);
    }
  }

  Future<Map<String, dynamic>> delete(Session session, int questionId) async {
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
      User? actedUser = await User.findSingleRow(session,
          where: (t) => t.id.equals(jwt.payload['user_id']));
      print(actedUser);
      if (actedUser == null) {
        return response404(
            message: "User not found", userMsg: loginAgainMsg, body: []);
      }
      Role? role = await Role.findSingleRow(session,
          where: (t) => t.name.equals("SUPERADMIN"));

      if (actedUser.role_id != role!.id) {
        return response402(
            message: notPermittedMsg, userMsg: notPermittedUserMsg, body: []);
      }
      final Question? questioninfo = await Question.findSingleRow(session,
          where: (p) => p.id.equals(questionId));
      if (questioninfo == null) {
        return response404(
            userMsg: "Question  doesn't exists",
            message: "Please give appropriate Question  Id");
      }
      await Question.delete(session, where: (t) => t.id.equals(questionId));
      return response200(
          message: "Question  deleted successfully!",
          body: [],
          userMsg: "Question deleted successfully");
    } on JWTExpiredException {
      return response402(
          message: jwtExpiredMsg, userMsg: loginAgainMsg, body: []);
    } catch (e) {
      return response500(
          message: e.toString(), userMsg: internalServerError, body: []);
    }
  }

  Future<Map<String, dynamic>> getQuestion(Session session) async {
    session as MethodCallSession;
    if (session.httpRequest.method != 'GET') {
      return response400(
          message: badRequestforGet, userMsg: usrNotCreated, body: []);
    }
    try {
      List<List<dynamic>> questions =
          await session.db.query("SELECT * FROM question");
      List<Map<String,dynamic>> results = [];
      for(var q in questions) {
        results.add({
          "id": q[0],
          "domain_id": q[1],
          "level_id": q[2],
          "question": q[3],
          "question_category_id": q[4],
          "op1": q[5],
          "op2": q[6],
          "op3": q[7],
          "op4": q[8],
          "correct_op": q[9],
        });
      }

      return response200(
          message: "Questions  fetched successfully!",
          body: results,
          userMsg: "Questions fetched successfully");
    } catch (e) {
      return response500(
          message: e.toString(), userMsg: internalServerError, body: []);
    }
  }

  Future<Map<String, dynamic>> updateQuestion(
      Session session, int questId, Question question) async {
    session as MethodCallSession;

    if (session.httpRequest.method != 'POST') {
      return response400(
          message: badRequestMsg, userMsg: methodNotAllowedMsg, body: []);
    }

    var authenticate = authenticateUser(session);
    if (!authenticate['isAuthenticated']) {
      return response402(message: invaltokmsg, userMsg: invaltokmsg);
    }
    try {
      Question? questionInfo = await Question.findSingleRow(session,
          where: (t) => t.id.equals(questId));
      if (questionInfo == null) {
        return response404(
            message: "Question  not found",
            userMsg: "No question  of this name",
            body: []);
      }
      questionInfo.domain_id = question.domain_id;
      questionInfo.level_id = question.level_id;
      questionInfo.question = question.question;
      questionInfo.question_category_id = question.question_category_id;
      questionInfo.op1 = question.op1;
      questionInfo.op2 = question.op2;
      questionInfo.op3 = question.op3;
      questionInfo.op4 = question.op4;
      questionInfo.correct_op = question.correct_op;
      await Question.update(session, questionInfo);
      return response200(
          message: "Question Updated",
          userMsg: "Question Updated Successfully!!!!",
          body: questionInfo);
    } on JWTExpiredException {
      return response402(
          message: jwtExpiredMsg, userMsg: loginAgainMsg, body: []);
    } catch (e) {
      return response500(
          message: e.toString(), userMsg: internalServerError, body: []);
    }
  }
}
