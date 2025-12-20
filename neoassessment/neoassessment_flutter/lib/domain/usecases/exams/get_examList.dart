import 'package:neoassessment_flutter/core/usecases/usecase.dart';
import '../../../core/resources/data_state.dart';
import '../../repositories/exams/exam_repository.dart';

class  GetExamListUseCase implements UseCase<DataState<dynamic>,void>{
  final ExamRepository _examRepository;

  GetExamListUseCase(this._examRepository);

  @override

  Future<DataState<dynamic>>  call({void params}){
    final result = _examRepository.getExams();
    return result;
  }
}