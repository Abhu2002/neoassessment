import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:serverpod/server.dart';

import '../generated/protocol.dart';
import '../utils/kconstant.dart';

class ResponseEndpoint extends Endpoint {
  Future<Map<String, dynamic>> saveResponse(
      Session session, Response response) async {
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

      await Response.insert(session, response);

      return response200(
        message: "Response submitted",
        userMsg: "Response submitted successfully",
        body: [],
      );
    } on JWTExpiredException {
      return response402(
          message: jwtExpiredMsg, userMsg: loginAgainMsg, body: []);
    } catch (e) {
      return response500(
          userMsg: e.toString(), message: internalServerError, body: []);
    }
  }

  Future<Map<String, dynamic>> updateResponseInfo(
      Session session,
      int? assigneeId,
      int? statusId,
      int? reviewerId,
      int? score,
      int responseId) async {
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

      Response? response = await Response.findSingleRow(session,
          where: (t) => t.id.equals(responseId));

      if (response == null) {
        return response404(
          message: "Response not found",
          userMsg: "Response not found",
          body: [],
        );
      }

      if (assigneeId != null) {
        User? assignee = await User.findSingleRow(session,
            where: (t) => t.id.equals(assigneeId));

        if (assignee == null) {
          return response404(
            message: "Assignee user not found",
            userMsg: "Assignee user not found",
            body: [],
          );
        }

        response.assign_by = assigneeId;
      }

      if (reviewerId != null) {
        User? reviewer = await User.findSingleRow(session,
            where: (t) => t.id.equals(reviewerId));

        if (reviewer == null) {
          return response404(
            message: "Reviewer user not found",
            userMsg: "Reviewer user not found",
            body: [],
          );
        }

        response.reviewed_by = reviewerId;
      }

      if (score != null) {
        response.score = score;
      }

      if (statusId != null) {
        Status? status = await Status.findSingleRow(session,
            where: (t) => t.id.equals(statusId));

        if (status == null) {
          return response404(
            message: "Status not found",
            userMsg: "Status not found",
            body: [],
          );
        }

        response.status = statusId;
      }

      await Response.update(session, response);

      return response200(
        message: "Response updated successfully",
        userMsg: "Response info updated",
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
        userMsg: e.toString(),
        message: internalServerError,
        body: [],
      );
    }
  }

  Future<Map<String, dynamic>> getAllResponses(Session session) async {
    session as MethodCallSession;

    if (session.httpRequest.method != 'GET') {
      return response400(
          message: badRequestMsg, userMsg: methodNotAllowedMsg, body: []);
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

      List<List<dynamic>> allResponses =
          await session.db.query("SELECT * FROM responses");
      List<Map<String, dynamic>> res = [];

      for (var response in allResponses) {
        res.add({
          "id": response[0],
          "candidate_id": response[1],
          "exam_id": response[2],
          "score": response[3],
          "assign_by": response[4],
          "reviewed_by": response[5],
          "q_ids": response[6],
          "response": response[7],
          "status_id": response[8]
        });
      }

      return response200(
        message: "Responses fetched successfully",
        userMsg: "Responses fetched successfully",
        body: res,
      );
    } on JWTExpiredException {
      return response402(
        message: jwtExpiredMsg,
        userMsg: loginAgainMsg,
        body: [],
      );
    } catch (e) {
      return response500(
        userMsg: e.toString(),
        message: internalServerError,
        body: [],
      );
    }
  }

  Future<Map<String, dynamic>> deleteResponse(
      Session session, int responseId) async {
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

      Response? response = await Response.findSingleRow(session,
          where: (t) => t.id.equals(responseId));

      if (response == null) {
        return response404(
          message: "Response not found",
          userMsg: "Response not found",
          body: [],
        );
      }

      await Response.delete(session, where: (t) => t.id.equals(responseId));

      return response200(
        message: "Response deleted successfully",
        userMsg: "Response deleted successfully",
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
        userMsg: e.toString(),
        message: internalServerError,
        body: [],
      );
    }
  }
}
