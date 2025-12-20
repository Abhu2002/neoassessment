import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoassessment_flutter/core/resources/capitalize.dart';
import 'package:neoassessment_flutter/presentation/pages/status/update_status_widget.dart';
import 'package:neoassessment_flutter/presentation/widgets/modal.dart';

import '../../../domain/entities/status/status_entity.dart';
import '../../bloc/status/remote_status_bloc.dart';
import '../../bloc/status/remote_status_event.dart';
import '../../bloc/status/remote_status_state.dart';
import 'create_status_widget.dart';
import 'delete_status_widget.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({super.key});

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  PageController pageController = PageController();
  final createFormKey = GlobalKey<FormState>();
  TextEditingController domainNameController = TextEditingController();
  TextEditingController domainDescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<RemoteStatusBloc>(context).add(GetStatusEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemoteStatusBloc, RemoteStatusState>(
      builder: (context, state) {
        if (state is LoadStatusState) {
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
                        "Status",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showModal(
                            context,
                            form: createForm(
                              context,
                              statusNameController: domainNameController,
                            ),
                            title: "Create Status",
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
                      List<StatusEntity> data = state.domains;

                      return Card(
                        color: Colors.white,
                        child: ListTile(
                          title: Text(
                            data[index].status!.capitalize(),
                            style:
                            Theme.of(context).textTheme.titleMedium,
                          ),
                          trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    domainNameController.text =
                                    data[index].status!;
                                    showModal(context,
                                        form: updateForm(
                                          context,
                                          statusNameController:
                                          domainNameController,
                                          id: data[index].id!,
                                        ),
                                        title: "Update Status");
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {
                                    deleteModal(
                                      context,
                                      data[index].id,
                                      title: "Delete Status",
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
                      children: [Text("No Status Exists")],
                    ),
                  ),
                )
              ],
            ),
          );
        }

        if (state is RemoteStatusError) {
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
