import 'package:neoassessment_flutter/core/usecases/usecase.dart';
import 'package:neoassessment_flutter/domain/repositories/candidates/candidate_repository.dart';

import '../../../core/resources/data_state.dart';

class DeleteCandidateUseCase extends UseCase<DataState<dynamic>, int> {
  final CandidateRepository _candidateRepository;

  DeleteCandidateUseCase(this._candidateRepository);

  @override
  Future<DataState> call({int? params}) {
    final response = _candidateRepository.deleteCandidate(params!);
    return response;
  }
}
