import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/levels/remote_levels_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/levels/remote_levels_state.dart';

import '../../bloc/levels/remote_levels_event.dart';

Widget createForm(
  BuildContext context, {
  required TextEditingController levelNameController,
}) {
  final createFormKey = GlobalKey<FormState>();

  return Form(
    key: createFormKey,
    child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            controller: levelNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Role name';
              }
              return null;
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Level',
              hintText: 'Enter Level Name',
            ),
          ),
        ),
        BlocConsumer<RemoteLevelsBloc, RemoteLevelsState>(
          builder: (context, state) {
            return SizedBox(
              height: 50,
              width: 250,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (createFormKey.currentState!.validate()) {
                      BlocProvider.of<RemoteLevelsBloc>(context).add(
                        CreateLevelEvent(
                          int.parse(levelNameController.text),
                        ),
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
            if (state is RemoteLevelsError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(state.errormsg),
                ),
              );
            }
            if (state is CreateRemoteLevelsDone) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(state.message),
                ),
              );
              Navigator.pop(context);
            }
            levelNameController.clear();

            BlocProvider.of<RemoteLevelsBloc>(context).add((GetLevelEvent()));
          },
        ),
      ],
    ),
  );
}
