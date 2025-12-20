import 'package:neoassessment_flutter/core/resources/data_state.dart';
import 'package:neoassessment_flutter/domain/repositories/status/status_repository.dart';

import '../../../core/usecases/usecase.dart';

class GetStatusUseCase extends UseCase<DataState<dynamic>, void> {
  final StatusRepository _statusRepository;

  GetStatusUseCase(this._statusRepository);

  @override
  Future<DataState> call({void params}) {
    final response = _statusRepository.getStatus();
    return response;
  }
}
