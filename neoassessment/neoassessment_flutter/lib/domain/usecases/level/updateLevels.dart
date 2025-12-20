import 'package:neoassessment_flutter/core/resources/data_state.dart';
import 'package:neoassessment_flutter/core/usecases/usecase.dart';
import 'package:neoassessment_flutter/domain/entities/level/level_entity.dart';

import '../../repositories/level/level_repository.dart';

class UpdateLevelsUseCase extends UseCase<DataState<dynamic>, LevelEntity> {
  final LevelRepository _levelRepository;

  UpdateLevelsUseCase(this._levelRepository);

  @override
  Future<DataState<dynamic>> call({LevelEntity? params}) {
    final result = _levelRepository.updateLevels(params!);
    return result;
  }
}
