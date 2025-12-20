import '../../../core/resources/data_state.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/questions/questions_entity.dart';
import '../../repositories/questions/questions_repository.dart';

class UpdateQuestionUseCase
    extends UseCase<DataState<dynamic>, QuestionEntity> {
  final QuestionsRepository _questionsRepository;

  UpdateQuestionUseCase(this._questionsRepository);

  @override
  Future<DataState<dynamic>> call({QuestionEntity? params}) {
    final result = _questionsRepository.updateQuestion(params!);
    return result;
  }
}
