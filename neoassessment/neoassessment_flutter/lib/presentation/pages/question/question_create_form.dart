// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoassessment_flutter/domain/entities/level/level_entity.dart';
import 'package:neoassessment_flutter/domain/entities/questionCat/questionCat_entity.dart';
import 'package:neoassessment_flutter/presentation/bloc/questions/remote_questions_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/questions/remote_questions_event.dart';
import 'package:neoassessment_flutter/presentation/bloc/questions/remote_questions_state.dart';

import '../../../domain/entities/domains/domain_entity.dart';

class QuestionCreateForm extends StatefulWidget {
  final List<DomainEntity> domains;
  final List<LevelEntity> levels;
  final List<QuestionCatEntity> categories;

  const QuestionCreateForm({
    super.key,
    required this.domains,
    required this.levels,
    required this.categories,
  });

  @override
  State<QuestionCreateForm> createState() => _QuestionCreateFormState();
}

class _QuestionCreateFormState extends State<QuestionCreateForm> {
  final createFormKey = GlobalKey<FormState>();
  final TextEditingController questionController = TextEditingController();
  final TextEditingController op1Controller = TextEditingController();
  final TextEditingController op2Controller = TextEditingController();
  final TextEditingController op3Controller = TextEditingController();
  final TextEditingController op4Controller = TextEditingController();
  final TextEditingController correctOpController = TextEditingController();

  List<String> options = ["Option 1", "Option 2", "Option 3", "Option 4"];

  @override
  void initState() {
    super.initState();
    questionController.text =
        "Which of the following is State Management tool?";
    op1Controller.text = "WebX";
    op2Controller.text = "OpX";
    op3Controller.text = "Bloc";
    op4Controller.text = "Serverpod";
    correctOpController.text = "Option 3";
  }

  @override
  Widget build(BuildContext context) {
    String domainDropdownVal = widget.domains[0].name!;
    int levelDropdownVal = widget.levels[0].number!;
    String categoryDropdownVal = widget.categories[0].name!;
    String correctOpDropdown = "Option 1";
    int levelId = 0;
    int domainId = 0;
    int categoryId = 0;

    return Form(
      key: createFormKey,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                controller: questionController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter question';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  )),
                  labelText: 'Question',
                  hintText: 'Enter question',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 15, bottom: 0),
              child: TextFormField(
                controller: op1Controller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter option 1';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    )),
                    labelText: 'Option 1',
                    hintText: 'Enter option 1'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 15, bottom: 0),
              child: TextFormField(
                controller: op2Controller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter option 2';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    )),
                    labelText: 'Option 2',
                    hintText: 'Enter option 2'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 15, bottom: 0),
              child: TextFormField(
                controller: op3Controller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter option 3';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    )),
                    labelText: 'Option 3',
                    hintText: 'Enter option 3'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 15, bottom: 0),
              child: TextFormField(
                controller: op4Controller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter option 4';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    )),
                    labelText: 'Option 4',
                    hintText: 'Enter option 4'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 15, bottom: 0),
              child: DropdownButtonFormField(
                hint: const Text("Select a correct option"),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  )),
                ),
                value: null,
                items: options.map((op) {
                  return DropdownMenuItem(
                    value: op,
                    child: Text(op),
                  );
                }).toList(),
                onChanged: (value) {
                  correctOpDropdown = value!;
                },
                icon: const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Icon(Icons.arrow_circle_down_sharp)),
                iconEnabledColor: Colors.black,
                style: const TextStyle(color: Colors.black, fontSize: 20),
                dropdownColor: Colors.white,
                isExpanded: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 15, bottom: 0),
              child: DropdownButtonFormField(
                hint: const Text("Select a domain"),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  )),
                ),
                value: null,
                items: widget.domains.map((domain) {
                  return DropdownMenuItem(
                    value: domain.name!,
                    child: Text(domain.name!),
                  );
                }).toList(),
                onChanged: (newValue) {
                  for (int i = 0; i < widget.domains.length; i++) {
                    if (newValue == widget.domains[i].name) {
                      domainId = widget.domains[i].id!;
                      domainDropdownVal = widget.domains[i].name!;
                      break;
                    }
                  }
                },
                icon: const Padding(
                    //Icon at tail, arrow bottom is default icon
                    padding: EdgeInsets.only(left: 20),
                    child: Icon(Icons.arrow_circle_down_sharp)),
                iconEnabledColor: Colors.black,
                //Icon color
                style: const TextStyle(
                    //te
                    color: Colors.black,
                    fontSize: 20),

                dropdownColor: Colors.white,
                isExpanded: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 15, bottom: 0),
              child: DropdownButtonFormField(
                hint: const Text("Select a level"),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  )),
                ),
                value: null,
                items: widget.levels.map((level) {
                  return DropdownMenuItem(
                    value: level.number!,
                    child: Text(level.number!.toString()),
                  );
                }).toList(),
                onChanged: (newValue) {
                  for (int i = 0; i < widget.levels.length; i++) {
                    if (newValue == widget.levels[i].number) {
                      levelId = widget.levels[i].id!;
                      levelDropdownVal = widget.levels[i].number!;
                      break;
                    }
                  }
                },
                icon: const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Icon(Icons.arrow_circle_down_sharp)),
                iconEnabledColor: Colors.black,
                style: const TextStyle(color: Colors.black, fontSize: 20),
                dropdownColor: Colors.white,
                isExpanded: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 15, bottom: 0),
              child: DropdownButtonFormField(
                hint: const Text("Select a category"),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  )),
                ),
                value: null,
                items: widget.categories.map((cat) {
                  return DropdownMenuItem(
                    value: cat.name!,
                    child: Text(cat.name!.toString()),
                  );
                }).toList(),
                onChanged: (newValue) {
                  for (int i = 0; i < widget.categories.length; i++) {
                    if (newValue == widget.categories[i].name) {
                      categoryId = widget.categories[i].id!;
                      categoryDropdownVal = widget.categories[i].name!;
                      break;
                    }
                  }
                },
                icon: const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Icon(Icons.arrow_circle_down_sharp)),
                iconEnabledColor: Colors.black,
                style: const TextStyle(color: Colors.black, fontSize: 20),
                dropdownColor: Colors.white,
                isExpanded: true,
              ),
            ),
            BlocConsumer<RemoteQuestionBloc, RemoteQuestionsState>(
              builder: (context, state) {
                return SizedBox(
                  height: 50,
                  width: 250,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (createFormKey.currentState!.validate()) {
                          BlocProvider.of<RemoteQuestionBloc>(context)
                              .add(CreateQuestionEvent(
                            question: questionController.text,
                            op1: op1Controller.text,
                            op2: op2Controller.text,
                            op3: op3Controller.text,
                            op4: op4Controller.text,
                            correctOp: correctOpController.text,
                            domainId: domainId,
                            levelId: levelId,
                            categoryId: categoryId,
                          ));
                        }
                      },
                      child: const Text(
                        'Create',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
                );
              },
              listener: (context, state) {
                if (state is QuestionErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(state.message),
                    ),
                  );
                }
                if (state is QuestionCreatedState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green,
                      content: Text(state.message),
                    ),
                  );
                  BlocProvider.of<RemoteQuestionBloc>(context)
                      .add(const GetQuestionsEvent());
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
