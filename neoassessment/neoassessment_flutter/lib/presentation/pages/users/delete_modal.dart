import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/users/remote_users_bloc.dart';
import '../../bloc/users/remote_users_event.dart';
import '../../bloc/users/remote_users_state.dart';

Future<void> deleteUserModal(context, dynamic data,
    {required String title}) async {
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
          BlocConsumer<RemoteUsersBloc, RemoteUsersState>(
            builder: (BuildContext context, RemoteUsersState state) {
              return ElevatedButton(
                onPressed: () {
                  BlocProvider.of<RemoteUsersBloc>(context).add(
                    DeleteUserEvent(data),
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
            listener: (BuildContext context, RemoteUsersState state) {
              if (state is DeleteRemoteUsersDone) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green,
                    content: Text(state.message),
                  ),
                );

                Navigator.pop(context);
              }
              if (state is UserErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(state.error),
                  ),
                );
              }
              BlocProvider.of<RemoteUsersBloc>(context)
                  .add(const GetUsersEvent());
            },
          ),
        ],
      );
    },
  );
}
