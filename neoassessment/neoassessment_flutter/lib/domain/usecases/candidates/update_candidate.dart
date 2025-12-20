import 'package:neoassessment_flutter/core/resources/data_state.dart';
import 'package:neoassessment_flutter/domain/entities/candidates/candidate_entity.dart';
import 'package:neoassessment_flutter/domain/repositories/candidates/candidate_repository.dart';

import '../../../core/usecases/usecase.dart';

class UpdateCandidateUseCase
    extends UseCase<DataState<dynamic>, CandidateEntity> {
  final CandidateRepository _candidateRepository;

  UpdateCandidateUseCase(this._candidateRepository);

  @override
  Future<DataState> call({CandidateEntity? params}) {
    final response = _candidateRepository.updateCandidate(params!);
    return response;
  }
}
