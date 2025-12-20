import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoassessment_flutter/domain/entities/level/level_entity.dart';
import 'package:neoassessment_flutter/presentation/bloc/questions/remote_questions_event.dart';

import '../../../domain/entities/domains/domain_entity.dart';
import '../../../domain/entities/questionCat/questionCat_entity.dart';
import '../../bloc/questions/remote_questions_bloc.dart';
import '../../bloc/questions/remote_questions_state.dart';

Widget updateQuestionForm(
  BuildContext context, {
  required int id,
  required dynamic data,
  required List<DomainEntity> domains,
  required List<LevelEntity> levels,
  required List<QuestionCatEntity> categories,
}) {
  final updateFormKey = GlobalKey<FormState>();
  final TextEditingController questionController = TextEditingController();
  final TextEditingController op1Controller = TextEditingController();
  final TextEditingController op2Controller = TextEditingController();
  final TextEditingController op3Controller = TextEditingController();
  final TextEditingController op4Controller = TextEditingController();
  final TextEditingController correctOpController = TextEditingController();

  List<String> options = ["Option 1", "Option 2", "Option 3", "Option 4"];

  String domainDropdownVal = '';
  int levelDropdownVal = 0;
  // ignore: unused_local_variable
  String categoryDropdownVal = '';
  String correctOpDropdown = data[5];

  int domainId = data[6];
  int levelId = data[7];
  int categoryId = data[8];

  questionController.text = data[0];

  op1Controller.text = data[1];
  op2Controller.text = data[2];
  op3Controller.text = data[3];
  op4Controller.text = data[4];
  correctOpController.text = data[5];

  TextEditingController passController = TextEditingController();
  passController.text = data[8].toString();

  for (int i = 0; i < domains.length; i++) {
    if (domains[i].id == data[6]) {
      domainDropdownVal = domains[i].name!;
      break;
    }
  }

  for (int i = 0; i < levels.length; i++) {
    if (levels[i].id == data[7]) {
      levelDropdownVal = levels[i].number!;
      break;
    }
  }

  for (int i = 0; i < categories.length; i++) {
    if (categories[i].id == data[8]) {
      categoryDropdownVal = categories[i].name!;
      break;
    }
  }
  return Form(
    key: updateFormKey,
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
              value: correctOpDropdown,
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
              value: domainDropdownVal,
              items: domains.map((domain) {
                return DropdownMenuItem(
                  value: domain.name!,
                  child: Text(domain.name!),
                );
              }).toList(),
              onChanged: (newValue) {
                for (int i = 0; i < domains.length; i++) {
                  if (newValue == domains[i].name) {
                    domainId = domains[i].id!;
                    domainDropdownVal = domains[i].name!;
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
              value: levelDropdownVal,
              items: levels.map((level) {
                return DropdownMenuItem(
                  value: level.number!,
                  child: Text(level.number!.toString()),
                );
              }).toList(),
              onChanged: (newValue) {
                for (int i = 0; i < levels.length; i++) {
                  if (newValue == levels[i].number) {
                    levelId = levels[i].id!;
                    levelDropdownVal = levels[i].number!;
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
              value: categoryDropdownVal,
              items: categories.map((category) {
                return DropdownMenuItem(
                  value: category.name!,
                  child: Text(category.name!.toString()),
                );
              }).toList(),
              onChanged: (newValue) {
                for (int i = 0; i < categories.length; i++) {
                  if (newValue == categories[i].name) {
                    categoryId = categories[i].id!;
                    categoryDropdownVal = categories[i].name!;
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
                      if (updateFormKey.currentState!.validate()) {
                        BlocProvider.of<RemoteQuestionBloc>(context)
                            .add(UpdateQuestionEvent(
                          id: id,
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
                      'Update',
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
              if (state is QuestionUpdatedState) {
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
