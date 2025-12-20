import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:neoassessment_server/src/generated/protocol.dart';
import 'package:neoassessment_server/src/utils/kconstant.dart';
import 'package:serverpod/server.dart';

class QuestionCategoryEndpoint extends Endpoint {
  Future<Map<String, dynamic>> create(
      Session session, QuestionCategory questioncategory) async {
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
          where: (p) => p.id.equals(questioncategory.domain_id));
      if (domainexists == null) {
        return response404(
            userMsg: "Domain doesn't exists",
            message: "Please give appropriate domain Id");
      }
      QuestionCategory questioncatinfo = QuestionCategory(
          domain_id: questioncategory.domain_id,
          name: questioncategory.name,
          description: questioncategory.description);
      await QuestionCategory.insert(session, questioncatinfo);
      return response200(
          message: "Question Category Created Successfully",
          userMsg: "Creation Successful",
          body: questioncatinfo);
    } on JWTExpiredException {
      return response402(
          message: jwtExpiredMsg, userMsg: loginAgainMsg, body: []);
    } catch (e) {
      return response500(
          message: e.toString(), userMsg: internalServerError, body: []);
    }
  }

  Future<Map<String, dynamic>> delete(
      Session session, int questioncategoryId) async {
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
      // ignore: non_constant_identifier_names
      QuestionCategory? question_cat_info =
          await QuestionCategory.findById(session, questioncategoryId);
      if (question_cat_info == null) {
        return response404(
            message: "Question Category not found",
            userMsg: "No question category of this name",
            body: []);
      }
      await QuestionCategory.delete(session,
          where: (t) => t.id.equals(questioncategoryId));
      return response200(
          message: "Question Category deleted successfully!",
          body: [],
          userMsg: "Question Category deleted successfully");
    } on JWTExpiredException {
      return response402(
          message: jwtExpiredMsg, userMsg: loginAgainMsg, body: []);
    } catch (e) {
      return response500(
          message: e.toString(), userMsg: internalServerError, body: []);
    }
  }

  Future<Map<String, dynamic>> getQuestionCategory(Session session) async {
    session as MethodCallSession;
    if (session.httpRequest.method != 'GET') {
      return response400(
          message: badRequestforGet, userMsg: usrNotCreated, body: []);
    }
    try {
      List<List<dynamic>> questionCat =
          await session.db.query("SELECT * FROM questioncategory");

      List<Map<String,dynamic>> results = [];
      for(var q in questionCat) {
        results.add({
          "id": q[0],
          "domain_id": q[1],
          "name": q[2],
          "description": q[3]
        });
      }

      return response200(
          message: "Question Category  fetched successfully!",
          body: results,
          userMsg: "Question Category fetched successfully");
    } catch (e) {
      return response500(
          message: e.toString(), userMsg: internalServerError, body: []);
    }
  }

  Future<Map<String, dynamic>> update(
      Session session, int questCatId, QuestionCategory questionCat) async {
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
      QuestionCategory? questionCatInfo = await QuestionCategory.findSingleRow(
          session,
          where: (t) => t.id.equals(questCatId));
      if (questionCatInfo == null) {
        return response404(
            message: "Question Category not found",
            userMsg: "No question category of this name",
            body: []);
      }
      questionCatInfo.id = questCatId;
      questionCatInfo.domain_id = questionCat.domain_id;
      questionCatInfo.name = questionCat.name;
      questionCatInfo.description = questionCat.description;
      await QuestionCategory.update(session, questionCatInfo);
      return response200(
          message: "Question Category  Updated Successfully",
          userMsg: "Question Category updated",
          body: questionCat);
    } on JWTExpiredException {
      return response402(
          message: jwtExpiredMsg, userMsg: loginAgainMsg, body: []);
    } catch (e) {
      return response500(
          message: e.toString(), userMsg: internalServerError, body: []);
    }
  }
}
