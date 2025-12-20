import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoassessment_flutter/domain/entities/exams/exam_entity.dart';
import 'package:neoassessment_flutter/domain/entities/questions/questions_entity.dart';
import 'package:neoassessment_flutter/presentation/bloc/exams/remote_exam_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/exams/remote_exam_event.dart';
import 'package:neoassessment_flutter/presentation/pages/exam/exam_detail_screen.dart';
import 'package:neoassessment_flutter/presentation/pages/exam/showExamDetailModal.dart';

import '../../../domain/entities/domains/domain_entity.dart';
import '../../../domain/entities/level/level_entity.dart';
import '../../bloc/exams/remote_exam_state.dart';
import 'delete_modal.dart';

class ExamListScreen extends StatefulWidget {
  const ExamListScreen({super.key});

  @override
  State<ExamListScreen> createState() => _ExamListScreenState();
}

class _ExamListScreenState extends State<ExamListScreen> {
  String domainName = '';
  int levelNumber = 0;

  int domainId = 0;
  int levelId = 0;
  int questionCatId = 0;
  List<ExamEntity> exams = [];
  List<ExamEntity> filteredExams = [];
  List<String> questionList = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<RemoteExamBloc>(context).add(const GetExamListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemoteExamBloc, RemoteExamState>(
        buildWhen: (previous, current) {
      return current is DataLoadedState || current is ExamErrorState;
    }, builder: (context, state) {
      if (state is DataLoadedState) {
        List<DomainEntity> domains = state.domains;
        List<LevelEntity> levels = state.levels;
        List<QuestionEntity> questionData = state.questions;
        List<ExamEntity> allExams = state.exam;
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
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
                              "Select Domain",
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
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: DropdownButtonFormField(
                              hint: Text(
                                "Select Domain",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                  Radius.circular(20.0),
                                )),
                              ),
                              value: null,
                              items: domains.map((domain) {
                                return DropdownMenuItem(
                                  value: domain.name,
                                  child: Text(domain.name!),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                for (int i = 0; i < domains.length; i++) {
                                  if (newValue == domains[i].name) {
                                    domainId = domains[i].id!;
                                    break;
                                  }
                                }
                                BlocProvider.of<RemoteExamBloc>(context)
                                    .add(FilterExamEvent(
                                  exams: allExams,
                                  domainId: domainId != 0 ? domainId : null,
                                  levelId: levelId != 0 ? levelId : null,
                                  questionCategoryId:
                                      questionCatId != 0 ? questionCatId : null,
                                ));
                              },
                              icon: const Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Icon(Icons.arrow_circle_down_sharp)),
                              iconEnabledColor: Colors.black,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 20),
                              dropdownColor: Colors.grey[200],
                              isExpanded: true,
                            ),
                          ),
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
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: DropdownButtonFormField(
                              hint: Text(
                                "Select Level",
                                style: Theme.of(context).textTheme.bodyMedium,
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
                                  value: level.number,
                                  child: Text(level.number!.toString()),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                for (int i = 0; i < levels.length; i++) {
                                  if (newValue == levels[i].number) {
                                    levelId = levels[i].id!;
                                    break;
                                  }
                                }

                                BlocProvider.of<RemoteExamBloc>(context)
                                    .add(FilterExamEvent(
                                  exams: allExams,
                                  domainId: domainId != 0 ? domainId : null,
                                  levelId: levelId != 0 ? levelId : null,
                                  questionCategoryId:
                                      questionCatId != 0 ? questionCatId : null,
                                ));
                              },
                              icon: const Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Icon(Icons.arrow_circle_down_sharp)),
                              iconEnabledColor: Colors.black,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 20),
                              dropdownColor: Colors.grey[200],
                              isExpanded: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 10,
                color: Colors.black12,
              ),
              Expanded(
                child: BlocBuilder<RemoteExamBloc, RemoteExamState>(
                  buildWhen: (previous, current) {
                    return current is DataLoadedState ||
                        current is ExamFilteredState ||
                        current is SelectedExamsState;
                  },
                  builder: (BuildContext context, RemoteExamState state) {
                    if (state is ExamFilteredState) {
                      exams = state.exams.isEmpty ? allExams : state.exams;
                      filteredExams = state.exams;
                      if (state.exams.isEmpty) {
                        return Center(
                          child: Column(
                            children: [
                              Text("No Exam with such specifications",
                                  style: Theme.of(context).textTheme.bodyLarge)
                            ],
                          ),
                        );
                      }
                      return Container(
                        color: Colors.grey[200],
                        child: ListView.builder(
                          itemCount: exams.length,
                          itemBuilder: (context, index) {
                            for (var domain in domains) {
                              if (domain.id == exams[index].domainId) {
                                domainName = domain.name!;
                                break;
                              }
                            }
                            for (var level in levels) {
                              if (level.id == exams[index].level) {
                                levelNumber = level.number!;
                              }
                            }

                            List<int> idArray = exams[index].questionIds!;
                            questionList = [];
                            for (var id in idArray) {

                              for (var question in questionData) {

                                if (id == question.id) {
                                  questionList.add(question.question!);
                                }
                              }
                            }

                            return InkWell(
                              onTap: () {

                                showExamDetailModal(context,
                                    form: ExamDetailForm(context,
                                        id: exams[index].id!,
                                        levelNumber: levelNumber,
                                        domain: domainName,
                                        question: questionList,
                                        passing_score:
                                            exams[index].passingScore!,
                                        quiz_title: exams[index].name!),
                                    title: 'Exam Detail');
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                  top:
                                      BorderSide(color: Colors.white, width: 2),
                                  bottom:
                                      BorderSide(color: Colors.white, width: 2),
                                )),
                                child: Card(
                                  color: Colors.white,
                                  child: ListTile(
                                      title: Text(
                                        "${exams[index].name}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      subtitle: Text(
                                        "\n𝐃𝐨𝐦𝐚𝐢𝐧  $domainName  \n𝐋𝐞𝐯𝐞𝐥: $levelNumber ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                      trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                deleteExamModal(
                                                    context, exams[index].id,
                                                    title: "Delete Exam");
                                              },
                                              icon: const Icon(Icons.delete),
                                            ),
                                          ])),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }

                    if (state is SelectedExamsState) {
                      exams = state.filteredExams.isEmpty
                          ? allExams
                          : state.filteredExams;
                    }

                    if (state is DataLoadedState) {
                      exams = state.exam;
                      questionData = state.questions;

                      return Container(
                        color: Colors.grey[200],
                        child: ListView.builder(
                          itemCount: exams.length,
                          itemBuilder: (context, index) {
                            for (var domain in domains) {
                              if (domain.id == exams[index].domainId) {
                                domainName = domain.name!;
                                break;
                              }
                            }
                            for (var level in levels) {
                              if (level.id == exams[index].level) {
                                levelNumber = level.number!;
                              }
                            }
                            // questionList = [];
                            // List<int> idArray = exams[index].questionIds!;
                            // for (var id in idArray) {
                            //   for (var q in questionData) {
                            //
                            //     if (id == q.id) {
                            //       questionList.add(q.question!);
                            //       print("Question List : ${questionList}");
                            //     }
                            //   }
                            // }

                            return InkWell(
                              onTap: () {

                                questionList = [];
                                List<int> idArray = exams[index].questionIds!;

                                for (var id in idArray) {
                                  for (var q in questionData) {

                                    if (id == q.id) {
                                      questionList.add(q.question!);
                                    }
                                  }
                                }

                                showExamDetailModal(context,
                                    form: ExamDetailForm(context,
                                        id: exams[index].id!,
                                        levelNumber: levelNumber,
                                        domain: domainName,
                                        question: questionList,
                                        passing_score:
                                            exams[index].passingScore!,
                                        quiz_title: exams[index].name!),
                                    title: 'Exam Detail');
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                  top:
                                      BorderSide(color: Colors.white, width: 2),
                                  bottom:
                                      BorderSide(color: Colors.white, width: 2),
                                )),
                                child: Card(
                                  color: Colors.white,
                                  child: ListTile(
                                      title: Text(
                                        "${exams[index].name}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      subtitle: Text(
                                        "\n𝐃𝐨𝐦𝐚𝐢𝐧  $domainName  \n𝐋𝐞𝐯𝐞𝐥: $levelNumber ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                      trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                deleteExamModal(
                                                    context, exams[index].id,
                                                    title: "Delete Exam");
                                              },
                                              icon: const Icon(Icons.delete),
                                            ),
                                          ])),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text("No Exams Yet")],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }

      if (state is ExamErrorState) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                state.message,
              ),
            )
          ],
        );
      }

      return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CircularProgressIndicator(),
          ),
        ],
      );
    });
  }
}
