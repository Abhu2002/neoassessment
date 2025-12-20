import 'package:neoassessment_flutter/domain/entities/questions/questions_entity.dart';
import 'package:neoassessment_flutter/domain/repositories/questions/questions_repository.dart';

import '../../../core/resources/data_state.dart';
import '../../../core/usecases/usecase.dart';

class DeleteQuestionUseCase
    extends UseCase<DataState<dynamic>, QuestionEntity> {
  final QuestionsRepository _questionsRepository;

  DeleteQuestionUseCase(this._questionsRepository);

  @override
  Future<DataState<dynamic>> call({QuestionEntity? params}) {
    final result = _questionsRepository.deleteQuestion(params!);
    return result;
  }
}
