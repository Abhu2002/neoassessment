import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/status/remote_status_bloc.dart';
import '../../bloc/status/remote_status_event.dart';
import '../../bloc/status/remote_status_state.dart';

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
          BlocConsumer<RemoteStatusBloc, RemoteStatusState>(
            builder: (BuildContext context, RemoteStatusState state) {
              return ElevatedButton(
                onPressed: () {
                  BlocProvider.of<RemoteStatusBloc>(context).add(
                    DeleteStatusEvent(
                      data!,
                    ),
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
            listener: (BuildContext context, RemoteStatusState state) {
              if (state is StatusDeletedState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green,
                    content: Text(state.message),
                  ),
                );

                Navigator.pop(context);
              }
              if (state is RemoteStatusError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(state.message),
                  ),
                );
              }
              BlocProvider.of<RemoteStatusBloc>(context)
                  .add(GetStatusEvent());
            },
          ),
        ],
      );
    },
  );
}
