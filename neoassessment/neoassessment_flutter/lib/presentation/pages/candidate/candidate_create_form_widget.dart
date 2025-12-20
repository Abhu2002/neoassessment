import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:neoassessment_flutter/presentation/bloc/candidiates/remote_candidates_state.dart';
import 'package:neoassessment_flutter/presentation/bloc/users/remote_users_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/users/remote_users_state.dart';

import '../../../domain/entities/domains/domain_entity.dart';
import '../../../domain/entities/roles/role_entity.dart';
import '../../bloc/candidiates/remote_candidates_bloc.dart';
import '../../bloc/candidiates/remote_candidates_event.dart';

Widget candidateCreateForm({
  required BuildContext context,
  required List<DomainEntity> domains,
  required List<RoleEntity> roles,
}) {
  final createFormKey = GlobalKey<FormState>();
  final TextEditingController userFirstNameController = TextEditingController();
  final TextEditingController userLastNameController = TextEditingController();
  final TextEditingController userEmailController = TextEditingController();
  final TextEditingController userPhoneController = TextEditingController();
  final TextEditingController userDobController = TextEditingController();
  //final TextEditingController userDomainIdController = TextEditingController();
  //final TextEditingController userRoleIdController = TextEditingController();
  final TextEditingController userExperienceController =
      TextEditingController();
  final TextEditingController userPasswordController = TextEditingController();
  final TextEditingController userConfirmPasswordController =
      TextEditingController();

  // Initial Selected Value
  // ignore: unused_local_variable
  String dropdownvalue = "Xamarin";
  // String roledropdownvalue = "ADMIN";
  // ignore: prefer_typing_uninitialized_variables
  var confirmPass;
  // int roleId = 0;
  int domainId = 0;
  // List of items in our dropdown menu

  return Form(
    key: createFormKey,
    child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: userFirstNameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter first name';
                }
                return null;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                )),
                labelText: 'First Name',
                hintText: 'Enter first name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10.0, top: 15, bottom: 0),
            child: TextFormField(
              controller: userLastNameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter last name';
                }
                return null;
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  )),
                  labelText: 'Last Name',
                  hintText: 'Enter last name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10.0, top: 15, bottom: 0),
            child: TextFormField(
              controller: userEmailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter email';
                }
                return null;
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  )),
                  labelText: 'Email Id',
                  hintText: 'Enter email id'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10.0, top: 15, bottom: 0),
            child: TextFormField(
              controller: userPhoneController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter phone no.';
                }
                return null;
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  )),
                  labelText: 'Phone',
                  hintText: 'Enter phone no.'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10.0, top: 15, bottom: 0),
            child: TextFormField(
              controller: userExperienceController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter experience.';
                }
                return null;
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  )),
                  labelText: 'Experience',
                  hintText: 'Enter experience'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10.0, top: 15, bottom: 0),
            child: TextFormField(
              controller: userDobController,
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2100));

                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  userDobController.text = formattedDate;
                } else {}
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                )),
                labelText: 'Date of Birth',
                hintText: 'Enter date of birth',
              ),
            ),
          ),
          BlocBuilder<RemoteUsersBloc, RemoteUsersState>(
            // buildWhen: (previous, current) {

            // return current is DomainChangedState;
            // },
            builder: (context, state) {
              // if (state is DomainChangedState) {
              //   dropdownvalue = state.newDomain;
              //   domainId = state.domainId;
              // } else {
              //   dropdownvalue = domains[0].name!.toString();
              // }
              return Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 15, bottom: 0),
                child: DropdownButtonFormField(
                  hint: const Text("Select a domain"),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    )),
                  ),
                  value: null,
                  items: domains.map((domain) {
                    return DropdownMenuItem(
                      value: domain.name!,
                      child: Text(domain.name!),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    for (int i = 0; i < domains.length; i++) {
                      if (newValue == domains[i].name) {
                        dropdownvalue = domains[i].name!;
                        domainId = domains[i].id!;
                      }
                    }
                    // BlocProvider.of<RemoteUsersBloc>(context)
                    //     .add(ChangeDomainEvent(newValue!, domainId));
                  },
                  icon: const Padding(
                      //Icon at tail, arrow bottom is default icon
                      padding: EdgeInsets.only(left: 20),
                      child: Icon(Icons.arrow_circle_down_sharp)),
                  iconEnabledColor: Colors.black,
                  //Icon color
                  style: const TextStyle(
                      //te
                      color: Colors.black,
                      fontSize: 20),

                  dropdownColor: Colors.white,
                  isExpanded: true,
                ),
              );
            },
          ),
          // BlocBuilder<RemoteUsersBloc, RemoteUsersState>(
          //     builder: (context, state) {
          //   return Padding(
          //     padding: const EdgeInsets.only(
          //         left: 10, right: 10, top: 15, bottom: 0),
          //     child: DropdownButtonFormField(
          //       hint: const Text("Select a role"),
          //       decoration: const InputDecoration(
          //         border: OutlineInputBorder(
          //             borderRadius: BorderRadius.all(
          //           Radius.circular(20.0),
          //         )),
          //       ),
          //       value: null,
          //       items: roles.map((role) {
          //         return DropdownMenuItem(
          //           value: role.name,
          //           child: Text(role.name!.capitalize()),
          //         );
          //       }).toList(),
          //       onChanged: (newValue) {
          //         for (int i = 0; i < roles.length; i++) {
          //           if (newValue == roles[i].name) {
          //             roledropdownvalue = roles[i].name!;
          //             roleId = roles[i].id!;
          //           }
          //         }
          //         // BlocProvider.of<RemoteUsersBloc>(context)
          //         //     .add(ChangeRoleEvent(newValue!, roleId));
          //       },
          //       icon: const Padding(
          //           padding: EdgeInsets.only(left: 20),
          //           child: Icon(Icons.arrow_circle_down_sharp)),
          //       iconEnabledColor: Colors.black,
          //       style: const TextStyle(color: Colors.black, fontSize: 20),
          //       dropdownColor: Colors.white,
          //       isExpanded: true,
          //     ),
          //   );
          // }),
          Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 0),
            child: TextFormField(
                controller: userPasswordController,
                validator: (String? value) {
                  confirmPass = value;
                  if (value!.isEmpty) {
                    return "Please Enter New Password";
                  } else if (value.length < 8) {
                    return "Password must be at least 8 characters long";
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                    hintText: "Enter New Password",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    )))),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 0),
            child: TextFormField(
                controller: userConfirmPasswordController,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Please Re-Enter New Password";
                  } else if (value.length < 8) {
                    return "Password must be at least 8 characters long";
                  } else if (value != confirmPass) {
                    return "Password must be same as above";
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                    hintText: "Re-Enter New Password",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    )))),
          ),
          BlocConsumer<RemoteCandidatesBloc, RemoteCandidatesState>(
            builder: (BuildContext context, RemoteCandidatesState state) {
              return SizedBox(
                height: 50,
                width: 250,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (createFormKey.currentState!.validate()) {
                        DateTime tempDate = DateFormat("yyyy-MM-dd")
                            .parse(userDobController.text);

                        BlocProvider.of<RemoteCandidatesBloc>(context).add(
                          CreateCandidateEvent(
                              userFirstNameController.text,
                              userLastNameController.text,
                              userEmailController.text,
                              userPhoneController.text,
                              int.parse(userExperienceController.text),
                              tempDate,
                              domainId,
                              userConfirmPasswordController.text),
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
            listener: (BuildContext context, RemoteCandidatesState state) {
              if (state is CandidateErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(state.error),
                  ),
                );
              }
              if (state is CreateRemoteCandidateDone) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green,
                    content: Text(state.message),
                  ),
                );
                BlocProvider.of<RemoteCandidatesBloc>(context)
                    .add(const GetCandidatesEvent());
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    ),
  );
}
