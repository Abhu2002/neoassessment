import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/domains/domain_entity.dart';
import '../../bloc/questionCat/remote_questionCat_bloc.dart';
import '../../bloc/questionCat/remote_questionCat_event.dart';
import '../../bloc/questionCat/remote_questionCat_state.dart';

Widget updateQuestionCatForm(
  BuildContext context, {
  required int id,
  required int dataDomainId,
  required List<DomainEntity> domains,
  required TextEditingController questionCatNameController,
  required TextEditingController questionCatDescriptionController,
}) {
  final updateFormKey = GlobalKey<FormState>();
  String dropdownvalue = "Xamarin";
  int domainID = 0;
  return Form(
    key: updateFormKey,
    child: Column(
      children: <Widget>[
        BlocBuilder<QuestionCatBloc, RemoteQuestionCatState>(
          buildWhen: (previous, current) {
            return current is DomainChangedState;
          },
          builder: (context, state) {
            if (state is DomainChangedState) {
              dropdownvalue = state.newDomain; //state when domain is changed
            } else {
              for (int i = 0; i < domains.length; i++) {
                if (dataDomainId == domains[i].id) {
                  domainID = dataDomainId;
                  dropdownvalue = domains[i].name!;
                  break; //initial state
                }
              }
            }
            return Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 15, bottom: 10),
              child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  )),
                ),
                value: dropdownvalue,
                items: domains.map((domain) {
                  return DropdownMenuItem(
                    value: domain.name!,
                    child: Text(domain.name!),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  for (int i = 0; i < domains.length; i++) {
                    if (newValue == domains[i].name) {
                      domainID = domains[i].id!;
                      break;
                    }
                  }

                  BlocProvider.of<QuestionCatBloc>(context).add(
                      ChangeDomainQuestionCatEvent(dropdownvalue, domainID));
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
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            controller: questionCatNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Question Category name';
              }
              return null;
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Question Category',
              hintText: 'Enter Question Category',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 10.0, right: 10.0, top: 15, bottom: 0),
          child: TextFormField(
            controller: questionCatDescriptionController,
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
                    if (updateFormKey.currentState!.validate()) {
                      BlocProvider.of<QuestionCatBloc>(context).add(
                        UpdateQuestionCatEvent(
                          id,
                          domainID,
                          questionCatNameController.text,
                          questionCatDescriptionController.text,
                        ),
                      );
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
            if (state is RemoteQuestionCatError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(state.errormsg),
                ),
              );
            }
            if (state is QuestionCatUpdatedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(state.message),
                ),
              );
              questionCatDescriptionController.clear();
              questionCatNameController.clear();
              BlocProvider.of<QuestionCatBloc>(context)
                  .add(const GetQuestionCatEvent());
              Navigator.pop(context);
            }
          },
        ),
      ],
    ),
  );
}
