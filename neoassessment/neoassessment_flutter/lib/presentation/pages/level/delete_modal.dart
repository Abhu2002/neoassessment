import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/levels/remote_levels_bloc.dart';

import '../../bloc/levels/remote_levels_event.dart';
import '../../bloc/levels/remote_levels_state.dart';

Future<void> deleteLevelModal(context, dynamic data,
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
          BlocConsumer<RemoteLevelsBloc, RemoteLevelsState>(
            builder: (BuildContext context, RemoteLevelsState state) {
              return ElevatedButton(
                onPressed: () {
                  BlocProvider.of<RemoteLevelsBloc>(context).add(
                    DeleteLevelEvent(data),
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
            listener: (BuildContext context, RemoteLevelsState state) {
              if (state is DeleteRemoteLevelsDone) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green,
                    content: Text(state.message),
                  ),
                );

                Navigator.pop(context);
              }
              if (state is RemoteLevelsError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(state.errormsg),
                  ),
                );
              }
              BlocProvider.of<RemoteLevelsBloc>(context).add(GetLevelEvent());
            },
          ),
        ],
      );
    },
  );
}
