import 'package:neoassessment_flutter/domain/repositories/questions/questions_repository.dart';

import '../../../core/resources/data_state.dart';
import '../../../core/usecases/usecase.dart';

class GetQuestionsUseCase implements UseCase<DataState<dynamic>, void> {
  final QuestionsRepository _questionsRepository;

  GetQuestionsUseCase(this._questionsRepository);

  @override
  Future<DataState<dynamic>> call({void params}) {
    final result = _questionsRepository.getQuestions();
    return result;
  }
}
