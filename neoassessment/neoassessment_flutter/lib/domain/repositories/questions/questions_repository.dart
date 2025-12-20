import 'package:neoassessment_flutter/domain/entities/questions/questions_entity.dart';

import '../../../core/resources/data_state.dart';

abstract class QuestionsRepository {
  Future<DataState<List<QuestionEntity>>> getQuestions();

  Future<DataState<String>> deleteQuestion(QuestionEntity questionEntity);

  Future<DataState<String>> createQuestion(QuestionEntity questionEntity);

  Future<DataState<String>> updateQuestion(QuestionEntity questionEntity);
}
