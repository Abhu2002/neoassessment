import 'package:neoassessment_flutter/domain/entities/status/status_entity.dart';
import 'package:neoassessment_flutter/domain/repositories/status/status_repository.dart';

import '../../../core/resources/data_state.dart';
import '../../../core/usecases/usecase.dart';

class DeleteStatusUseCase extends UseCase<DataState<dynamic>, StatusEntity> {
  final StatusRepository _statusRepository;

  DeleteStatusUseCase(this._statusRepository);
  @override
  Future<DataState> call({StatusEntity? params}) {
    final response = _statusRepository.deleteStatus(params!);
    return response;
  }

}