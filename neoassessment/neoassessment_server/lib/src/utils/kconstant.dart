import 'package:neoassessment_server/src/utils/response.dart';
import 'package:serverpod/server.dart';

import '../generated/role.dart';
import '../generated/user.dart';

final String candidatejwtSectetKey =
    "D6VXp0R2RCsHPhwLgzDTxgu1Ejg1ZuQ3lz7S_FWbfaU=";
final String internalServerError = "Internal Server Error";
final String passwordLengthError =
    "Password should be greater than or equal to 8";
final String emailAlreadyExistError = "Email already exist";
final String userJWTSecretKey = "d6Xmg7LRqwARI3NnGh0YrD3cKahXaEyz";
final String methodNotAllowedMsg = "Method not allowed";
final String badRequestMsg = "Bad request";
final String invalidTokenMsg = "Invalid token";
final String loginAgainMsg = "Login again";
final String jwtExpiredMsg = "JWT expired";
final String notPermittedMsg = "Operation not permitted";
final String notPermittedUserMsg =
    "Request denied. You don't have appropriate permissions.";
final String candidateRegSuc = "Candidate Registration Successful";
final String candidateRegUnSuc = "Candidate Registration Unsuccessful";
final String emailAlreadyExistMsg = "Email id already exist";
final String badRequestforPost = "Bad Request. Supported Method POST.";
final String usrNotCreated = "User can't be created";
final String badRequestforGet = "Bad Request. Supported Method GET.";
final String candLoginSuc = "Candidate Login Successful";
final String candLoginUnSuc = "Candidate Login Unsuccessful";
final String invaltokmsg = "Invalid Token";

Map<String, dynamic> response200(
    {required String message, dynamic body, String? userMsg}) {
  return Response(status: 200, body: body, message: message, userMsg: userMsg)
      .toJson();
}

Future<int> isUserRecruiter(Session session, int userId) async {
  User? actedUser =
      await User.findSingleRow(session, where: (t) => t.id.equals(userId));
  if (actedUser == null) {
    return -1;
  }
  Role? role = await Role.findSingleRow(session, where: (t) {
    return t.name.equals("RECRUITER");
  });
  print(role);
  return actedUser.role_id != role!.id ? 0 : 1;
}

Future<int> isUserPermitted(Session session, int userId) async {
  User? actedUser =
      await User.findSingleRow(session, where: (t) => t.id.equals(userId));

  if (actedUser == null) {
    return -1;
  }
  Role? role = await Role.findSingleRow(session, where: (t) {
    return t.name.equals("SUPERADMIN");
  });
  return actedUser.role_id != role!.id ? 0 : 1;
}

Map<String, dynamic> authenticateUser(Session session) {
  session as MethodCallSession;
  var access = session.httpRequest.headers.value("Access-Token");

  if (access == null) {
    return {"isAuthenticated": false};
  } else {
    return {"isAuthenticated": true, "access": access};
  }
}

Map<String, dynamic> response500(
    {required String message, dynamic body, String? userMsg}) {
  return Response(status: 500, body: body, message: message, userMsg: userMsg)
      .toJson();
}

Map<String, dynamic> response409(
    {required String message, dynamic body, String? userMsg}) {
  return Response(status: 409, body: body, message: message, userMsg: userMsg)
      .toJson();
}

Map<String, dynamic> response400(
    {required String message, dynamic body, String? userMsg}) {
  return Response(status: 400, body: body, message: message, userMsg: userMsg)
      .toJson();
}

Map<String, dynamic> response402(
    {required String message, dynamic body, String? userMsg}) {
  return Response(status: 402, body: body, message: message, userMsg: userMsg)
      .toJson();
}

Map<String, dynamic> response404(
    {required String message, dynamic body, String? userMsg}) {
  return Response(status: 404, body: body, message: message, userMsg: userMsg)
      .toJson();
}

Map<String, dynamic> response405(
    {required String message, dynamic body, String? userMsg}) {
  return Response(status: 405, body: body, message: message, userMsg: userMsg)
      .toJson();
}
