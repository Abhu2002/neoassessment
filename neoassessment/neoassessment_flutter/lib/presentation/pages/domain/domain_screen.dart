import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoassessment_flutter/core/resources/capitalize.dart';
import 'package:neoassessment_flutter/domain/entities/domains/domain_entity.dart';
import 'package:neoassessment_flutter/presentation/bloc/domains/remote_domains_bloc.dart';
import 'package:neoassessment_flutter/presentation/pages/domain/domain_update_form_widget.dart';
import 'package:neoassessment_flutter/presentation/widgets/modal.dart';

import 'domain_create_form_widget.dart';
import 'domain_delete_modal.dart';

class DomainScreen extends StatefulWidget {
  const DomainScreen({super.key});

  @override
  State<DomainScreen> createState() => _DomainScreenState();
}

class _DomainScreenState extends State<DomainScreen> {
  PageController pageController = PageController();
  final createFormKey = GlobalKey<FormState>();
  TextEditingController domainNameController = TextEditingController();
  TextEditingController domainDescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<RemoteDomainsBloc>(context).add(GetDomainsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemoteDomainsBloc, RemoteDomainsState>(
      builder: (context, state) {
        if (state is LoadDomainsState) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(right: 4.0, left: 4.0, bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Domains",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showModal(
                            context,
                            form: createForm(
                              context,
                              domainNameController: domainNameController,
                              domainDescriptionController:
                                  domainDescriptionController,
                            ),
                            title: "Create Domain",
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Create",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: state.domains.isNotEmpty
                      ? ListView.builder(
                          itemCount: state.domains.length,
                          itemBuilder: (context, index) {
                            List<DomainEntity> data = state.domains;

                            return Card(
                              color: Colors.white,
                              child: ListTile(
                                title: Text(
                                  data[index].name!.capitalize(),
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                subtitle: Text(
                                  data[index].description!,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          domainNameController.text =
                                              data[index].name!;
                                          domainDescriptionController.text =
                                              data[index].description!;
                                          showModal(context,
                                              form: updateForm(
                                                context,
                                                domainNameController:
                                                    domainNameController,
                                                domainDescriptionController:
                                                    domainDescriptionController,
                                                id: data[index].id!,
                                              ),
                                              title: "Update Domain");
                                        },
                                        icon: const Icon(Icons.edit),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          deleteModal(
                                            context,
                                            data[index].id,
                                            title: "Delete Domain",
                                          );
                                        },
                                        icon: const Icon(Icons.delete),
                                      ),
                                    ]),
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text("No Domains Exists")],
                          ),
                        ),
                )
              ],
            ),
          );
        }

        if (state is RemoteDomainsError) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  state.message,
                ),
              )
            ],
          );
        }
        return const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: CircularProgressIndicator(),
            ),
          ],
        );
      },
    );
  }
}
