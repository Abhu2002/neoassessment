import 'package:neoassessment_flutter/core/usecases/usecase.dart';
import 'package:neoassessment_flutter/domain/repositories/responses/response_repository.dart';

import '../../../core/resources/data_state.dart';

class GetResponsesUseCase extends UseCase<DataState<dynamic>,void> {
  final ResponseRepository _responseRepository;

  GetResponsesUseCase(this._responseRepository);

  @override
  Future<DataState> call({void params}) {
    final response = _responseRepository.getResponses();
    return response;
  }

}