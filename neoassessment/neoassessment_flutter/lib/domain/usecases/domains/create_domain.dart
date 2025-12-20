import 'package:neoassessment_flutter/core/resources/data_state.dart';
import 'package:neoassessment_flutter/core/usecases/usecase.dart';
import 'package:neoassessment_flutter/domain/entities/domains/domain_entity.dart';

import '../../repositories/domains/domains_repository.dart';

class CreateDomainUseCase extends UseCase<DataState<dynamic>, DomainEntity> {
  final DomainRepository _domainRepository;

  CreateDomainUseCase(this._domainRepository);

  @override
  Future<DataState<dynamic>> call({DomainEntity? params}) {
    final result = _domainRepository.createDomain(params!);
    return result;
  }
}
