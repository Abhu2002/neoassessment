import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoassessment_flutter/core/resources/capitalize.dart';
import 'package:neoassessment_flutter/domain/entities/domains/domain_entity.dart';
import 'package:neoassessment_flutter/domain/entities/level/level_entity.dart';
import 'package:neoassessment_flutter/domain/entities/questionCat/questionCat_entity.dart';
import 'package:neoassessment_flutter/domain/entities/questions/questions_entity.dart';
import 'package:neoassessment_flutter/presentation/bloc/exams/remote_exam_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/exams/remote_exam_event.dart';
import 'package:neoassessment_flutter/presentation/bloc/exams/remote_exam_state.dart';

class CreateExamScreen extends StatefulWidget {
  const CreateExamScreen({super.key});

  @override
  State<CreateExamScreen> createState() => _CreateExamScreenState();
}

class _CreateExamScreenState extends State<CreateExamScreen> {
  int domainId = 0;
  int levelId = 0;
  int questionCatId = 0;
  List<DomainEntity> domains = [];
  List<LevelEntity> levels = [];
  List<QuestionEntity> questions = [];
  List<QuestionEntity> allQuestions = [];
  List<QuestionCatEntity> questionCats = [];
  List<QuestionEntity> filteredQuestions = [];

  List<int> selectedQuestions = [];

