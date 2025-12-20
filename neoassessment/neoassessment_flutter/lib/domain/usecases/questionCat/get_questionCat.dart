import 'package:neoassessment_flutter/domain/repositories/questionCat/questionCat_repository.dart';

import '../../../core/resources/data_state.dart';
import '../../../core/usecases/usecase.dart';

class GetQuestionCatUseCase implements UseCase<DataState<dynamic>, void> {
  final QuestionCategoryRepository _questionCatRepository;

  GetQuestionCatUseCase(this._questionCatRepository);

  @override
  Future<DataState<dynamic>> call({void params}) {
    final result = _questionCatRepository.getQuestionCat();
    return result;
  }
}
