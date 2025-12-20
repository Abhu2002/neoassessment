import 'package:neoassessment_flutter/domain/entities/candidates/candidate_entity.dart';

import '../../../core/resources/data_state.dart';

abstract class CandidateRepository {
  Future<DataState<String>> registerCandidate(CandidateEntity candidateEntity);

  Future<DataState<CandidateEntity>> loginCandidate(
      CandidateEntity candidateEntity);

  Future<DataState<String>> updateCandidate(CandidateEntity candidateEntity);

  Future<DataState<String>> deleteCandidate(int id);

  Future<DataState<List<CandidateEntity>>> getCandidates();
  Future<DataState<CandidateEntity>> getSingleCandidate(int candidateId);
}
