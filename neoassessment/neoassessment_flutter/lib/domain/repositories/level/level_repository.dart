import 'package:neoassessment_flutter/core/resources/data_state.dart';
import 'package:neoassessment_flutter/domain/entities/level/level_entity.dart';

abstract class LevelRepository {
  Future<DataState<List<LevelEntity>>> getLevels();

  Future<DataState<String>> createLevels(LevelEntity level);

  Future<DataState<String>> deleteLevels(LevelEntity level);

  Future<DataState<String>> updateLevels(LevelEntity level);
}
