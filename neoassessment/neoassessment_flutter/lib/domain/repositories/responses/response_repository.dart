import 'package:neoassessment_flutter/domain/entities/response/response_entity.dart';

import '../../../core/resources/data_state.dart';

abstract class ResponseRepository {
  Future<DataState<String>> saveResponse(ResponseEntity responseEntity);

  Future<DataState<List<ResponseEntity>>> getResponses();

  Future<DataState<String>> deleteResponse(ResponseEntity responseEntity);

  Future<DataState<String>> updateResponse(ResponseEntity responseEntity);
}
