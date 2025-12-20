import 'package:neoassessment_flutter/domain/entities/domains/domain_entity.dart';

import '../../../core/resources/data_state.dart';

abstract class DomainRepository {
  Future<DataState<List<DomainEntity>>> getDomains();

  Future<DataState<String>> createDomain(DomainEntity domainEntity);

  Future<DataState<String>> updateDomain(DomainEntity domainEntity);

  Future<DataState<String>> deleteDomain(int domainId);
}
