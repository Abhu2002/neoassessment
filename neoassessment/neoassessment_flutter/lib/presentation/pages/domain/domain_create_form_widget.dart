import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/domains/remote_domains_bloc.dart';

Widget createForm(
  BuildContext context, {
  required TextEditingController domainNameController,
  required TextEditingController domainDescriptionController,
}) {
  final createFormKey = GlobalKey<FormState>();

  return Form(
    key: createFormKey,
    child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            controller: domainNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter domain name';
              }
              return null;
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Domain',
              hintText: 'Enter domain name',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 10.0, right: 10.0, top: 15, bottom: 0),
          child: TextFormField(
            controller: domainDescriptionController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter domain description';
              }
              return null;
            },
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
                hintText: 'Enter domain description'),
          ),
        ),
        BlocConsumer<RemoteDomainsBloc, RemoteDomainsState>(
          builder: (context, state) {
            return SizedBox(
              height: 50,
              width: 250,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (createFormKey.currentState!.validate()) {
                      BlocProvider.of<RemoteDomainsBloc>(context).add(
                        CreateDomainEvent(
                          domainNameController.text,
                          domainDescriptionController.text,
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Create',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            );
          },
          listener: (context, state) {
            if (state is RemoteDomainsError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(state.message),
                ),
              );
            }
            if (state is DomainCreatedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(state.message),
                ),
              );
              Navigator.pop(context);
            }
            domainNameController.clear();
            domainDescriptionController.clear();
            BlocProvider.of<RemoteDomainsBloc>(context).add(GetDomainsEvent());
          },
        ),
      ],
    ),
  );
}
