import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/questions/remote_questions_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/questions/remote_questions_event.dart';
import 'package:neoassessment_flutter/presentation/bloc/questions/remote_questions_state.dart';

Future<void> deleteQuestionModal(context, dynamic data,
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
          BlocConsumer<RemoteQuestionBloc, RemoteQuestionsState>(
            builder: (BuildContext context, RemoteQuestionsState state) {
              return ElevatedButton(
                onPressed: () {
                  BlocProvider.of<RemoteQuestionBloc>(context).add(
                    DeleteQuestionEvent(data),
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
            listener: (BuildContext context, RemoteQuestionsState state) {
              if (state is DeleteQuestionDone) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green,
                    content: Text(state.message),
                  ),
                );

                Navigator.pop(context);
              }
              if (state is QuestionErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(state.message),
                  ),
                );
              }
              BlocProvider.of<RemoteQuestionBloc>(context)
                  .add(const GetQuestionsEvent());
            },
          ),
        ],
      );
    },
  );
}
