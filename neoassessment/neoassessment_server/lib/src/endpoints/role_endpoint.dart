import 'package:neoassessment_server/src/generated/protocol.dart';
import 'package:neoassessment_server/src/utils/kconstant.dart';
import 'package:serverpod/server.dart';

class RoleEndpoint extends Endpoint {
  Future<Map<String, dynamic>> create(Session session, Role role) async {
    session as MethodCallSession;

    if (session.httpRequest.method != 'POST') {
      return response400(
          message: badRequestforPost, userMsg: usrNotCreated, body: []);
    }
    try {

      final roleExist = await Role.findSingleRow(session, where: (t) => t.name.equals(role.name));
      if (roleExist != null) {
        return response409(message: "Role already exist", body: [], userMsg: "Role already exist");
      }
      await Role.insert(session, role);
      return response200(
          message: "Role created successfully!",
          body: [],
          userMsg: "Role created successfully");
    } catch (e) {
      return response500(
          message: e.toString(), userMsg: internalServerError, body: []);
    }
  }

  Future<Map<String, dynamic>> update(
      Session session, int roleId,
      String newRole) async {
    session as MethodCallSession;

    if (session.httpRequest.method != 'POST') {
      return response400(
          message: badRequestforPost, userMsg: usrNotCreated, body: []);
    }
    try {
      Role? role = await Role.findSingleRow(session,
          where: (t) => t.id.equals(roleId));

      if (role == null) {
        return response404(
            message: "Role not found",
            userMsg: "No role of this name",
            body: []);
      }
      role.name = newRole;
      await Role.update(session, role);

      return response200(
          message: "Role updated successfully!",
          body: [],
          userMsg: "Role updated successfully");
    } catch (e) {
      return response500(
          message: e.toString(), userMsg: internalServerError, body: []);
    }
  }

  Future<Map<String, dynamic>> delete(Session session, int roleId) async {
    session as MethodCallSession;

    if (session.httpRequest.method != 'POST') {
      return response400(
          message: badRequestforPost, userMsg: usrNotCreated, body: []);
    }
    try {
      Role? role = await Role.findById(session, roleId);

      if (role == null) {
        return response404(
            message: "Role not found",
            userMsg: "No role of this name",
            body: []);
      }

      await Role.delete(session, where: (t) => t.id.equals(roleId));

      return response200(
          message: "Role deleted successfully!",
          body: [],
          userMsg: "Role deleted successfully");
    } catch (e) {
      return response500(
          message: e.toString(), userMsg: internalServerError, body: []);
    }
  }

  Future<Map<String, dynamic>> getRoles(Session session) async {
    session as MethodCallSession;

    if (session.httpRequest.method != 'GET') {
      return response400(
          message: badRequestforGet, userMsg: usrNotCreated, body: []);
    }
    try {
      List<List<dynamic>> roles = await session.db.query("SELECT * FROM role");
      List<Map<String,dynamic>> result = [];

      for(var role in roles) {
        result.add({
          "id": role[0],
          "name": role[1]
        });
      }

      return response200(
          message: "Role fetched successfully!",
          body: result,
          userMsg: "Role fetched successfully");
    } catch (e) {
      return response500(
          message: e.toString(), userMsg: internalServerError, body: []);
    }
  }
  
  
}
