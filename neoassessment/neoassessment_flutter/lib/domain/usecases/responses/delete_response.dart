import 'package:neoassessment_flutter/core/resources/data_state.dart';
import 'package:neoassessment_flutter/domain/entities/response/response_entity.dart';
import 'package:neoassessment_flutter/domain/repositories/responses/response_repository.dart';

import '../../../core/usecases/usecase.dart';

class DeleteResponseUseCase extends UseCase<DataState<dynamic>, ResponseEntity> {
  final ResponseRepository _responseRepository;

  DeleteResponseUseCase(this._responseRepository);

  @override
  Future<DataState> call({ResponseEntity? params}) {
    final response = _responseRepository.deleteResponse(params!);
    return response;
  }

}