import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:neoassessment_flutter/data/data_sources/remote/candidates/candidate_api_service.dart';
import 'package:neoassessment_flutter/data/data_sources/remote/exams/exams_api_service.dart';
import 'package:neoassessment_flutter/data/data_sources/remote/level/level_api_service.dart';
import 'package:neoassessment_flutter/data/data_sources/remote/question_category/question_category_api_service.dart';
import 'package:neoassessment_flutter/data/data_sources/remote/questions/question_api_service.dart';
import 'package:neoassessment_flutter/data/data_sources/remote/responses/response_api_service.dart';
import 'package:neoassessment_flutter/data/data_sources/remote/roles/roles_api_service.dart';
import 'package:neoassessment_flutter/data/data_sources/remote/status/status_api_service.dart';
import 'package:neoassessment_flutter/data/data_sources/remote/users/users_api_service.dart';
import 'package:neoassessment_flutter/data/repositories/candidates/candidate_repository_impl.dart';
import 'package:neoassessment_flutter/data/repositories/exams/exam_repository_impl.dart';
import 'package:neoassessment_flutter/data/repositories/level/level_repository_impl.dart';
import 'package:neoassessment_flutter/data/repositories/questionCat/questionCat_repository_impl.dart';
import 'package:neoassessment_flutter/data/repositories/questions/questions_repository_impl.dart';
import 'package:neoassessment_flutter/data/repositories/roles/roles_repository_impl.dart';
import 'package:neoassessment_flutter/data/repositories/users/users_repository_impl.dart';
import 'package:neoassessment_flutter/domain/repositories/candidates/candidate_repository.dart';
import 'package:neoassessment_flutter/domain/repositories/exams/exam_repository.dart';
import 'package:neoassessment_flutter/domain/repositories/level/level_repository.dart';
import 'package:neoassessment_flutter/domain/repositories/questionCat/questionCat_repository.dart';
import 'package:neoassessment_flutter/domain/repositories/questions/questions_repository.dart';
import 'package:neoassessment_flutter/domain/repositories/responses/response_repository.dart';
import 'package:neoassessment_flutter/domain/repositories/roles/roles_repository.dart';
import 'package:neoassessment_flutter/domain/repositories/status/status_repository.dart';
import 'package:neoassessment_flutter/domain/usecases/candidates/delete_candidate.dart';
import 'package:neoassessment_flutter/domain/usecases/candidates/get_candidates.dart';
import 'package:neoassessment_flutter/domain/usecases/candidates/login_candidate.dart';
import 'package:neoassessment_flutter/domain/usecases/candidates/register_candidate.dart';
import 'package:neoassessment_flutter/domain/usecases/candidates/update_candidate.dart';
import 'package:neoassessment_flutter/domain/usecases/domains/create_domain.dart';
import 'package:neoassessment_flutter/domain/usecases/domains/delete_domain.dart';
import 'package:neoassessment_flutter/domain/usecases/domains/get_domains.dart';
import 'package:neoassessment_flutter/domain/usecases/domains/update_domain.dart';
import 'package:neoassessment_flutter/domain/usecases/exams/create_exam.dart';
import 'package:neoassessment_flutter/domain/usecases/exams/delete_exam.dart';
import 'package:neoassessment_flutter/domain/usecases/exams/get_examList.dart';
import 'package:neoassessment_flutter/domain/usecases/level/create_levels.dart';
import 'package:neoassessment_flutter/domain/usecases/level/delete_levels.dart';
import 'package:neoassessment_flutter/domain/usecases/level/get_levels.dart';
import 'package:neoassessment_flutter/domain/usecases/level/updateLevels.dart';
import 'package:neoassessment_flutter/domain/usecases/questionCat/create_questionCat.dart';
import 'package:neoassessment_flutter/domain/usecases/questionCat/delete_questionCat.dart';
import 'package:neoassessment_flutter/domain/usecases/questionCat/get_questionCat.dart';
import 'package:neoassessment_flutter/domain/usecases/questionCat/update_questionCat.dart';
import 'package:neoassessment_flutter/domain/usecases/questions/create_question.dart';
import 'package:neoassessment_flutter/domain/usecases/questions/delete_question.dart';
import 'package:neoassessment_flutter/domain/usecases/questions/get_questions.dart';
import 'package:neoassessment_flutter/domain/usecases/questions/update_question.dart';
import 'package:neoassessment_flutter/domain/usecases/responses/delete_response.dart';
import 'package:neoassessment_flutter/domain/usecases/responses/get_responses.dart';
import 'package:neoassessment_flutter/domain/usecases/responses/save_response.dart';
import 'package:neoassessment_flutter/domain/usecases/responses/update_response.dart';
import 'package:neoassessment_flutter/domain/usecases/roles/create_roles.dart';
import 'package:neoassessment_flutter/domain/usecases/roles/delete_roles.dart';
import 'package:neoassessment_flutter/domain/usecases/roles/get_roles.dart';
import 'package:neoassessment_flutter/domain/usecases/roles/update_roles.dart';
import 'package:neoassessment_flutter/domain/usecases/status/create_status.dart';
import 'package:neoassessment_flutter/domain/usecases/status/delete_status.dart';
import 'package:neoassessment_flutter/domain/usecases/status/get_status.dart';
import 'package:neoassessment_flutter/domain/usecases/status/update_status.dart';
import 'package:neoassessment_flutter/domain/usecases/users/delete_user.dart';
import 'package:neoassessment_flutter/domain/usecases/users/get_single_user.dart';
import 'package:neoassessment_flutter/domain/usecases/users/get_users.dart';
import 'package:neoassessment_flutter/domain/usecases/users/login_user.dart';
import 'package:neoassessment_flutter/domain/usecases/users/register_user.dart';
import 'package:neoassessment_flutter/domain/usecases/users/update_users.dart';
import 'package:neoassessment_flutter/domain/usecases/users/verify_token.dart';
import 'package:neoassessment_flutter/presentation/bloc/candidiates/remote_candidates_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/domains/remote_domains_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/exams/remote_exam_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/levels/remote_levels_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/questionCat/remote_questionCat_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/questions/remote_questions_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/responses/remote_response_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/roles/remote_roles_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/status/remote_status_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/users/remote_users_bloc.dart';
import 'package:neoassessment_flutter/presentation/widgets/navbar/navbar_bloc.dart';

