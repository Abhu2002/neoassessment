import 'package:neoassessment_flutter/core/usecases/usecase.dart';
import 'package:neoassessment_flutter/domain/repositories/responses/response_repository.dart';

import '../../../core/resources/data_state.dart';

class SaveResponseUseCase extends UseCase<DataState<dynamic>, dynamic> {
  final ResponseRepository _responseRepository;

  SaveResponseUseCase(this._responseRepository);

  @override
  Future<DataState<dynamic>> call({params}) {
    final response = _responseRepository.saveResponse(params!);
    return response;
  }
}
