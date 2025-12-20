import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/exams/remote_exam_bloc.dart';
import '../../bloc/exams/remote_exam_event.dart';
import '../../bloc/exams/remote_exam_state.dart';


Future<void> deleteExamModal(context, dynamic data,
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
          BlocConsumer<RemoteExamBloc, RemoteExamState>(
            builder: (BuildContext context, RemoteExamState state) {
              return ElevatedButton(
                onPressed: () {
                  BlocProvider.of<RemoteExamBloc>(context).add(
                    DeleteExamEvent(data),
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
            listener: (BuildContext context, RemoteExamState state) {
              if (state is DeleteExamDone) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green,
                    content: Text(state.message),
                  ),
                );

                Navigator.pop(context);
              }
              if (state is ExamErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(state.message),
                  ),
                );
              }
              BlocProvider.of<RemoteExamBloc>(context).add(const GetExamListEvent());
            },
          ),
        ],
      );
    },
  );
}
