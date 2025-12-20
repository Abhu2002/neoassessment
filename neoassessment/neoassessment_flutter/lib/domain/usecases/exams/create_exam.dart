import 'package:neoassessment_flutter/core/resources/data_state.dart';
import 'package:neoassessment_flutter/core/usecases/usecase.dart';
import 'package:neoassessment_flutter/domain/entities/exams/exam_entity.dart';
import 'package:neoassessment_flutter/domain/repositories/exams/exam_repository.dart';

class CreateExamUseCase extends UseCase<DataState<dynamic>, ExamEntity> {
  final ExamRepository _examRepository;

  CreateExamUseCase(this._examRepository);

  @override
  Future<DataState> call({ExamEntity? params}) {
    final response = _examRepository.createExam(params!);
    return response;
  }
}
