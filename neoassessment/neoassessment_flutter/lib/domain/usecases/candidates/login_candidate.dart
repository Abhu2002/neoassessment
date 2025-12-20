import 'package:neoassessment_flutter/core/resources/data_state.dart';
import 'package:neoassessment_flutter/domain/entities/candidates/candidate_entity.dart';
import 'package:neoassessment_flutter/domain/repositories/candidates/candidate_repository.dart';

import '../../../core/usecases/usecase.dart';

class LoginCandidateUseCase
    extends UseCase<DataState<dynamic>, CandidateEntity> {
  final CandidateRepository _candidateRepository;

  LoginCandidateUseCase(this._candidateRepository);

  @override
  Future<DataState> call({CandidateEntity? params}) {
    final response = _candidateRepository.loginCandidate(params!);
    return response;
  }
}
