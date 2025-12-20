import 'package:neoassessment_flutter/core/resources/data_state.dart';
import 'package:neoassessment_flutter/core/usecases/usecase.dart';
import 'package:neoassessment_flutter/domain/repositories/domains/domains_repository.dart';

class GetDomainsUseCase implements UseCase<DataState<dynamic>, void> {
  final DomainRepository _domainRepository;

  GetDomainsUseCase(this._domainRepository);

  @override
  Future<DataState<dynamic>> call({void params}) {
    final result = _domainRepository.getDomains();
    return result;
  }
}
