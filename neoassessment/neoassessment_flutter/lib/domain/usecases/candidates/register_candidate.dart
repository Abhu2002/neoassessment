import 'package:neoassessment_flutter/domain/entities/candidates/candidate_entity.dart';
import 'package:neoassessment_flutter/domain/repositories/candidates/candidate_repository.dart';

import '../../../core/resources/data_state.dart';
import '../../../core/usecases/usecase.dart';

class RegisterCandidateUseCase
    extends UseCase<DataState<dynamic>, CandidateEntity> {
  final CandidateRepository _candidateRepository;

  RegisterCandidateUseCase(this._candidateRepository);

  @override
  Future<DataState> call({CandidateEntity? params}) {
    final response = _candidateRepository.registerCandidate(params!);
    return response;
  }
}
