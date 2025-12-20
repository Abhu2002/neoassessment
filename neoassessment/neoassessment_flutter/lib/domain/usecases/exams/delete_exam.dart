import 'package:neoassessment_flutter/domain/repositories/exams/exam_repository.dart';

import '../../../core/resources/data_state.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/exams/exam_entity.dart';

class DeleteExamUseCase extends UseCase<DataState<dynamic>, ExamEntity> {
  final ExamRepository _examRepository;

  DeleteExamUseCase(this._examRepository);

  @override
  Future<DataState<dynamic>> call({ExamEntity? params}) {
    final result = _examRepository.deleteExams(params!);
    return result;
  }
}