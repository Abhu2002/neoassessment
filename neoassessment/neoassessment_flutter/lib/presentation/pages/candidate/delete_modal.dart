import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/candidiates/remote_candidates_bloc.dart';
import '../../bloc/candidiates/remote_candidates_event.dart';
import '../../bloc/candidiates/remote_candidates_state.dart';

Future<void> deleteCandidateModal(context, dynamic data,
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
          BlocConsumer<RemoteCandidatesBloc, RemoteCandidatesState>(
            builder: (BuildContext context, RemoteCandidatesState state) {
              return ElevatedButton(
                onPressed: () {
                  BlocProvider.of<RemoteCandidatesBloc>(context).add(
                    DeleteCandidateEvent(data),
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
            listener: (BuildContext context, RemoteCandidatesState state) {
              if (state is DeleteRemoteCandidatesDone) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green,
                    content: Text(state.message),
                  ),
                );

                Navigator.pop(context);
              }
              if (state is CandidateErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(state.error),
                  ),
                );
              }
              BlocProvider.of<RemoteCandidatesBloc>(context)
                  .add(const GetCandidatesEvent());
            },
          ),
        ],
      );
    },
  );
}
