import '../../../core/resources/data_state.dart';
import '../../../core/usecases/usecase.dart';
import '../../repositories/level/level_repository.dart';

class GetLevelsUseCase implements UseCase<DataState<dynamic>, void> {
  final LevelRepository _levelRepository;

  GetLevelsUseCase(this._levelRepository);

  @override
  Future<DataState<dynamic>> call({void params}) {
    final result = _levelRepository.getLevels();
    return result;
  }
}
