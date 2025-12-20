import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/roles/remote_roles_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/roles/remote_roles_event.dart';
import 'package:neoassessment_flutter/presentation/bloc/roles/remote_roles_state.dart';

Widget updateForm(
  BuildContext context, {
  required int id,
  required TextEditingController roleNameController,
}) {
  final updateFormKey = GlobalKey<FormState>();

  return Form(
    key: updateFormKey,
    child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            controller: roleNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Roles name';
              }
              return null;
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Roles',
              hintText: 'Enter Roles name',
            ),
          ),
        ),
        BlocConsumer<RemoteRolesBloc, RemoteRolesState>(
          builder: (context, state) {
            return SizedBox(
              height: 50,
              width: 250,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (updateFormKey.currentState!.validate()) {
                      BlocProvider.of<RemoteRolesBloc>(context).add(
                        UpdateRoles(
                          id,
                          roleNameController.text,
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
            if (state is RemoteRolesError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(state.errormsg),
                ),
              );
            }
            if (state is UpdateRolesDone) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(state.message),
                ),
              );
              roleNameController.clear();

              Navigator.pop(context);
            }
            BlocProvider.of<RemoteRolesBloc>(context).add(GetRoles());
          },
        ),
      ],
    ),
  );
}
