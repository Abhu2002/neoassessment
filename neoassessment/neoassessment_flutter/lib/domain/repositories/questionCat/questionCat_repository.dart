import 'package:neoassessment_flutter/domain/entities/questionCat/questionCat_entity.dart';

import '../../../core/resources/data_state.dart';

abstract class QuestionCategoryRepository {
  Future<DataState<List<QuestionCatEntity>>> getQuestionCat();

  Future<DataState<String>> deleteQuestionCat(QuestionCatEntity questionCat);

  Future<DataState<String>> createQuestionCat(QuestionCatEntity questionCat);

  Future<DataState<String>> updateQuestionCat(QuestionCatEntity questionCat);
}
