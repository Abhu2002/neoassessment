import 'package:neoassessment_flutter/domain/repositories/candidates/candidate_repository.dart';

import '../../../core/resources/data_state.dart';
import '../../../core/usecases/usecase.dart';

class GetSingleCandidateUseCase extends UseCase<DataState<dynamic>, int> {
  final CandidateRepository _candidateRepository;

  GetSingleCandidateUseCase(this._candidateRepository);

  @override
  Future<DataState> call({int? params}) {
    final response = _candidateRepository.getSingleCandidate(params!);
    return response;
  }

}