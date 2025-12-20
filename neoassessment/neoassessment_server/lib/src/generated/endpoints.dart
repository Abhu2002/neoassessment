/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../endpoints/candidate_endpoint.dart' as _i2;
import '../endpoints/domain_endpoint.dart' as _i3;
import '../endpoints/exam_endpoint.dart' as _i4;
import '../endpoints/example_endpoint.dart' as _i5;
import '../endpoints/level_endpoint.dart' as _i6;
import '../endpoints/question_category_endpoint.dart' as _i7;
import '../endpoints/question_endpoint.dart' as _i8;
import '../endpoints/response_endpoint.dart' as _i9;
import '../endpoints/role_endpoint.dart' as _i10;
import '../endpoints/status_endpoint.dart' as _i11;
import '../endpoints/user_endpoint.dart' as _i12;
import 'package:neoassessment_server/src/generated/candidate.dart' as _i13;
import 'package:neoassessment_server/src/generated/domain.dart' as _i14;
import 'package:neoassessment_server/src/generated/exam.dart' as _i15;
import 'package:neoassessment_server/src/generated/level.dart' as _i16;
import 'package:neoassessment_server/src/generated/questionCategory.dart'
    as _i17;
import 'package:neoassessment_server/src/generated/question.dart' as _i18;
import 'package:neoassessment_server/src/generated/response.dart' as _i19;
import 'package:neoassessment_server/src/generated/role.dart' as _i20;
import 'package:neoassessment_server/src/generated/status.dart' as _i21;
import 'package:neoassessment_server/src/generated/user.dart' as _i22;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'candidate': _i2.CandidateEndpoint()
        ..initialize(
          server,
          'candidate',
          null,
        ),
      'domain': _i3.DomainEndpoint()
        ..initialize(
          server,
          'domain',
          null,
        ),
      'exam': _i4.ExamEndpoint()
        ..initialize(
          server,
          'exam',
          null,
        ),
      'example': _i5.ExampleEndpoint()
        ..initialize(
          server,
          'example',
          null,
        ),
      'level': _i6.LevelEndpoint()
        ..initialize(
          server,
          'level',
          null,
        ),
      'questionCategory': _i7.QuestionCategoryEndpoint()
        ..initialize(
          server,
          'questionCategory',
          null,
        ),
      'question': _i8.QuestionEndpoint()
        ..initialize(
          server,
          'question',
          null,
        ),
      'response': _i9.ResponseEndpoint()
        ..initialize(
          server,
          'response',
          null,
        ),
      'role': _i10.RoleEndpoint()
        ..initialize(
          server,
          'role',
          null,
        ),
      'status': _i11.StatusEndpoint()
        ..initialize(
          server,
          'status',
          null,
        ),
      'user': _i12.UserEndpoint()
        ..initialize(
          server,
          'user',
          null,
        ),
    };
    connectors['candidate'] = _i1.EndpointConnector(
      name: 'candidate',
      endpoint: endpoints['candidate']!,
      methodConnectors: {
        'register': _i1.MethodConnector(
          name: 'register',
          params: {
            'candidate': _i1.ParameterDescription(
              name: 'candidate',
              type: _i1.getType<_i13.Candidate>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['candidate'] as _i2.CandidateEndpoint).register(
            session,
            params['candidate'],
          ),
        ),
        'loginCandidate': _i1.MethodConnector(
          name: 'loginCandidate',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['candidate'] as _i2.CandidateEndpoint).loginCandidate(
            session,
            params['email'],
            params['password'],
          ),
        ),
        'deleteCandidate': _i1.MethodConnector(
          name: 'deleteCandidate',
          params: {
            'candidateId': _i1.ParameterDescription(
              name: 'candidateId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['candidate'] as _i2.CandidateEndpoint).deleteCandidate(
            session,
            params['candidateId'],
          ),
        ),
        'getallCandidates': _i1.MethodConnector(
          name: 'getallCandidates',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['candidate'] as _i2.CandidateEndpoint)
                  .getallCandidates(session),
        ),
        'getSingleCandidate': _i1.MethodConnector(
          name: 'getSingleCandidate',
          params: {
            'candidateId': _i1.ParameterDescription(
              name: 'candidateId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['candidate'] as _i2.CandidateEndpoint)
                  .getSingleCandidate(
            session,
            params['candidateId'],
          ),
        ),
        'updateCandidate': _i1.MethodConnector(
          name: 'updateCandidate',
          params: {
            'candidateId': _i1.ParameterDescription(
              name: 'candidateId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'candidate': _i1.ParameterDescription(
              name: 'candidate',
              type: _i1.getType<_i13.Candidate>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['candidate'] as _i2.CandidateEndpoint).updateCandidate(
            session,
            params['candidateId'],
            params['candidate'],
          ),
        ),
      },
    );
    connectors['domain'] = _i1.EndpointConnector(
      name: 'domain',
      endpoint: endpoints['domain']!,
      methodConnectors: {
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'domain': _i1.ParameterDescription(
              name: 'domain',
              type: _i1.getType<_i14.Domain>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['domain'] as _i3.DomainEndpoint).create(
            session,
            params['domain'],
          ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'domainId': _i1.ParameterDescription(
              name: 'domainId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['domain'] as _i3.DomainEndpoint).delete(
            session,
            params['domainId'],
          ),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'domainId': _i1.ParameterDescription(
              name: 'domainId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'newdomain': _i1.ParameterDescription(
              name: 'newdomain',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'newdescription': _i1.ParameterDescription(
              name: 'newdescription',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['domain'] as _i3.DomainEndpoint).update(
            session,
            params['domainId'],
            params['newdomain'],
            params['newdescription'],
          ),
        ),
        'getDomains': _i1.MethodConnector(
          name: 'getDomains',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['domain'] as _i3.DomainEndpoint).getDomains(session),
        ),
      },
    );
    connectors['exam'] = _i1.EndpointConnector(
      name: 'exam',
      endpoint: endpoints['exam']!,
      methodConnectors: {
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'exam': _i1.ParameterDescription(
              name: 'exam',
              type: _i1.getType<_i15.Exam>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['exam'] as _i4.ExamEndpoint).create(
            session,
            params['exam'],
          ),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'examId': _i1.ParameterDescription(
              name: 'examId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'exam': _i1.ParameterDescription(
              name: 'exam',
              type: _i1.getType<_i15.Exam>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['exam'] as _i4.ExamEndpoint).update(
            session,
            params['examId'],
            params['exam'],
          ),
        ),
        'getExams': _i1.MethodConnector(
          name: 'getExams',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['exam'] as _i4.ExamEndpoint).getExams(session),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'examId': _i1.ParameterDescription(
              name: 'examId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['exam'] as _i4.ExamEndpoint).delete(
            session,
            params['examId'],
          ),
        ),
      },
    );
    connectors['example'] = _i1.EndpointConnector(
      name: 'example',
      endpoint: endpoints['example']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['example'] as _i5.ExampleEndpoint).hello(
            session,
            params['name'],
          ),
        )
      },
    );
    connectors['level'] = _i1.EndpointConnector(
      name: 'level',
      endpoint: endpoints['level']!,
      methodConnectors: {
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'level': _i1.ParameterDescription(
              name: 'level',
              type: _i1.getType<_i16.Level>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['level'] as _i6.LevelEndpoint).create(
            session,
            params['level'],
          ),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'levelId': _i1.ParameterDescription(
              name: 'levelId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'level': _i1.ParameterDescription(
              name: 'level',
              type: _i1.getType<_i16.Level>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['level'] as _i6.LevelEndpoint).update(
            session,
            params['levelId'],
            params['level'],
          ),
        ),
        'getLevels': _i1.MethodConnector(
          name: 'getLevels',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['level'] as _i6.LevelEndpoint).getLevels(session),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'levelId': _i1.ParameterDescription(
              name: 'levelId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['level'] as _i6.LevelEndpoint).delete(
            session,
            params['levelId'],
          ),
        ),
      },
    );
    connectors['questionCategory'] = _i1.EndpointConnector(
      name: 'questionCategory',
      endpoint: endpoints['questionCategory']!,
      methodConnectors: {
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'questioncategory': _i1.ParameterDescription(
              name: 'questioncategory',
              type: _i1.getType<_i17.QuestionCategory>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['questionCategory'] as _i7.QuestionCategoryEndpoint)
                  .create(
            session,
            params['questioncategory'],
          ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'questioncategoryId': _i1.ParameterDescription(
              name: 'questioncategoryId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['questionCategory'] as _i7.QuestionCategoryEndpoint)
                  .delete(
            session,
            params['questioncategoryId'],
          ),
        ),
        'getQuestionCategory': _i1.MethodConnector(
          name: 'getQuestionCategory',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['questionCategory'] as _i7.QuestionCategoryEndpoint)
                  .getQuestionCategory(session),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'questCatId': _i1.ParameterDescription(
              name: 'questCatId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'questionCat': _i1.ParameterDescription(
              name: 'questionCat',
              type: _i1.getType<_i17.QuestionCategory>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['questionCategory'] as _i7.QuestionCategoryEndpoint)
                  .update(
            session,
            params['questCatId'],
            params['questionCat'],
          ),
        ),
      },
    );
    connectors['question'] = _i1.EndpointConnector(
      name: 'question',
      endpoint: endpoints['question']!,
      methodConnectors: {
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'question': _i1.ParameterDescription(
              name: 'question',
              type: _i1.getType<_i18.Question>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['question'] as _i8.QuestionEndpoint).create(
            session,
            params['question'],
          ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'questionId': _i1.ParameterDescription(
              name: 'questionId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['question'] as _i8.QuestionEndpoint).delete(
            session,
            params['questionId'],
          ),
        ),
        'getQuestion': _i1.MethodConnector(
          name: 'getQuestion',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['question'] as _i8.QuestionEndpoint)
                  .getQuestion(session),
        ),
        'updateQuestion': _i1.MethodConnector(
          name: 'updateQuestion',
          params: {
            'questId': _i1.ParameterDescription(
              name: 'questId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'question': _i1.ParameterDescription(
              name: 'question',
              type: _i1.getType<_i18.Question>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['question'] as _i8.QuestionEndpoint).updateQuestion(
            session,
            params['questId'],
            params['question'],
          ),
        ),
      },
    );
    connectors['response'] = _i1.EndpointConnector(
      name: 'response',
      endpoint: endpoints['response']!,
      methodConnectors: {
        'saveResponse': _i1.MethodConnector(
          name: 'saveResponse',
          params: {
            'response': _i1.ParameterDescription(
              name: 'response',
              type: _i1.getType<_i19.Response>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['response'] as _i9.ResponseEndpoint).saveResponse(
            session,
            params['response'],
          ),
        ),
        'updateResponseInfo': _i1.MethodConnector(
          name: 'updateResponseInfo',
          params: {
            'assigneeId': _i1.ParameterDescription(
              name: 'assigneeId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'statusId': _i1.ParameterDescription(
              name: 'statusId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'reviewerId': _i1.ParameterDescription(
              name: 'reviewerId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'score': _i1.ParameterDescription(
              name: 'score',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'responseId': _i1.ParameterDescription(
              name: 'responseId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['response'] as _i9.ResponseEndpoint)
                  .updateResponseInfo(
            session,
            params['assigneeId'],
            params['statusId'],
            params['reviewerId'],
            params['score'],
            params['responseId'],
          ),
        ),
        'getAllResponses': _i1.MethodConnector(
          name: 'getAllResponses',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['response'] as _i9.ResponseEndpoint)
                  .getAllResponses(session),
        ),
        'deleteResponse': _i1.MethodConnector(
          name: 'deleteResponse',
          params: {
            'responseId': _i1.ParameterDescription(
              name: 'responseId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['response'] as _i9.ResponseEndpoint).deleteResponse(
            session,
            params['responseId'],
          ),
        ),
      },
    );
    connectors['role'] = _i1.EndpointConnector(
      name: 'role',
      endpoint: endpoints['role']!,
      methodConnectors: {
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'role': _i1.ParameterDescription(
              name: 'role',
              type: _i1.getType<_i20.Role>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['role'] as _i10.RoleEndpoint).create(
            session,
            params['role'],
          ),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'roleId': _i1.ParameterDescription(
              name: 'roleId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'newRole': _i1.ParameterDescription(
              name: 'newRole',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['role'] as _i10.RoleEndpoint).update(
            session,
            params['roleId'],
            params['newRole'],
          ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'roleId': _i1.ParameterDescription(
              name: 'roleId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['role'] as _i10.RoleEndpoint).delete(
            session,
            params['roleId'],
          ),
        ),
        'getRoles': _i1.MethodConnector(
          name: 'getRoles',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['role'] as _i10.RoleEndpoint).getRoles(session),
        ),
      },
    );
    connectors['status'] = _i1.EndpointConnector(
      name: 'status',
      endpoint: endpoints['status']!,
      methodConnectors: {
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i21.Status>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['status'] as _i11.StatusEndpoint).create(
            session,
            params['status'],
          ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'statusId': _i1.ParameterDescription(
              name: 'statusId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['status'] as _i11.StatusEndpoint).delete(
            session,
            params['statusId'],
          ),
        ),
        'getStatus': _i1.MethodConnector(
          name: 'getStatus',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['status'] as _i11.StatusEndpoint).getStatus(session),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'statusId': _i1.ParameterDescription(
              name: 'statusId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i21.Status>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['status'] as _i11.StatusEndpoint).update(
            session,
            params['statusId'],
            params['status'],
          ),
        ),
      },
    );
    connectors['user'] = _i1.EndpointConnector(
      name: 'user',
      endpoint: endpoints['user']!,
      methodConnectors: {
        'register': _i1.MethodConnector(
          name: 'register',
          params: {
            'user': _i1.ParameterDescription(
              name: 'user',
              type: _i1.getType<_i22.User>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i12.UserEndpoint).register(
            session,
            params['user'],
          ),
        ),
        'login': _i1.MethodConnector(
          name: 'login',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i12.UserEndpoint).login(
            session,
            params['email'],
            params['password'],
          ),
        ),
        'getUsers': _i1.MethodConnector(
          name: 'getUsers',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i12.UserEndpoint).getUsers(session),
        ),
        'updateUser': _i1.MethodConnector(
          name: 'updateUser',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'user': _i1.ParameterDescription(
              name: 'user',
              type: _i1.getType<_i22.User>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i12.UserEndpoint).updateUser(
            session,
            params['userId'],
            params['user'],
          ),
        ),
        'deleteUser': _i1.MethodConnector(
          name: 'deleteUser',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i12.UserEndpoint).deleteUser(
            session,
            params['userId'],
          ),
        ),
        'getSingleUser': _i1.MethodConnector(
          name: 'getSingleUser',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i12.UserEndpoint).getSingleUser(
            session,
            params['userId'],
          ),
        ),
        'verifyToken': _i1.MethodConnector(
          name: 'verifyToken',
          params: {
            'tokenData': _i1.ParameterDescription(
              name: 'tokenData',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i12.UserEndpoint).verifyToken(
            session,
            params['tokenData'],
          ),
        ),
      },
    );
  }
}
