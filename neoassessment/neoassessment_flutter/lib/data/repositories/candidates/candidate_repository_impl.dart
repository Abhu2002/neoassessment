import 'package:dio/dio.dart';
import 'package:neoassessment_flutter/core/resources/data_state.dart';
import 'package:neoassessment_flutter/data/data_sources/remote/candidates/candidate_api_service.dart';
import 'package:neoassessment_flutter/domain/entities/candidates/candidate_entity.dart';
import 'package:neoassessment_flutter/domain/repositories/candidates/candidate_repository.dart';

class CandidateRepoImpl extends CandidateRepository {
  final CandidateApiService _candidateApiService;

  CandidateRepoImpl(this._candidateApiService);

  @override
  Future<DataState<String>> deleteCandidate(int id) async {
    try {
      final response = await _candidateApiService.deleteCandidate(id);

      if (response.data['status'] == 200) {
        return DataSuccess(response.data['message'], response.data['user_msg']);
      } else {
        return DataFailed(response.data['user_msg']);
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<CandidateEntity>>> getCandidates() async {
    try {
      final response = await _candidateApiService.getCandidates();

      if (response.data['status'] == 200) {
        List<CandidateEntity> result = [];

        for (var res in response.data["body"]) {
          result.add(CandidateEntity.fromJson(res));
        }

        return DataSuccess(result, response.data['user_msg']);
      } else {
        return DataFailed(
          DioException(
            requestOptions: response.requestOptions,
            message: response.data['message'],
            error: response.data['status'],
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<CandidateEntity>> loginCandidate(
      CandidateEntity candidateEntity) async {
    try {
      final response =
          await _candidateApiService.loginCandidate(candidateEntity);
      if (response.data['status'] == 200) {
        var body = response.data['body'];
        CandidateEntity candidateEntity = CandidateEntity.fromJson(body);

        return DataSuccess(candidateEntity, response.data['user_msg']);
      } else {
        return DataFailed(
          DioException(
            requestOptions: response.requestOptions,
            message: response.data['message'],
            error: response.data['status'],
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<String>> registerCandidate(
      CandidateEntity candidateEntity) async {
    try {
      final response =
          await _candidateApiService.registerCandidate(candidateEntity);
      if (response.data['status'] == 200) {
        return DataSuccess(response.data['message'], response.data['user_msg']);
      } else {
        return DataFailed(
          DioException(
            requestOptions: response.requestOptions,
            message: response.data['message'],
            error: response.data['status'],
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<String>> updateCandidate(
      CandidateEntity candidateEntity) async {
    try {
      final response =
          await _candidateApiService.updateCandidate(candidateEntity);

      if (response.data['status'] == 200) {
        return DataSuccess(response.data['message'], response.data['user_msg']);
      } else {
        return DataFailed(
          DioException(
            requestOptions: response.requestOptions,
            message: response.data['message'],
            error: response.data['status'],
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<CandidateEntity>> getSingleCandidate(int candidateId) async {
    try {
      final response =
          await _candidateApiService.getSingleCandidate(candidateId);
      if (response.data['status'] == 200) {
        return DataSuccess(response.data['body'], response.data['user_msg']);
      } else {
        return DataFailed(
          DioException(
            requestOptions: response.requestOptions,
            error: response.data['user_msg'],
            message: response.data['message'],
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
