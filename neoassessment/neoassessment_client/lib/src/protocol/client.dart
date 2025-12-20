/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:neoassessment_client/src/protocol/candidate.dart' as _i3;
import 'package:neoassessment_client/src/protocol/domain.dart' as _i4;
import 'package:neoassessment_client/src/protocol/exam.dart' as _i5;
import 'package:neoassessment_client/src/protocol/level.dart' as _i6;
import 'package:neoassessment_client/src/protocol/questionCategory.dart' as _i7;
import 'package:neoassessment_client/src/protocol/question.dart' as _i8;
import 'package:neoassessment_client/src/protocol/response.dart' as _i9;
import 'package:neoassessment_client/src/protocol/role.dart' as _i10;
import 'package:neoassessment_client/src/protocol/status.dart' as _i11;
import 'package:neoassessment_client/src/protocol/user.dart' as _i12;
import 'dart:io' as _i13;
import 'protocol.dart' as _i14;

class _EndpointCandidate extends _i1.EndpointRef {
  _EndpointCandidate(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'candidate';

  _i2.Future<Map<String, dynamic>> register(_i3.Candidate candidate) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'candidate',
        'register',
        {'candidate': candidate},
      );

  _i2.Future<Map<String, dynamic>> loginCandidate(
    String email,
    String password,
  ) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'candidate',
        'loginCandidate',
        {
          'email': email,
          'password': password,
        },
      );

  _i2.Future<Map<String, dynamic>> deleteCandidate(int candidateId) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'candidate',
        'deleteCandidate',
        {'candidateId': candidateId},
      );

  _i2.Future<Map<String, dynamic>> getallCandidates() =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'candidate',
        'getallCandidates',
        {},
      );

  _i2.Future<Map<String, dynamic>> getSingleCandidate(int candidateId) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'candidate',
        'getSingleCandidate',
        {'candidateId': candidateId},
      );

  _i2.Future<Map<String, dynamic>> updateCandidate(
    int candidateId,
    _i3.Candidate candidate,
  ) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'candidate',
        'updateCandidate',
        {
          'candidateId': candidateId,
          'candidate': candidate,
        },
      );
}

class _EndpointDomain extends _i1.EndpointRef {
  _EndpointDomain(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'domain';

  _i2.Future<Map<String, dynamic>> create(_i4.Domain domain) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'domain',
        'create',
        {'domain': domain},
      );

  _i2.Future<Map<String, dynamic>> delete(int domainId) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'domain',
        'delete',
        {'domainId': domainId},
      );

  _i2.Future<Map<String, dynamic>> update(
    int domainId,
    String newdomain,
    String newdescription,
  ) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'domain',
        'update',
        {
          'domainId': domainId,
          'newdomain': newdomain,
          'newdescription': newdescription,
        },
      );

  _i2.Future<Map<String, dynamic>> getDomains() =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'domain',
        'getDomains',
        {},
      );
}

class _EndpointExam extends _i1.EndpointRef {
  _EndpointExam(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'exam';

  _i2.Future<Map<String, dynamic>> create(_i5.Exam exam) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'exam',
        'create',
        {'exam': exam},
      );

  _i2.Future<Map<String, dynamic>> update(
    int examId,
    _i5.Exam exam,
  ) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'exam',
        'update',
        {
          'examId': examId,
          'exam': exam,
        },
      );

  _i2.Future<Map<String, dynamic>> getExams() =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'exam',
        'getExams',
        {},
      );

  _i2.Future<Map<String, dynamic>> delete(int examId) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'exam',
        'delete',
        {'examId': examId},
      );
}

class _EndpointExample extends _i1.EndpointRef {
  _EndpointExample(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'example';

  _i2.Future<String> hello(String name) => caller.callServerEndpoint<String>(
        'example',
        'hello',
        {'name': name},
      );
}

class _EndpointLevel extends _i1.EndpointRef {
  _EndpointLevel(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'level';

  _i2.Future<Map<String, dynamic>> create(_i6.Level level) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'level',
        'create',
        {'level': level},
      );

  _i2.Future<Map<String, dynamic>> update(
    int levelId,
    _i6.Level level,
  ) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'level',
        'update',
        {
          'levelId': levelId,
          'level': level,
        },
      );

  _i2.Future<Map<String, dynamic>> getLevels() =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'level',
        'getLevels',
        {},
      );

  _i2.Future<Map<String, dynamic>> delete(int levelId) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'level',
        'delete',
        {'levelId': levelId},
      );
}

class _EndpointQuestionCategory extends _i1.EndpointRef {
  _EndpointQuestionCategory(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'questionCategory';

  _i2.Future<Map<String, dynamic>> create(
          _i7.QuestionCategory questioncategory) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'questionCategory',
        'create',
        {'questioncategory': questioncategory},
      );

  _i2.Future<Map<String, dynamic>> delete(int questioncategoryId) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'questionCategory',
        'delete',
        {'questioncategoryId': questioncategoryId},
      );

  _i2.Future<Map<String, dynamic>> getQuestionCategory() =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'questionCategory',
        'getQuestionCategory',
        {},
      );

  _i2.Future<Map<String, dynamic>> update(
    int questCatId,
    _i7.QuestionCategory questionCat,
  ) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'questionCategory',
        'update',
        {
          'questCatId': questCatId,
          'questionCat': questionCat,
        },
      );
}

