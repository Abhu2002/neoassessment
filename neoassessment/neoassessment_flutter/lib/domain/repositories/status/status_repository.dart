import 'package:neoassessment_flutter/domain/entities/status/status_entity.dart';

import '../../../core/resources/data_state.dart';

abstract class StatusRepository {
  Future<DataState<String>> createStatus(StatusEntity statusEntity);
  Future<DataState<String>> updateStatus(StatusEntity statusEntity);
  Future<DataState<String>> deleteStatus(StatusEntity statusEntity);
  Future<DataState<List<StatusEntity>>> getStatus();
}