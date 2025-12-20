import 'package:neoassessment_flutter/core/usecases/usecase.dart';

import '../../../core/resources/data_state.dart';
import '../../entities/level/level_entity.dart';
import '../../repositories/level/level_repository.dart';

class CreateLevelUseCase implements UseCase<DataState<dynamic>, LevelEntity> {
  final LevelRepository _levelsRepository;

  CreateLevelUseCase(this._levelsRepository);

  @override
  Future<DataState<dynamic>> call({LevelEntity? params}) {
    final result = _levelsRepository.createLevels(params!);
    return result;
  }
}
