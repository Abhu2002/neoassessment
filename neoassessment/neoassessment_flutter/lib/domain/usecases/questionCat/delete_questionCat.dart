import 'package:neoassessment_flutter/domain/entities/questionCat/questionCat_entity.dart';
import 'package:neoassessment_flutter/domain/repositories/questionCat/questionCat_repository.dart';

import '../../../core/resources/data_state.dart';
import '../../../core/usecases/usecase.dart';

class DeleteQuestionCatUseCase
    implements UseCase<DataState<dynamic>, QuestionCatEntity> {
  final QuestionCategoryRepository _questionCatRepository;

  DeleteQuestionCatUseCase(this._questionCatRepository);

  @override
  Future<DataState<dynamic>> call({QuestionCatEntity? params}) {
    final result = _questionCatRepository.deleteQuestionCat(params!);
    return result;
  }
}
