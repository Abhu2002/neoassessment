import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoassessment_flutter/domain/entities/candidates/candidate_entity.dart';
import 'package:neoassessment_flutter/domain/entities/exams/exam_entity.dart';
import 'package:neoassessment_flutter/domain/entities/response/response_entity.dart';
import 'package:neoassessment_flutter/domain/entities/users/user_entity.dart';
import 'package:neoassessment_flutter/presentation/bloc/responses/remote_response_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/responses/remote_response_event.dart';
import 'package:neoassessment_flutter/presentation/bloc/responses/remote_response_state.dart';
import 'package:neoassessment_flutter/presentation/pages/response/delete_response_widget.dart';
import 'package:neoassessment_flutter/presentation/pages/response/update_response_widget.dart';

import '../../../domain/entities/status/status_entity.dart';
import '../../widgets/modal.dart';

/// Example without a datasource
class Responses extends StatefulWidget {
  const Responses({super.key});

  @override
  State<Responses> createState() => _ResponsesState();
}

class _ResponsesState extends State<Responses> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<RemoteResponseBloc>(context).add(const GetResponsesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RemoteResponseBloc, RemoteResponseState>(
      buildWhen: (previous, current) {
        return current is AllResponsesState;
      },
      builder: (BuildContext context, RemoteResponseState state) {
        List<ResponseEntity> responses = [];
        List<UserEntity> users = [];
        List<CandidateEntity> candidates = [];
        List<ExamEntity> exams = [];
        List<StatusEntity> status = [];
        if (state is AllResponsesState) {
          responses = state.responses;
          users = state.users;
          candidates = state.candidates;
          exams = state.exams;
          status = state.status;
        }
        return Padding(
          padding: const EdgeInsets.all(16),
          child: DataTable2(
            columnSpacing: 12,
            horizontalMargin: 12,
            minWidth: 600,
            columns: const [
              DataColumn2(
                label: Text('Candidate'),
                size: ColumnSize.L,
              ),
              DataColumn(
                label: Text('Exam'),
              ),
              DataColumn(
                label: Text('Assigned By'),
              ),
              DataColumn(
                label: Text('Reviewed By'),
              ),
              DataColumn(
                label: Text('Score'),
              ),
              DataColumn(
                label: Text('Status'),
              ),
              DataColumn2(
                label: Text('Actions'),
                size: ColumnSize.L,
              ),
            ],
            rows: responses.map((response) {
              var assignBy = 'NA';
              var reviewedBy = 'NA';
              var candidateName = 'NA';
              var examName = 'NA';
              var statusName = 'NA';

              for (var user in users) {
                if (user.id == response.assignBy) {
                  assignBy = "${user.firstName!} ${user.lastName}";
                  if (reviewedBy != 'NA') {
                    break;
                  }
                }
                if (user.id == response.reviewedBy) {
                  reviewedBy = "${user.firstName!} ${user.lastName}";
                  if (assignBy != 'NA') {
                    break;
                  }
                }
              }

              for (var candidate in candidates) {
                if (candidate.id == response.candidateId) {
                  candidateName =
                      "${candidate.firstName!} ${candidate.lastName}";
                  break;
                }
              }

              for (var exam in exams) {
                if (exam.id == response.examId) {
                  examName = exam.name!;
                  break;
                }
              }

              for (var st in status) {
                if (st.id == response.statusId) {
                  statusName = st.status!;
                  break;
                }
              }
              return DataRow(cells: [
                DataCell(Text(candidateName)),
                DataCell(Text(examName)),
                DataCell(Text(assignBy)),
                DataCell(Text(reviewedBy)),
                DataCell(Text(
                    response.score == null ? '0' : response.score.toString())),
                DataCell(
                    Text(response.statusId == null ? 'Pending' : statusName)),
                DataCell(Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.remove_red_eye_rounded,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showModal(context,
                            form: UpdateResponse(
                              reviewers: users
                                  .where((element) => element.roleId == 18)
                                  .toList(),
                              reviewer: reviewedBy,
                              responseEntity: response,
                              status: status,statusName: statusName,
                            ),
                            title: "Update\nResponse");
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        deleteResponseWidget(
                          context,
                          response.id,
                          title: "Delete Response",
                        );
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                )),
              ]);
            }).toList(),
          ),
        );
      },
      listener: (BuildContext context, RemoteResponseState state) {},
    );
  }
}