  final formKey = GlobalKey<FormState>();
  TextEditingController examNameController = TextEditingController();
  TextEditingController examDescController = TextEditingController();
  TextEditingController passingScoreController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<RemoteExamBloc>(context).add(LoadDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemoteExamBloc, RemoteExamState>(
      buildWhen: (previous, current) {
        return current is DataLoadedState;
      },
      builder: (BuildContext context, RemoteExamState state) {
        if (state is DataLoadedState) {
          domains = state.domains;
          levels = state.levels;
          questions = state.questions;
          questionCats = state.questionCats;
          allQuestions = state.questions;

          return SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BlocConsumer<RemoteExamBloc, RemoteExamState>(
                      builder: (context, state) {
                        return Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20)),
                            child: ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  BlocProvider.of<RemoteExamBloc>(context).add(
                                    CreateExamEvent(
                                      questions: selectedQuestions,
                                      domainId: domainId,
                                      levelId: levelId,
                                      questionCatId: questionCatId,
                                      examName: examNameController.text,
                                      examDescription: examDescController.text,
                                      passingScore: int.parse(
                                          passingScoreController.text),
                                    ),
                                  );
                                }
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
                        );
                      },
                      listener: (context, state) {
                        if (state is ExamErrorState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(state.message),
                            ),
                          );
                        }
                        if (state is ExamCreatedState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.green,
                              content: Text(state.message),
                            ),
                          );
                          Navigator.pushReplacementNamed(context, '/dashboard');
                        }
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Divider(
                        height: 10,
                        color: Colors.black,
                      ),
                    ),
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: DropdownButtonFormField(
                                    hint: Text(
                                      "Select Domain",
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
                                    items: domains.map((domain) {
                                      return DropdownMenuItem(
                                        value: domain.name,
                                        child: Text(
                                          domain.name!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
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
                                          .add(FilterQuestionsEvent(
                                        questions: allQuestions,
                                        domainId:
                                            domainId != 0 ? domainId : null,
                                        levelId: levelId != 0 ? levelId : null,
                                        questionCategoryId: questionCatId != 0
                                            ? questionCatId
                                            : null,
                                      ));
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
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
                                        value: level.number,
                                        child: Text(
                                          level.number!.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
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
                                          .add(FilterQuestionsEvent(
                                        questions: allQuestions,
                                        domainId:
                                            domainId != 0 ? domainId : null,
                                        levelId: levelId != 0 ? levelId : null,
                                        questionCategoryId: questionCatId != 0
                                            ? questionCatId
                                            : null,
                                      ));
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
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      height: 10,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Column(
                              // mainAxisSize: MainAxisSize.min,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Text(
                                      "Select Questions for Quiz",
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: DropdownButtonFormField(
                                      hint: Text("All Categories",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium),
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                          Radius.circular(20.0),
                                        )),
                                      ),
                                      value: null,
                                      items: questionCats.map((cat) {
                                        return DropdownMenuItem(
                                          value: cat.name,
                                          child: Text(
                                            cat.name!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        for (int i = 0;
                                            i < questionCats.length;
                                            i++) {
                                          if (newValue ==
                                              questionCats[i].name) {
                                            questionCatId = questionCats[i].id!;
                                            break;
                                          }
                                        }
                                        BlocProvider.of<RemoteExamBloc>(context)
                                            .add(FilterQuestionsEvent(
                                          questions: allQuestions,
                                          domainId:
                                              domainId != 0 ? domainId : null,
                                          levelId:
                                              levelId != 0 ? levelId : null,
                                          questionCategoryId: questionCatId != 0
                                              ? questionCatId
                                              : null,
                                        ));
                                      },
                                      icon: const Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Icon(Icons.filter_list_alt)),
                                      iconEnabledColor: Colors.black,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 20),
                                      dropdownColor: Colors.grey[200],
                                      isExpanded: true,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: BlocBuilder<RemoteExamBloc,
                                      RemoteExamState>(
                                    buildWhen: (previous, current) {
                                      return current is DataLoadedState ||
                                          current is QuestionFilteredState ||
                                          current is SelectedQuestionsState;
                                    },
                                    builder: (BuildContext context,
                                        RemoteExamState state) {
                                      if (state is QuestionFilteredState) {
                                        questions = state.questions.isEmpty
                                            ? allQuestions
                                            : state.questions;
                                        filteredQuestions = state.questions;
                                        if (domainId != 0 &&
                                            levelId != 0 &&
                                            questionCatId != 0 &&
                                            state.questions.isEmpty) {
                                          return Center(
                                            child: Column(
                                              children: [
                                                Text(
                                                    "No questions with such specifications",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge)
                                              ],
                                            ),
                                          );
                                        }
                                      }

                                      if (state is SelectedQuestionsState) {
                                        questions =
                                            state.filteredQuestions.isEmpty
                                                ? allQuestions
                                                : state.filteredQuestions;
                                      }
                                      return Container(
                                        color: Colors.grey[200],
                                        child: ListView.builder(
                                          itemCount: questions.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                top: BorderSide(
                                                    color: Colors.white,
                                                    width: 2),
                                                bottom: BorderSide(
                                                    color: Colors.white,
                                                    width: 2),
                                              )),
                                              child: CheckboxListTile(
                                                controlAffinity:
                                                    ListTileControlAffinity
                                                        .leading,
                                                selectedTileColor:
                                                    Theme.of(context)
                                                        .primaryColor,
                                                shape: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.grey[400]!,
                                                  ),
                                                ),
                                                value:
                                                    selectedQuestions.contains(
                                                        questions[index].id),
                                                title: Text(
                                                  questions[index]
                                                      .question!
                                                      .capitalize(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium,
                                                ),
                                                onChanged: (bool? value) {
                                                  if (value!) {
                                                    selectedQuestions.add(
                                                        questions[index].id!);
                                                  } else {
                                                    selectedQuestions.remove(
                                                        questions[index].id!);
                                                  }

                                                  BlocProvider.of<
                                                              RemoteExamBloc>(
                                                          context)
                                                      .add(
                                                    SelectQuestionEvent(
                                                      selectedQuestions:
                                                          selectedQuestions,
                                                      allQuestions:
                                                          allQuestions,
                                                      filteredQuestions:
                                                          filteredQuestions,
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    },
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
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Enter Quiz Details",
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
                                Form(
                                  key: formKey,
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 5),
                                        child: TextFormField(
                                          controller: examNameController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter exam name';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                              border:
                                                  const OutlineInputBorder(),
                                              labelText: 'Name',
                                              labelStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 5),
                                        child: TextFormField(
                                          controller: examDescController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter exam description';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Description',
                                              labelStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 5),
                                        child: TextFormField(
                                          controller: passingScoreController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter exam passing score';
                                            }
                                            return null;
                                          },
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              border:
                                                  const OutlineInputBorder(),
                                              labelText: 'Passing Score',
                                              labelStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                BlocBuilder<RemoteExamBloc, RemoteExamState>(
                                  buildWhen: (previous, current) {
                                    return current is SelectedQuestionsState;
                                  },
                                  builder: (context, state) {
                                    if (state is SelectedQuestionsState) {
                                      if (state.selectedQuestions.isEmpty) {
                                        return Text(
                                          "No Questions Selected Yet",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        );
                                      }
                                      List<QuestionEntity> stateQuestions =
                                          state.selectedQuestions;
                                      return Expanded(
                                        child: ListView.builder(
                                          itemCount: stateQuestions.length,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              title: Text(stateQuestions[index]
                                                  .question!),
                                              trailing: IconButton(
                                                onPressed: () {
                                                  selectedQuestions.remove(
                                                      stateQuestions[index].id);
                                                  BlocProvider.of<
                                                              RemoteExamBloc>(
                                                          context)
                                                      .add(
                                                    SelectQuestionEvent(
                                                      selectedQuestions:
                                                          selectedQuestions,
                                                      allQuestions:
                                                          allQuestions,
                                                      filteredQuestions:
                                                          filteredQuestions,
                                                    ),
                                                  );
                                                },
                                                icon: const Icon(
                                                  Icons.cancel,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    }
                                    return Text(
                                      "No Questions Selected Yet",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
      },
    );
  }
}
