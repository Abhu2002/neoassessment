import 'package:serverpod/serverpod.dart';

class Response implements SerializableEntity {
  int status;
  Map<String, String>? headers;
  dynamic body;
  String? message;
  String? userMsg;

  Response(
      {required this.status,
        this.headers,
        this.body,
        this.message,
        this.userMsg});

  @override
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'body': body,
      'message': message,
      'user_msg': userMsg,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      'status': status,
      'body': body,
      'message': message,
      'user_msg': userMsg,
    };
  }
}
