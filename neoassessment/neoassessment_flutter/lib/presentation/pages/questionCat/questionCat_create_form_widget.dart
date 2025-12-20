import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/questionCat/remote_questionCat_bloc.dart';

import '../../../domain/entities/domains/domain_entity.dart';
import '../../bloc/questionCat/remote_questionCat_event.dart';
import '../../bloc/questionCat/remote_questionCat_state.dart';

Widget createQuestionCatForm(BuildContext context,
    {required TextEditingController questionCatController,
    required TextEditingController questionCatDescController,
    required List<DomainEntity> domains}) {
  final createFormKey = GlobalKey<FormState>();
  String dropdownvalue = "Xamarin";
  int domainId = 0;

  return Form(
    key: createFormKey,
    child: Column(
      children: <Widget>[
        BlocBuilder<QuestionCatBloc, RemoteQuestionCatState>(
          buildWhen: (previous, current) {
            return current is DomainChangedState;
          },
          builder: (context, state) {
            if (state is DomainChangedState) {
              dropdownvalue = state.newDomain;
              domainId = state.domainId;
            } else {
              dropdownvalue = domains[0].name!.toString();
            }
            return Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 15, bottom: 0),
              child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  )),
                ),
                value: null,
                hint: const Text("Select a Domain"),
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
                      break;
                    }
                  }

                  BlocProvider.of<QuestionCatBloc>(context).add(
                      ChangeDomainQuestionCatEvent(dropdownvalue, domainId));
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
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 10.0, right: 10.0, top: 12, bottom: 0),
          child: TextFormField(
            controller: questionCatController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Question Category';
              }
              return null;
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Question Category',
              hintText: 'Enter Question Category ',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 10.0, right: 10.0, top: 15, bottom: 0),
          child: TextFormField(
            controller: questionCatDescController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Category description';
              }
              return null;
            },
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
                hintText: 'Enter Category description'),
          ),
        ),
        BlocConsumer<QuestionCatBloc, RemoteQuestionCatState>(
          builder: (context, state) {
            return SizedBox(
              height: 50,
              width: 250,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (createFormKey.currentState!.validate()) {
                      BlocProvider.of<QuestionCatBloc>(context).add(
                        CreateQuestionCatEvent(
                            //int.parse(questionCatDomainIDController.text),
                            domainId,
                            questionCatController.text,
                            questionCatDescController.text),
                      );
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
            if (state is RemoteQuestionCatError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(state.errormsg),
                ),
              );
            }
            if (state is QuestionCatCreatedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(state.message),
                ),
              );
              Navigator.pop(context);
            }

            questionCatController.clear();
            questionCatDescController.clear();
            BlocProvider.of<QuestionCatBloc>(context)
                .add(const GetQuestionCatEvent());
          },
        ),
      ],
    ),
  );
}
