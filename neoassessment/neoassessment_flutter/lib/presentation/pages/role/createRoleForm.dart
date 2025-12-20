import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/roles/remote_roles_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/roles/remote_roles_event.dart';
import 'package:neoassessment_flutter/presentation/bloc/roles/remote_roles_state.dart';

Widget createForm(
  BuildContext context, {
  required TextEditingController roleNameController,
}) {
  final createFormKey = GlobalKey<FormState>();

  return Form(
    key: createFormKey,
    child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            controller: roleNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Role name';
              }
              return null;
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Role',
              hintText: 'Enter Role Name',
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
                    if (createFormKey.currentState!.validate()) {
                      BlocProvider.of<RemoteRolesBloc>(context).add(
                        CreateRoles(
                          roleNameController.text,
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
            if (state is RemoteRolesError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(state.errormsg),
                ),
              );
            }
            if (state is CreateRemoteRolesDone) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(state.message),
                ),
              );
              Navigator.pop(context);
            }
            roleNameController.clear();

            BlocProvider.of<RemoteRolesBloc>(context).add(GetRoles());
          },
        ),
      ],
    ),
  );
}
