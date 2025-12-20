import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoassessment_flutter/core/resources/capitalize.dart';
import 'package:neoassessment_flutter/domain/entities/roles/role_entity.dart';
import 'package:neoassessment_flutter/presentation/bloc/roles/remote_roles_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/roles/remote_roles_state.dart';
import 'package:neoassessment_flutter/presentation/pages/role/delete_modal.dart';
import 'package:neoassessment_flutter/presentation/pages/role/update_role.dart';

import '../../bloc/roles/remote_roles_event.dart';
import '../../widgets/modal.dart';
import 'createRoleForm.dart';

class RolesScreen extends StatefulWidget {
  const RolesScreen({Key? key}) : super(key: key);

  @override
  State<RolesScreen> createState() => _RolesScreenState();
}

class _RolesScreenState extends State<RolesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<RemoteRolesBloc>(context).add(const GetRoles());
  }

  final createFormKey = GlobalKey<FormState>();
  TextEditingController roleNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RemoteRolesBloc, RemoteRolesState>(
      builder: ((context, state) {
        if (state is RemoteRolesDone) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 4, left: 4, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Roles",
                          style: Theme.of(context).textTheme.headlineMedium),
                      ElevatedButton(
                          onPressed: () {
                            showModal(context,
                                form: createForm(
                                  context,
                                  roleNameController: roleNameController,
                                ),
                                title: "Create Role");
                          },
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Create",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        color: Colors.white, fontSize: 18),
                              )))
                    ],
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: state.result.length,
                        itemBuilder: (context, index) {
                          List<RoleEntity> data = state.result;
                          return Card(
                              color: Colors.white,
                              child: ListTile(
                                title: Text(data[index].name!.capitalize(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          roleNameController.text =
                                              data[index].name!;

                                          showModal(context,
                                              form: updateForm(context,
                                                  id: data[index].id!,
                                                  roleNameController:
                                                      roleNameController),
                                              title: "Update Role");
                                        },
                                        icon: const Icon(Icons.edit)),
                                    IconButton(
                                        onPressed: () {
                                          deleteModal(context, data[index].id,
                                              title: "Roles Delete");
                                        },
                                        icon: const Icon(Icons.delete))
                                  ],
                                ),
                              ));
                        }))
              ],
            ),
          );
        }

        if (state is RemoteRolesError) {
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text("Error"),
              )
            ],
          );
        }
        return const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: CircularProgressIndicator(),
            )
          ],
        );
      }),
      listener: (BuildContext context, RemoteRolesState state) {},
    );
  }
}
