import 'package:neoassessment_flutter/core/resources/data_state.dart';
import 'package:neoassessment_flutter/domain/entities/response/response_entity.dart';
import 'package:neoassessment_flutter/domain/repositories/responses/response_repository.dart';

import '../../../core/usecases/usecase.dart';

class UpdateResponseUseCase extends UseCase<DataState<dynamic>, ResponseEntity> {
  final ResponseRepository _responseRepository;

  UpdateResponseUseCase(this._responseRepository);

  @override
  Future<DataState> call({ResponseEntity? params}) {
    final response = _responseRepository.updateResponse(params!);
    return response;
  }

}