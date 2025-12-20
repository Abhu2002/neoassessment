import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/domains/remote_domains_bloc.dart';

Widget updateForm(
  BuildContext context, {
  required int id,
  required TextEditingController domainNameController,
  required TextEditingController domainDescriptionController,
}) {
  final updateFormKey = GlobalKey<FormState>();

  return Form(
    key: updateFormKey,
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
                    if (updateFormKey.currentState!.validate()) {
                      BlocProvider.of<RemoteDomainsBloc>(context).add(
                        UpdateDomainEvent(
                          id,
                          domainNameController.text,
                          domainDescriptionController.text,
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Update',
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
                  backgroundColor: Colors.green,
                  content: Text(state.message),
                ),
              );
            }
            if (state is DomainUpdatedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(state.message),
                ),
              );
              domainNameController.clear();
              domainDescriptionController.clear();
              Navigator.pop(context);
            }
            BlocProvider.of<RemoteDomainsBloc>(context).add(GetDomainsEvent());
          },
        ),
      ],
    ),
  );
}
