import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/status/remote_status_bloc.dart';
import '../../bloc/status/remote_status_event.dart';
import '../../bloc/status/remote_status_state.dart';

Widget updateForm(
    BuildContext context, {
      required int id,
      required TextEditingController statusNameController,
    }) {
  final updateFormKey = GlobalKey<FormState>();

  return Form(
    key: updateFormKey,
    child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            controller: statusNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter status name';
              }
              return null;
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Status',
              hintText: 'Enter status name',
            ),
          ),
        ),
        BlocConsumer<RemoteStatusBloc, RemoteStatusState>(
          builder: (context, state) {
            return SizedBox(
              height: 50,
              width: 250,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (updateFormKey.currentState!.validate()) {
                      BlocProvider.of<RemoteStatusBloc>(context).add(
                        UpdateStatusEvent(
                          id,
                          statusNameController.text,
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
            if (state is RemoteStatusError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(state.message),
                ),
              );
            }
            if (state is StatusUpdatedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(state.message),
                ),
              );
              statusNameController.clear();
              Navigator.pop(context);
            }
            BlocProvider.of<RemoteStatusBloc>(context).add(GetStatusEvent());
          },
        ),
      ],
    ),
  );
}
