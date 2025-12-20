import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoassessment_flutter/core/resources/capitalize.dart';
import 'package:neoassessment_flutter/domain/entities/domains/domain_entity.dart';
import 'package:neoassessment_flutter/domain/entities/level/level_entity.dart';
import 'package:neoassessment_flutter/domain/entities/questionCat/questionCat_entity.dart';
import 'package:neoassessment_flutter/domain/entities/questions/questions_entity.dart';
import 'package:neoassessment_flutter/presentation/bloc/questions/remote_questions_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/questions/remote_questions_event.dart';
import 'package:neoassessment_flutter/presentation/bloc/questions/remote_questions_state.dart';
import 'package:neoassessment_flutter/presentation/pages/question/question_create_form.dart';
import 'package:neoassessment_flutter/presentation/pages/question/question_delete_modal.dart';
import 'package:neoassessment_flutter/presentation/pages/question/question_update_form_widget.dart';

import '../../widgets/modal.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  String domainName = '';
  int levelNumber = 0;

  @override
  void initState() {
    super.initState();

    BlocProvider.of<RemoteQuestionBloc>(context).add(const GetQuestionsEvent());
  }

  @override
  Widget build(BuildContext context) {
    // PageController pageController = PageController();
   // PageController pageController = PageController();
    return BlocBuilder<RemoteQuestionBloc, RemoteQuestionsState>(
      buildWhen: (previous, current) {
        return current is LoadQuestionsState || current is QuestionErrorState;
      },
      builder: (context, state) {
        if (state is LoadQuestionsState) {
          List<DomainEntity> domains = state.allDomains;
          List<LevelEntity> levels = state.allLevels;
          List<QuestionCatEntity> categories = state.allCats;

          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(right: 4.0, left: 4.0, bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Questions",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showModal(
                            context,
                            form: QuestionCreateForm(
                                domains: domains,
                                levels: levels,
                                categories: categories),
                            title: "Create Question",
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Create",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: state.allQuestions.isNotEmpty
                      ? ListView.builder(
                          itemCount: state.allQuestions.length,
                          itemBuilder: (context, index) {
                            List<QuestionEntity> data = state.allQuestions;

                              for (var domain in domains) {
                                if (domain.id == data[index].domainId) {
                                  domainName = domain.name!;
                                  break;
                                }
                              }
                              for (var level in levels) {
                                if (level.id == data[index].levelId) {
                                  levelNumber = level.number!;
                                }
                              }
                              return Card(
                                color: Colors.white,
                                child: ListTile(
                                  title: Text(
                                    "${index + 1}. ${data[index].question!.capitalize()}",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  subtitle: Text(
                                    "\n𝐃𝐨𝐦𝐚𝐢𝐧 : $domainName  \n𝐋𝐞𝐯𝐞𝐥: $levelNumber",
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            List questionData = [
                                              data[index]
                                                  .question!
                                                  .capitalize(),
                                              data[index].op1!.capitalize(),
                                              data[index].op2!.capitalize(),
                                              data[index].op3!.capitalize(),
                                              data[index].op4!.capitalize(),
                                              data[index]
                                                  .correctOp!
                                                  .capitalize(),
                                              data[index].domainId,
                                              data[index].levelId,
                                              data[index].questionCategoryId,
                                            ];
                                            int questionId = data[index].id!;
                                            showModal(context,
                                                form: updateQuestionForm(
                                                  context,
                                                  id: questionId,
                                                  data: questionData,
                                                  domains: state.allDomains,
                                                  levels: state.allLevels,
                                                  categories: categories,
                                                ),
                                                title: "Update\nQuestion");
                                          },
                                          icon: const Icon(Icons.edit),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            deleteQuestionModal(
                                              context,
                                              data[index].id,
                                              title: "Delete Question",
                                            );
                                          },
                                          icon: const Icon(Icons.delete),
                                        ),
                                      ]),
                                ),
                              );
                            },
                          )
                        : const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text("No Questions Exists")],
                            ),
                          ),
                  )
                ],
              ),
            );
          }

          if (state is QuestionErrorState) {
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
        },
      );
  }
}
