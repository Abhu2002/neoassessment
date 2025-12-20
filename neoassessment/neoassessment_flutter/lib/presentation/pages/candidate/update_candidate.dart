import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/domains/domain_entity.dart';
import '../../../domain/entities/roles/role_entity.dart';
import '../../bloc/candidiates/remote_candidates_bloc.dart';
import '../../bloc/candidiates/remote_candidates_event.dart';
import '../../bloc/candidiates/remote_candidates_state.dart';

Widget updateCandidatesForm(
  BuildContext context, {
  required int id,
  required dynamic data,
  required List<DomainEntity> domains,
  required List<RoleEntity> roles,
}) {
  final updateFormKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  firstNameController.text = data[0];

  TextEditingController lastNameController = TextEditingController();
  lastNameController.text = data[1];

  TextEditingController emailController = TextEditingController();
  emailController.text = data[2];

  TextEditingController phoneController = TextEditingController();
  phoneController.text = data[3];

  TextEditingController expController = TextEditingController();
  expController.text = data[4].toString();

  TextEditingController dobController = TextEditingController();
  dobController.text = data[5].toString();

  TextEditingController passController = TextEditingController();
  passController.text = data[7].toString();

  String dropdownvalue = "Xamarin";
  int roleId = 0;
  int domainId = 0;

  return Form(
    key: updateFormKey,
    child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: TextFormField(
            controller: firstNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter First name';
              }
              return null;
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              )),
              labelText: 'First Name',
              hintText: 'Enter First name',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: TextFormField(
            controller: lastNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Last Name name';
              }
              return null;
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              )),
              labelText: 'Last Name',
              hintText: 'Enter Last name',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: TextFormField(
            controller: emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Email';
              }
              return null;
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              )),
              labelText: 'Email ID',
              hintText: 'Enter  your Email ID',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: TextFormField(
            controller: phoneController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your Phone No.';
              }
              return null;
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              )),
              labelText: 'Phone No.',
              hintText: 'Enter  your Phone No.',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: TextFormField(
            controller: expController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your Exp.';
              }
              return null;
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              )),
              labelText: 'Experience',
              hintText: 'Enter your Experience ',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 10.0, right: 10.0, top: 15, bottom: 0),
          child: TextFormField(
            controller: dobController,
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
                dobController.text = formattedDate;
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
        BlocBuilder<RemoteCandidatesBloc, RemoteCandidatesState>(
          // buildWhen: (previous, current) {
          //   return current is DomainChangedState;
          // },
          builder: (context, state) {
            // if (state is DomainChangedState) {
            //   dropdownvalue = state.newDomain;
            // } else {
            for (int i = 0; i < domains.length; i++) {
              if (data[6] == domains[i].id) {
                domainId = data[6];
                dropdownvalue = domains[i].name!;
                break;
              }
            }
            // }
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
              ),
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: ListTile(
                title: const Text("Domain"),
                contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                trailing: SizedBox(
                  width: 135,
                  height: 100,
                  child: DropdownButton(
                    hint: const SizedBox(
                      width: 150, //and here
                      child: Text(
                        "Select Domain Type",
                        style: TextStyle(color: Colors.grey),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    value: dropdownvalue,
                    items: domains.map((domain) {
                      return DropdownMenuItem(
                        value: domain.name!,
                        child: SizedBox(
                            width: 150,
                            child: Text(
                              domain.name!,
                              textAlign: TextAlign.end,
                            )),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      for (int i = 0; i < domains.length; i++) {
                        if (newValue == domains[i].name) {
                          domainId = domains[i].id!;
                        }
                      }
                      // BlocProvider.of<RemoteCandidatesBloc>(context)
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
                ),
              ),
            );
          },
        ),
        // BlocBuilder<RemoteCandidatesBloc, RemoteCandidatesState>(
        //     buildWhen: (previous, current) {
        //   return current is RoleChangedState;
        // },
        //     builder: (context, state) {
        //   if (state is RoleChangedState) {
        //     roledropdownvalue = state.newRole;
        //   } else {
        //     for (int i = 0; i < roles.length; i++) {
        //       if (data[7] == roles[i].id) {
        //         roleId = data[7];
        //         roledropdownvalue = roles[i].name!;
        //         break;
        //       }
        //     }
        //   }
        //   return Card(
        //       elevation: 4,
        //       shape: RoundedRectangleBorder(
        //         side: const BorderSide(
        //           color: Colors.grey,
        //         ),
        //         borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
        //       ),
        //       margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        //       child: ListTile(
        //         title: const Text("Role"),
        //         contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
        //         trailing: SizedBox(
        //           width: 160,
        //           height: 100,
        //           child: DropdownButton(
        //             hint: const SizedBox(
        //               width: 150, //and here
        //               child: Text(
        //                 "Select Role Type",
        //                 style: TextStyle(color: Colors.grey),
        //                 textAlign: TextAlign.end,
        //               ),
        //             ),
        //             value: roledropdownvalue,
        //             items: roles.map((role) {
        //               return DropdownMenuItem(
        //                 value: role.name,
        //                 child: Text(
        //                   role.name!.capitalize(),
        //                   textAlign: TextAlign.end,
        //                 ),
        //               );
        //             }).toList(),
        //             onChanged: (String? newValue) {
        //               for (int i = 0; i < roles.length; i++) {
        //                 if (newValue == roles[i].name) {
        //                   roleId = roles[i].id!;
        //                 }
        //               }
        //               BlocProvider.of<RemoteCandidatesBloc>(context)
        //                   .add(ChangeRoleEvent(newValue!, roleId));
        //             },
        //             icon: const Padding(
        //                 padding: EdgeInsets.only(left: 20),
        //                 child: Icon(Icons.arrow_circle_down_sharp)),
        //             iconEnabledColor: Colors.black,
        //             style: const TextStyle(color: Colors.black, fontSize: 20),
        //             dropdownColor: Colors.white,
        //             isExpanded: true,
        //           ),
        //         ),
        //       ));
        // }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: TextFormField(
            controller: passController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your Password.';
              }
              return null;
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              )),
              labelText: 'Password',
              hintText: 'Enter your Password ',
            ),
          ),
        ),
        BlocConsumer<RemoteCandidatesBloc, RemoteCandidatesState>(
          builder: (context, state) {
            return SizedBox(
              height: 50,
              width: 250,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (updateFormKey.currentState!.validate()) {
                      DateTime tempDate =
                          DateFormat("yyyy-MM-dd").parse(dobController.text);
                      BlocProvider.of<RemoteCandidatesBloc>(context).add(
                        UpdateCandidateEvent(
                            id,
                            firstNameController.text,
                            lastNameController.text,
                            emailController.text,
                            phoneController.text,
                            int.parse(expController.text),
                            tempDate,
                            domainId,
                            roleId,
                            passController.text),
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
            if (state is CandidateErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(state.error),
                ),
              );
            }
            if (state is UpdateCandidatesDone) {
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
  );
}
