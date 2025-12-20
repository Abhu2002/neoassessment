import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoassessment_flutter/domain/entities/candidates/candidate_entity.dart';
import 'package:neoassessment_flutter/domain/entities/domains/domain_entity.dart';
import 'package:neoassessment_flutter/domain/entities/exams/exam_entity.dart';
import 'package:neoassessment_flutter/domain/entities/level/level_entity.dart';
import 'package:neoassessment_flutter/presentation/bloc/exams/remote_exam_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/exams/remote_exam_event.dart';
import 'package:neoassessment_flutter/presentation/bloc/exams/remote_exam_state.dart';

import '../../../core/utils/sharedPref.dart';

class AssignExamScreen extends StatefulWidget {
  const AssignExamScreen({super.key});

  @override
  State<AssignExamScreen> createState() => _AssignExamScreenState();
}

class _AssignExamScreenState extends State<AssignExamScreen> {
  var domainId = 0;
  var levelId = 0;
  var candidateId = 0;
  var assignedBy = 0;
  var examId = 0;
  List<ExamEntity> allExams = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<RemoteExamBloc>(context)
        .add(const GetCandidatesAndLevels());
    var userData = Prefs.getUser();
    var info = jsonDecode(userData!);
    assignedBy = info["user"]["id"];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20)),
                  child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<RemoteExamBloc>(context).add(
                        AssignExamEvent(
                            examId: examId,
                            candidateId: candidateId,
                            assignedBy: assignedBy),
                      );
                    },
                    child: Text(
                      'Save',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Divider(
                  height: 10,
                  color: Colors.black,
                ),
              ),
              BlocConsumer<RemoteExamBloc, RemoteExamState>(
                buildWhen: (previous, current) {
                  return current is LoadCandidatesAndLevels;
                },
                builder: (BuildContext context, RemoteExamState state) {
                  if (state is LoadCandidatesAndLevels) {
                    allExams = state.exams;
                  }
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Select Candidate",
                                  style: TextStyle(
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.fontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            BlocConsumer<RemoteExamBloc, RemoteExamState>(
                              buildWhen: (previous, current) {
                                return current is LoadCandidatesAndLevels;
                              },
                              builder: (BuildContext context,
                                  RemoteExamState state) {
                                List<CandidateEntity> candidates = [];
                                List<DomainEntity> domains = [];
                                if (state is LoadCandidatesAndLevels) {
                                  candidates = state.candidates;
                                  domains = state.domains;
                                }
                                return Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: DropdownButtonFormField(
                                      hint: Text(
                                        "Select Candidate",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                          Radius.circular(20.0),
                                        )),
                                      ),
                                      value: null,
                                      items: candidates.map((candidate) {
                                        var domainName = '';
                                        for (var domain in domains) {
                                          if (domain.id == candidate.domainId) {
                                            domainName = domain.name!;
                                            break;
                                          }
                                        }
                                        return DropdownMenuItem(
                                          value: candidate,
                                          child: Text(
                                            "${candidate.firstName} ${candidate.lastName} - $domainName",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        domainId = newValue!.domainId!;
                                        candidateId = newValue.id!;
                                        if (levelId != 0) {
                                          BlocProvider.of<RemoteExamBloc>(
                                                  context)
                                              .add(
                                            GetFilteredExamsEvent(
                                                domainId: domainId,
                                                levelId: levelId,
                                                exams: allExams),
                                          );
                                        }
                                      },
                                      icon: const Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Icon(
                                              Icons.arrow_circle_down_sharp)),
                                      iconEnabledColor: Colors.black,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 20),
                                      dropdownColor: Colors.grey[200],
                                      isExpanded: true,
                                    ),
                                  ),
                                );
                              },
                              listener: (BuildContext context,
                                  RemoteExamState state) {},
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 5,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Select Level",
                                  style: TextStyle(
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.fontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            BlocConsumer<RemoteExamBloc, RemoteExamState>(
                              buildWhen: (previous, current) =>
                                  current is LoadCandidatesAndLevels,
                              builder: (BuildContext context,
                                  RemoteExamState state) {
                                List<LevelEntity> levels = [];
                                if (state is LoadCandidatesAndLevels) {
                                  levels = state.levels;
                                }
                                return Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: DropdownButtonFormField(
                                      hint: Text(
                                        "Select Level",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                          Radius.circular(20.0),
                                        )),
                                      ),
                                      value: null,
                                      items: levels.map((level) {
                                        return DropdownMenuItem(
                                          value: level.id,
                                          child: Text(
                                            "${level.number}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        levelId = newValue!;
                                        if (domainId != 0) {
                                          BlocProvider.of<RemoteExamBloc>(
                                                  context)
                                              .add(
                                            GetFilteredExamsEvent(
                                              domainId: domainId,
                                              levelId: levelId,
                                              exams: allExams,
                                            ),
                                          );
                                        }
                                      },
                                      icon: const Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Icon(
                                              Icons.arrow_circle_down_sharp)),
                                      iconEnabledColor: Colors.black,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 20),
                                      dropdownColor: Colors.grey[200],
                                      isExpanded: true,
                                    ),
                                  ),
                                );
                              },
                              listener: (BuildContext context,
                                  RemoteExamState state) {},
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 5,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Select Exam",
                                  style: TextStyle(
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.fontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            BlocBuilder<RemoteExamBloc, RemoteExamState>(
                              builder: (context, state) {
                                List<ExamEntity> exams = [];
                                if (state is ExamFilteredState) {
                                  exams = state.exams;
                                }
                                return Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: DropdownButtonFormField(
                                      hint: Text(
                                        "Select Exam",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                          Radius.circular(20.0),
                                        )),
                                      ),
                                      value: null,
                                      items: exams.map((exam) {
                                        return DropdownMenuItem(
                                          value: exam,
                                          child: Text(
                                            exam.name!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        examId = newValue!.id!;
                                      },
                                      icon: const Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Icon(
                                              Icons.arrow_circle_down_sharp)),
                                      iconEnabledColor: Colors.black,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 20),
                                      dropdownColor: Colors.grey[200],
                                      isExpanded: true,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                listener: (BuildContext context, RemoteExamState state) {
                  if (state is ExamAssignedState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text("Exam Assigned Successfully!!"),
                      ),
                    );
                  }
                  if (state is ExamErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(state.message),
                      ),
                    );
                  }
                },
              ),
              const Divider(
                height: 10,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
