import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/questionCat/remote_questionCat_state.dart';

import '../../bloc/questionCat/remote_questionCat_bloc.dart';
import '../../bloc/questionCat/remote_questionCat_event.dart';

Future<void> deleteQuestionCatModal(context, dynamic data,
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
          BlocConsumer<QuestionCatBloc, RemoteQuestionCatState>(
            builder: (BuildContext context, RemoteQuestionCatState state) {
              return ElevatedButton(
                onPressed: () {
                  BlocProvider.of<QuestionCatBloc>(context).add(
                    DeleteQuestionCatEvent(
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
            listener: (BuildContext context, RemoteQuestionCatState state) {
              if (state is DeleteRemoteQuestionCatDone) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green,
                    content: Text(state.message),
                  ),
                );

                Navigator.pop(context);
              }
              if (state is RemoteQuestionCatError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(state.errormsg),
                  ),
                );
              }
              BlocProvider.of<QuestionCatBloc>(context)
                  .add(const GetQuestionCatEvent());
            },
          ),
        ],
      );
    },
  );
}
