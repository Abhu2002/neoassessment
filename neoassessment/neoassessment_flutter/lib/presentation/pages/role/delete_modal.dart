import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/roles/remote_roles_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/roles/remote_roles_event.dart';
import 'package:neoassessment_flutter/presentation/bloc/roles/remote_roles_state.dart';

Future<void> deleteModal(context, dynamic data, {required String title}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(title),
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.cancel),
            ),
          ],
        ),
        content: const SingleChildScrollView(
          child: Text("Are you sure? You want to delete this?"),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "No",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          BlocConsumer<RemoteRolesBloc, RemoteRolesState>(
            builder: (BuildContext context, RemoteRolesState state) {
              return ElevatedButton(
                onPressed: () {
                  BlocProvider.of<RemoteRolesBloc>(context).add(
                    DeleteRoles(data),
                  );
                },
                child: Text(
                  'Yes',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.white,
                      ),
                ),
              );
            },
            listener: (BuildContext context, RemoteRolesState state) {
              if (state is DeleteRemoteRolesDone) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green,
                    content: Text(state.message),
                  ),
                );

                Navigator.pop(context);
              }
              if (state is RemoteRolesError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(state.errormsg),
                  ),
                );
              }
              BlocProvider.of<RemoteRolesBloc>(context).add(GetRoles());
            },
          ),
        ],
      );
    },
  );
}
