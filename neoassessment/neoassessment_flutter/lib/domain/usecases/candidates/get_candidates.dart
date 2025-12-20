import 'package:neoassessment_flutter/core/resources/data_state.dart';
import 'package:neoassessment_flutter/core/usecases/usecase.dart';
import 'package:neoassessment_flutter/domain/repositories/candidates/candidate_repository.dart';

class GetCandidatesUseCase extends UseCase<DataState<dynamic>, void> {
  final CandidateRepository _candidateRepository;

  GetCandidatesUseCase(this._candidateRepository);

  @override
  Future<DataState> call({void params}) {
    final response = _candidateRepository.getCandidates();
    return response;
  }
}
