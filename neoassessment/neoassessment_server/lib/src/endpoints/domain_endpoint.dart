import 'package:neoassessment_server/src/generated/protocol.dart';
import 'package:neoassessment_server/src/utils/kconstant.dart';
import 'package:serverpod/server.dart';

class DomainEndpoint extends Endpoint {
  Future<Map<String, dynamic>> create(Session session, Domain domain) async {
    session as MethodCallSession;
    if (session.httpRequest.method != 'POST') {
      return response400(
          message: "Bad Request", userMsg: "User can't be created", body: []);
    }

    try {
      String name = domain.name.toLowerCase();
      domain.name = name;
      final Domain? domainExist = await Domain.findSingleRow(session, where: (t) => t.name.equals(domain.name));
      print(domainExist);
      if (domainExist != null) {
        return response409(message: "Domain already exist", body: [], userMsg: "Domain already exist");
      }
      await Domain.insert(session, domain);
      return response200(
          message: "Domain created successfully!",
          body: [],
          userMsg: "Domain created successfully");
    } catch (e) {
      return response500(
          message: e.toString(), userMsg: internalServerError, body: []);
    }
  }

  Future<Map<String, dynamic>> delete(Session session, int domainId) async {
    session as MethodCallSession;
    if (session.httpRequest.method != 'POST') {
      return response400(
          message: "Bad Request", userMsg: "User can't be created", body: []);
    }
    try {
      Domain? domain = await Domain.findById(session, domainId);

      if (domain == null) {
        return response404(
            message: "Domain not found",
            userMsg: "No Domain of this name",
            body: []);
      }

      await Domain.delete(session, where: (t) => t.id.equals(domainId));

      return response200(
          message: "Domain deleted successfully!",
          body: [],
          userMsg: "Domain deleted successfully");
    } catch (e) {
      return response500(
          message: e.toString(), userMsg: internalServerError, body: []);
    }
  }

  Future<Map<String, dynamic>> update(Session session, int domainId,
      String newdomain, String newdescription) async {
    session as MethodCallSession;
    if (session.httpRequest.method != 'POST') {
      return response400(
          message: "Bad Request", userMsg: "User can't be updated", body: []);
    }

    try {
      Domain? domain = await Domain.findSingleRow(session,
          where: (t) => t.id.equals(domainId));
      if (domain == null) {
        return response404(
            message: "Domain not found",
            userMsg: "No domain of this name",
            body: []);
      }
      domain.name = newdomain;
      domain.description = newdescription;
      await Domain.update(session, domain);
      return response200(
          userMsg: "Domain Updated Successfully!!!",
          message: "Domain updated successfully");
    } catch (e) {
      return response500(
          userMsg: e.toString(), message: e.toString(), body: []);
    }
  }

  Future<Map<String, dynamic>> getDomains(Session session) async {
    session as MethodCallSession;
    if (session.httpRequest.method != 'GET') {
      return response400(
          message: "Bad Request", userMsg: "User can't be updated", body: []);
    }
    try {
      List<List<dynamic>> domains =
          await session.db.query("SELECT * FROM domain");
      List<Map<String,dynamic>> result = [];

      for(var domain in domains) {
        result.add({
          "id": domain[0],
          "name": domain[1],
          "description": domain[2]
        });
      }
      return response200(
          message: "Domain fetched successfully!",
          body: result,
          userMsg: "Domain fetched successfully");
    } catch (e) {
      return response500(
          message: e.toString(), userMsg: internalServerError, body: []);
    }
  }
}
