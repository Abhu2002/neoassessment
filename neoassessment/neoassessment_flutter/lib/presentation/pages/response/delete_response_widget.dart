import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/responses/remote_response_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/responses/remote_response_event.dart';
import 'package:neoassessment_flutter/presentation/bloc/responses/remote_response_state.dart';

Future<void> deleteResponseWidget(context, dynamic data,
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
          BlocConsumer<RemoteResponseBloc, RemoteResponseState>(
            builder: (BuildContext context, RemoteResponseState state) {
              return ElevatedButton(
                onPressed: () {
                  BlocProvider.of<RemoteResponseBloc>(context).add(
                    DeleteResponseEvent(data),
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
            listener: (BuildContext context, RemoteResponseState state) {
              if (state is ResponseDeletedState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green,
                    content: Text(state.message),
                  ),
                );

                Navigator.pop(context);
              }
              if (state is ResponseErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(state.message),
                  ),
                );
              }
              BlocProvider.of<RemoteResponseBloc>(context)
                  .add(const GetResponsesEvent());
            },
          ),
        ],
      );
    },
  );
}
