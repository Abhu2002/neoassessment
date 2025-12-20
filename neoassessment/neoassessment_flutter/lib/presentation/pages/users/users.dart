import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoassessment_flutter/core/resources/capitalize.dart';
import 'package:neoassessment_flutter/domain/entities/users/user_entity.dart';
import 'package:neoassessment_flutter/presentation/bloc/users/remote_users_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/users/remote_users_event.dart';
import 'package:neoassessment_flutter/presentation/bloc/users/remote_users_state.dart';
import 'package:neoassessment_flutter/presentation/pages/users/update_users.dart';
import 'package:neoassessment_flutter/presentation/pages/users/user_create_form_widget.dart';

import '../../widgets/modal.dart';
import 'delete_modal.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<RemoteUsersBloc>(context).add(const GetUsersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemoteUsersBloc, RemoteUsersState>(
      buildWhen: (previous, current) {
        return current is LoadUsersState || current is UserErrorState;
      },
      builder: (context, state) {
        if (state is LoadUsersState) {
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
                        "Staff",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showModal(
                            context,
                            form: userCreateForm(
                              context: context,
                              domains: state.domains ?? [],
                              roles: state.roles ?? [],
                            ),
                            title: "Create User",
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
                  child: state.allUsers.isNotEmpty
                      ? ListView.builder(
                          itemCount: state.allUsers.length,
                          itemBuilder: (context, index) {
                            List<UserEntity> data = state.allUsers;
                            var domainName = '';
                            var roleName = '';

                            for (var domain in state.domains!) {
                              if (domain.id == data[index].domainId) {
                                domainName = domain.name!;
                                break;
                              }
                            }

                            for (var role in state.roles!) {
                              if (role.id == data[index].roleId) {
                                roleName = role.name!;
                                break;
                              }
                            }
                            return Card(
                              color: Colors.white,
                              child: ListTile(
                                title: Text(
                                  "${data[index].firstName!.capitalize()} ${data[index].lastName!.capitalize()}",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                subtitle: Text(
                                  "\n𝐃𝐨𝐦𝐚𝐢𝐧 : ${domainName.capitalize()}  \nRole : ${roleName.capitalize()}",
                                  style:
                                  Theme.of(context).textTheme.titleSmall,
                                ),
                                trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          List userdata = [
                                            data[index].firstName!.capitalize(),
                                            data[index].lastName!.capitalize(),
                                            data[index].email!,
                                            data[index].phone,
                                            data[index].experience,
                                            data[index].dob,
                                            data[index].domainId,
                                            data[index].roleId,
                                            data[index].password
                                          ];
                                          int userId = data[index].id!;
                                          // domainNameController.text =
                                          //     data[index].name!;
                                          // domainDescriptionController.text =
                                          //     data[index].description!;
                                          showModal(context,
                                              form: updateUsersForm(
                                                context,
                                                id: userId,
                                                data: userdata,
                                                domains: state.domains ?? [],
                                                roles: state.roles ?? [],
                                              ),
                                              title: "Update Users");
                                        },
                                        icon: const Icon(Icons.edit),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          deleteUserModal(
                                            context,
                                            data[index].id,
                                            title: "Delete User",
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
                            children: [Text("No Users Exists")],
                          ),
                        ),
                )
              ],
            ),
          );
        }

        if (state is UserErrorState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  state.error,
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
