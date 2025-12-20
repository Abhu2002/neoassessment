import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:neoassessment_server/src/generated/protocol.dart';
import 'package:neoassessment_server/src/utils/kconstant.dart';
import 'package:serverpod/server.dart';

class StatusEndpoint extends Endpoint {
  Future<Map<String, dynamic>> create(Session session, Status status) async {
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

      await Status.insert(session, status);

      return response200(
          message: "Status created successfully",
          userMsg: "Status created successfully",
          body: status);
    } on JWTExpiredException {
      return response402(
          message: jwtExpiredMsg, userMsg: loginAgainMsg, body: []);
    } catch (e) {
      return response500(
          userMsg: e.toString(), message: internalServerError, body: []);
    }
  }

  Future<Map<String, dynamic>> delete(Session session, int statusId) async {
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
      Status? reqstatus = await Status.findSingleRow(session,
          where: (t) => t.id.equals(statusId));
      if (reqstatus == null) {
        return response404(
          message: "Status not found",
          userMsg: "Status not found",
          body: [],
        );
      }
      await Status.delete(session, where: (t) => t.id.equals(statusId));

      return response200(
        message: "Status deleted successfully",
        userMsg: "Status deleted successfully",
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

  Future<Map<String, dynamic>> getStatus(Session session) async {
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
      List<List<dynamic>> allStatus =
          await session.db.query("SELECT * FROM status");

      List<Map<String, dynamic>> body = [];

      for (var status in allStatus) {
        body.add({"id": status[0], "status": status[1]});
      }
      return response200(
          message: "Status fetched successfully",
          userMsg: "Status fetched successfully",
          body: body);
    } on JWTExpiredException {
      return response402(
          message: jwtExpiredMsg, userMsg: loginAgainMsg, body: []);
    } catch (e) {
      return response500(
          message: e.toString(), userMsg: internalServerError, body: []);
    }
  }

  Future<Map<String, dynamic>> update(
      Session session, int statusId, Status status) async {
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
      Status? reqStatus = await Status.findSingleRow(session,
          where: (t) => t.id.equals(statusId));
      if (reqStatus == null) {
        return response404(
          message: "Status not found",
          userMsg: "Please Enter Appropriate Status ID",
          body: [],
        );
      }

      reqStatus.name = status.name;

      await Status.update(session, reqStatus);

      return response200(
        message: "Status updated successfully",
        userMsg: "Status updated successfully",
        body: reqStatus,
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