import 'data/data_sources/remote/domains/domains_api_service.dart';
import 'data/repositories/domains/domains_repository_impl.dart';
import 'data/repositories/responses/response_repository_impl.dart';
import 'data/repositories/status/status_repo_impl.dart';
import 'domain/repositories/domains/domains_repository.dart';
import 'domain/repositories/users/users_repository.dart';
import 'domain/usecases/candidates/get_single_candidate.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio
  sl.registerSingleton<Dio>(Dio());

  // api services
  sl.registerSingleton<RolesApiService>(RoleApiServiceImpl(sl()));
  sl.registerSingleton<UsersApiService>(UsersApiServiceImpl(sl()));
  sl.registerSingleton<DomainsApiService>(DomainsApiServiceImpl(sl()));
  sl.registerSingleton<LevelApiService>(LevelApiServiceImpl(sl()));
  sl.registerSingleton<QuestionApiService>(QuestionApiServiceImpl(sl()));
  sl.registerSingleton<QuestionCategoryApiService>(
      QuestionCategoryApiServiceImpl(sl()));
  sl.registerSingleton<ExamApiService>(ExamApiServiceImpl(sl()));
  sl.registerSingleton<CandidateApiService>(CandidateApiServiceImpl(sl()));
  sl.registerSingleton<ResponseApiService>(ResponseApiServiceImpl(sl()));
  sl.registerSingleton<StatusApiService>(StatusApiServiceImpl(sl()));

  // repositories
  sl.registerSingleton<RolesRepository>(RolesRepositoryImpl(sl()));
  sl.registerSingleton<UsersRepository>(UsersRepositoryImpl(sl()));
  sl.registerSingleton<DomainRepository>(DomainsRepositoryImpl(sl()));
  sl.registerSingleton<LevelRepository>(LevelRepositoryImpl(sl()));
  sl.registerSingleton<QuestionCategoryRepository>(
      QuestionCatRepositoryImpl(sl()));
  sl.registerSingleton<QuestionsRepository>(QuestionsRepositoryImpl(sl()));
  sl.registerSingleton<ExamRepository>(ExamRepositoryImpl(sl()));
  sl.registerSingleton<CandidateRepository>(CandidateRepoImpl(sl()));
  sl.registerSingleton<ResponseRepository>(ResponseRepoImpl(sl()));
  sl.registerSingleton<StatusRepository>(StatusRepoImpl(sl()));

  // usecases
  sl.registerSingleton<GetRolesUseCase>(GetRolesUseCase(sl()));
  sl.registerSingleton<LoginUserUseCase>(LoginUserUseCase(sl()));
  sl.registerSingleton<CreateRoleUseCase>(CreateRoleUseCase(sl()));
  sl.registerSingleton<DeleteRoleUsecase>(DeleteRoleUsecase(sl()));
  sl.registerSingleton<UpdateRoleUsecase>(UpdateRoleUsecase(sl()));
  sl.registerSingleton<GetDomainsUseCase>(GetDomainsUseCase(sl()));
  sl.registerSingleton<CreateDomainUseCase>(CreateDomainUseCase(sl()));
  sl.registerSingleton<UpdateDomainUseCase>(UpdateDomainUseCase(sl()));
  sl.registerSingleton<DeleteDomainUseCase>(DeleteDomainUseCase(sl()));
  sl.registerSingleton<GetLevelsUseCase>(GetLevelsUseCase(sl()));
  sl.registerSingleton<CreateLevelUseCase>(CreateLevelUseCase(sl()));
  sl.registerSingleton<DeleteLevelsUseCase>(DeleteLevelsUseCase(sl()));
  sl.registerSingleton<UpdateLevelsUseCase>(UpdateLevelsUseCase(sl()));

  sl.registerSingleton<GetUsersUseCase>(GetUsersUseCase(sl()));
  sl.registerSingleton<RegisterUserUseCase>(RegisterUserUseCase(sl()));
  sl.registerSingleton<DeleteUserUseCase>(DeleteUserUseCase(sl()));
  sl.registerSingleton<UpdateUsersUseCase>(UpdateUsersUseCase(sl()));
  sl.registerSingleton<GetSingleUserUseCase>(GetSingleUserUseCase(sl()));
  sl.registerSingleton<GetQuestionsUseCase>(GetQuestionsUseCase(sl()));
  sl.registerSingleton<TokenUserUseCase>(TokenUserUseCase(sl()));
  sl.registerSingleton<DeleteQuestionUseCase>(DeleteQuestionUseCase(sl()));
  sl.registerSingleton<CreateQuestionUseCase>(CreateQuestionUseCase(sl()));
  sl.registerSingleton<UpdateQuestionUseCase>(UpdateQuestionUseCase(sl()));
  sl.registerSingleton<GetQuestionCatUseCase>(GetQuestionCatUseCase(sl()));

  sl.registerSingleton<DeleteQuestionCatUseCase>(
      DeleteQuestionCatUseCase(sl()));
  sl.registerSingleton<CreateQuestionCatUseCase>(
      CreateQuestionCatUseCase(sl()));
  sl.registerSingleton<UpdateQuestionCatUseCase>(
      UpdateQuestionCatUseCase(sl()));
  sl.registerSingleton<CreateExamUseCase>(CreateExamUseCase(sl()));
  sl.registerSingleton<GetCandidatesUseCase>(GetCandidatesUseCase(sl()));
  sl.registerSingleton<RegisterCandidateUseCase>(
      RegisterCandidateUseCase(sl()));
  sl.registerSingleton<UpdateCandidateUseCase>(UpdateCandidateUseCase(sl()));
  sl.registerSingleton<DeleteCandidateUseCase>(DeleteCandidateUseCase(sl()));
  sl.registerSingleton<GetSingleCandidateUseCase>(
      GetSingleCandidateUseCase(sl()));
  sl.registerSingleton<LoginCandidateUseCase>(LoginCandidateUseCase(sl()));
  sl.registerSingleton<GetExamListUseCase>(GetExamListUseCase(sl()));
  sl.registerSingleton<DeleteExamUseCase>(DeleteExamUseCase(sl()));
  sl.registerSingleton<SaveResponseUseCase>(SaveResponseUseCase(sl()));
  sl.registerSingleton<GetResponsesUseCase>(GetResponsesUseCase(sl()));
  sl.registerSingleton<UpdateResponseUseCase>(UpdateResponseUseCase(sl()));
  sl.registerSingleton<DeleteResponseUseCase>(DeleteResponseUseCase(sl()));
  sl.registerSingleton<CreateStatusUseCase>(CreateStatusUseCase(sl()));
  sl.registerSingleton<GetStatusUseCase>(GetStatusUseCase(sl()));
  sl.registerSingleton<UpdateStatusUseCase>(UpdateStatusUseCase(sl()));
  sl.registerSingleton<DeleteStatusUseCase>(DeleteStatusUseCase(sl()));

  // Blocs
  sl.registerFactory<RemoteRolesBloc>(
      () => RemoteRolesBloc(sl(), sl(), sl(), sl()));
  sl.registerFactory<RemoteUsersBloc>(
      () => RemoteUsersBloc(sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl(),sl()));
  sl.registerFactory<NavbarBloc>(() => NavbarBloc());
  sl.registerFactory<RemoteLevelsBloc>(
      () => RemoteLevelsBloc(sl(), sl(), sl(), sl()));
  sl.registerFactory<RemoteDomainsBloc>(
      () => RemoteDomainsBloc(sl(), sl(), sl(), sl()));
  sl.registerFactory<RemoteStatusBloc>(
      () => RemoteStatusBloc(sl(), sl(), sl(), sl()));
  sl.registerFactory<RemoteQuestionBloc>(
      () => RemoteQuestionBloc(sl(), sl(), sl(), sl(), sl(), sl(), sl()));
  sl.registerFactory<QuestionCatBloc>(
      () => QuestionCatBloc(sl(), sl(), sl(), sl(), sl()));
  sl.registerFactory<RemoteExamBloc>(() =>
      RemoteExamBloc(sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl()));
  sl.registerFactory<RemoteCandidatesBloc>(
      () => RemoteCandidatesBloc(sl(), sl(), sl(), sl(), sl(), sl(), sl()));
  sl.registerFactory<RemoteResponseBloc>(
      () => RemoteResponseBloc(sl(), sl(), sl(), sl(), sl(), sl(), sl()));
}
