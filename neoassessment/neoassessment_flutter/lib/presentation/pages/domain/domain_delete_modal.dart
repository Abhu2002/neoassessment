import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/domains/remote_domains_bloc.dart';

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
          BlocConsumer<RemoteDomainsBloc, RemoteDomainsState>(
            builder: (BuildContext context, RemoteDomainsState state) {
              return ElevatedButton(
                onPressed: () {
                  BlocProvider.of<RemoteDomainsBloc>(context).add(
                    DeleteDomainEvent(
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
            listener: (BuildContext context, RemoteDomainsState state) {
              if (state is DomainDeletedState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green,
                    content: Text(state.message),
                  ),
                );

                Navigator.pop(context);
              }
              if (state is RemoteDomainsError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(state.message),
                  ),
                );
              }
              BlocProvider.of<RemoteDomainsBloc>(context)
                  .add(GetDomainsEvent());
            },
          ),
        ],
      );
    },
  );
}
