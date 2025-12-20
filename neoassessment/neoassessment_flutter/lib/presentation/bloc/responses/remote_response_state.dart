import 'package:equatable/equatable.dart';
import 'package:neoassessment_flutter/domain/entities/candidates/candidate_entity.dart';
import 'package:neoassessment_flutter/domain/entities/exams/exam_entity.dart';

import '../../../domain/entities/response/response_entity.dart';
import '../../../domain/entities/status/status_entity.dart';
import '../../../domain/entities/users/user_entity.dart';

abstract class RemoteResponseState extends Equatable {
  const RemoteResponseState();
}

class InitialResponseState extends RemoteResponseState {
  const InitialResponseState();

  @override
  List<Object?> get props => [];
}

class AllResponsesState extends RemoteResponseState {
  final List<ResponseEntity> responses;
  final List<UserEntity> users;
  final List<CandidateEntity> candidates;
  final List<ExamEntity> exams;
  final List<StatusEntity> status;

  const AllResponsesState({
    required this.responses,
    required this.users,
    required this.candidates,
    required this.exams,
    required this.status,
  });

  @override
  List<Object?> get props => [
        responses,
        status,
        users,
        candidates,
        exams,
      ];
}

class ResponseErrorState extends RemoteResponseState {
  final String message;
  final DateTime time;

  const ResponseErrorState({
    required this.message,
    required this.time,
  });

  @override
  List<Object?> get props => [
        message,
        time,
      ];
}

class ResponseUpdatedState extends RemoteResponseState {
  final String message;
  final DateTime time;

  const ResponseUpdatedState({
    required this.message,
    required this.time,
  });

  @override
  List<Object?> get props => [message, time];
}

class ResponseDeletedState extends RemoteResponseState {
  final String message;
  final DateTime time;

  const ResponseDeletedState({required this.message, required this.time});

  @override
  List<Object?> get props => [message, time];
}