class _EndpointQuestion extends _i1.EndpointRef {
  _EndpointQuestion(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'question';

  _i2.Future<Map<String, dynamic>> create(_i8.Question question) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'question',
        'create',
        {'question': question},
      );

  _i2.Future<Map<String, dynamic>> delete(int questionId) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'question',
        'delete',
        {'questionId': questionId},
      );

  _i2.Future<Map<String, dynamic>> getQuestion() =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'question',
        'getQuestion',
        {},
      );

  _i2.Future<Map<String, dynamic>> updateQuestion(
    int questId,
    _i8.Question question,
  ) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'question',
        'updateQuestion',
        {
          'questId': questId,
          'question': question,
        },
      );
}

class _EndpointResponse extends _i1.EndpointRef {
  _EndpointResponse(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'response';

  _i2.Future<Map<String, dynamic>> saveResponse(_i9.Response response) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'response',
        'saveResponse',
        {'response': response},
      );

  _i2.Future<Map<String, dynamic>> updateResponseInfo(
    int? assigneeId,
    int? statusId,
    int? reviewerId,
    int? score,
    int responseId,
  ) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'response',
        'updateResponseInfo',
        {
          'assigneeId': assigneeId,
          'statusId': statusId,
          'reviewerId': reviewerId,
          'score': score,
          'responseId': responseId,
        },
      );

  _i2.Future<Map<String, dynamic>> getAllResponses() =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'response',
        'getAllResponses',
        {},
      );

  _i2.Future<Map<String, dynamic>> deleteResponse(int responseId) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'response',
        'deleteResponse',
        {'responseId': responseId},
      );
}

class _EndpointRole extends _i1.EndpointRef {
  _EndpointRole(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'role';

  _i2.Future<Map<String, dynamic>> create(_i10.Role role) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'role',
        'create',
        {'role': role},
      );

  _i2.Future<Map<String, dynamic>> update(
    int roleId,
    String newRole,
  ) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'role',
        'update',
        {
          'roleId': roleId,
          'newRole': newRole,
        },
      );

  _i2.Future<Map<String, dynamic>> delete(int roleId) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'role',
        'delete',
        {'roleId': roleId},
      );

  _i2.Future<Map<String, dynamic>> getRoles() =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'role',
        'getRoles',
        {},
      );
}

class _EndpointStatus extends _i1.EndpointRef {
  _EndpointStatus(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'status';

  _i2.Future<Map<String, dynamic>> create(_i11.Status status) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'status',
        'create',
        {'status': status},
      );

  _i2.Future<Map<String, dynamic>> delete(int statusId) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'status',
        'delete',
        {'statusId': statusId},
      );

  _i2.Future<Map<String, dynamic>> getStatus() =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'status',
        'getStatus',
        {},
      );

  _i2.Future<Map<String, dynamic>> update(
    int statusId,
    _i11.Status status,
  ) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'status',
        'update',
        {
          'statusId': statusId,
          'status': status,
        },
      );
}

class _EndpointUser extends _i1.EndpointRef {
  _EndpointUser(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'user';

  _i2.Future<Map<String, dynamic>> register(_i12.User user) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'user',
        'register',
        {'user': user},
      );

  _i2.Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'user',
        'login',
        {
          'email': email,
          'password': password,
        },
      );

  _i2.Future<Map<String, dynamic>> getUsers() =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'user',
        'getUsers',
        {},
      );

  _i2.Future<Map<String, dynamic>> updateUser(
    int userId,
    _i12.User user,
  ) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'user',
        'updateUser',
        {
          'userId': userId,
          'user': user,
        },
      );

  _i2.Future<Map<String, dynamic>> deleteUser(int userId) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'user',
        'deleteUser',
        {'userId': userId},
      );

  _i2.Future<Map<String, dynamic>> getSingleUser(int userId) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'user',
        'getSingleUser',
        {'userId': userId},
      );

  _i2.Future<Map<String, dynamic>> verifyToken(String tokenData) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'user',
        'verifyToken',
        {'tokenData': tokenData},
      );
}

class Client extends _i1.ServerpodClient {
  Client(
    String host, {
    _i13.SecurityContext? context,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
  }) : super(
          host,
          _i14.Protocol(),
          context: context,
          authenticationKeyManager: authenticationKeyManager,
        ) {
    candidate = _EndpointCandidate(this);
    domain = _EndpointDomain(this);
    exam = _EndpointExam(this);
    example = _EndpointExample(this);
    level = _EndpointLevel(this);
    questionCategory = _EndpointQuestionCategory(this);
    question = _EndpointQuestion(this);
    response = _EndpointResponse(this);
    role = _EndpointRole(this);
    status = _EndpointStatus(this);
    user = _EndpointUser(this);
  }

  late final _EndpointCandidate candidate;

  late final _EndpointDomain domain;

  late final _EndpointExam exam;

  late final _EndpointExample example;

  late final _EndpointLevel level;

  late final _EndpointQuestionCategory questionCategory;

  late final _EndpointQuestion question;

  late final _EndpointResponse response;

  late final _EndpointRole role;

  late final _EndpointStatus status;

  late final _EndpointUser user;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'candidate': candidate,
        'domain': domain,
        'exam': exam,
        'example': example,
        'level': level,
        'questionCategory': questionCategory,
        'question': question,
        'response': response,
        'role': role,
        'status': status,
        'user': user,
      };
  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
