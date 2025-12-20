import 'package:dio/dio.dart';
import 'package:neoassessment_flutter/core/resources/data_state.dart';
import 'package:neoassessment_flutter/data/data_sources/remote/domains/domains_api_service.dart';
import 'package:neoassessment_flutter/data/models/domains/domain_model.dart';
import 'package:neoassessment_flutter/domain/entities/domains/domain_entity.dart';
import 'package:neoassessment_flutter/domain/repositories/domains/domains_repository.dart';

class DomainsRepositoryImpl extends DomainRepository {
  final DomainsApiService _domainsApiService;

  DomainsRepositoryImpl(this._domainsApiService);

  @override
  Future<DataState<List<DomainModel>>> getDomains() async {
    try {
      final response = await _domainsApiService.getDomains();

      if (response.data['status'] == 200) {
        List<DomainModel> result = [];
        for (var res in response.data["body"]) {
          result.add(DomainModel.fromJson(res));
        }
        return DataSuccess(result, response.data['user_msg']);
      } else {
        return DataFailed(DioException(
          requestOptions: response.requestOptions,
          message: response.data['message'],
          error: response.data['status'],
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<String>> createDomain(DomainEntity domainEntity) async {
    try {
      final response = await _domainsApiService.createDomain(
        domainEntity.name!,
        domainEntity.description!,
      );

      if (response.data['status'] == 200) {
        return DataSuccess(response.data['user_msg'], response.data['message']);
      } else {
        return DataFailed(DioException(
          requestOptions: response.requestOptions,
          message: response.data['message'],
          error: response.data['status'],
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<String>> updateDomain(DomainEntity domainEntity) async {
    try {
      final response = await _domainsApiService.updateDomain(
        domainEntity.id!,
        domainEntity.name!,
        domainEntity.description!,
      );

      if (response.data['status'] == 200) {
        return DataSuccess(response.data['user_msg'], response.data['message']);
      } else {
        return DataFailed(DioException(
          requestOptions: response.requestOptions,
          message: response.data['message'],
          error: response.data['status'],
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<String>> deleteDomain(int domainId) async {
    try {
      final response = await _domainsApiService.deleteDomain(
        domainId,
      );

      if (response.data['status'] == 200) {
        return DataSuccess(response.data['user_msg'], response.data['message']);
      } else {
        return DataFailed(DioException(
          requestOptions: response.requestOptions,
          message: response.data['message'],
          error: response.data['status'],
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
