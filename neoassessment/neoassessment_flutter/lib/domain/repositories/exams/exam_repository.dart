import 'package:neoassessment_flutter/core/resources/data_state.dart';
import 'package:neoassessment_flutter/domain/entities/exams/exam_entity.dart';

abstract class ExamRepository {
  Future<DataState<String>> createExam(ExamEntity examEntity);

  Future<DataState<List<ExamEntity>>> getExams();

  Future <DataState<String>>  deleteExams(ExamEntity examEntity);
}