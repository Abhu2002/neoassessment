import 'package:neoassessment_flutter/core/resources/data_state.dart';
import 'package:neoassessment_flutter/core/usecases/usecase.dart';
import 'package:neoassessment_flutter/domain/entities/questionCat/questionCat_entity.dart';
import 'package:neoassessment_flutter/domain/repositories/questionCat/questionCat_repository.dart';

class UpdateQuestionCatUseCase
    extends UseCase<DataState<dynamic>, QuestionCatEntity> {
  final QuestionCategoryRepository _questionCatRepository;

  UpdateQuestionCatUseCase(this._questionCatRepository);

  @override
  Future<DataState<dynamic>> call({QuestionCatEntity? params}) {
    final result = _questionCatRepository.updateQuestionCat(params!);
    return result;
  }
}
