import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/levels/remote_levels_state.dart';

import '../../bloc/levels/remote_levels_bloc.dart';
import '../../bloc/levels/remote_levels_event.dart';

Widget updateLevelForm(
  BuildContext context, {
  required int id,
  required TextEditingController levelNameController,
}) {
  final updateFormKey = GlobalKey<FormState>();

  return Form(
    key: updateFormKey,
    child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            controller: levelNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Levels name';
              }
              return null;
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Levels',
              hintText: 'Enter Level ',
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
                    if (updateFormKey.currentState!.validate()) {
                      BlocProvider.of<RemoteLevelsBloc>(context).add(
                        UpdateLevelEvent(
                          id,
                          int.parse(levelNameController.text),
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
            if (state is RemoteLevelsError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(state.errormsg),
                ),
              );
            }
            if (state is UpdateLevelsDone) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(state.message),
                ),
              );
              levelNameController.clear();

              Navigator.pop(context);
            }
            BlocProvider.of<RemoteLevelsBloc>(context).add(GetLevelEvent());
          },
        ),
      ],
    ),
  );
}
