import 'package:neoassessment_flutter/core/resources/data_state.dart';
import 'package:neoassessment_flutter/core/usecases/usecase.dart';

import '../../repositories/domains/domains_repository.dart';

class DeleteDomainUseCase extends UseCase<DataState<dynamic>, int> {
  final DomainRepository _domainRepository;

  DeleteDomainUseCase(this._domainRepository);

  @override
  Future<DataState<dynamic>> call({int? params}) {
    final result = _domainRepository.deleteDomain(params!);
    return result;
  }
}
