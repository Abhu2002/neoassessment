import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoassessment_flutter/domain/entities/response/response_entity.dart';
import 'package:neoassessment_flutter/presentation/bloc/responses/remote_response_event.dart';
import 'package:neoassessment_flutter/presentation/bloc/responses/remote_response_state.dart';

import '../../../domain/entities/status/status_entity.dart';
import '../../../domain/entities/users/user_entity.dart';
import '../../bloc/responses/remote_response_bloc.dart';

class UpdateResponse extends StatefulWidget {
  final List<UserEntity> reviewers;
  final List<StatusEntity> status;
  final String reviewer;
  final String statusName;
  final ResponseEntity responseEntity;

  const UpdateResponse({
    super.key,
    required this.reviewers,
    this.reviewer = "NA",
    required this.responseEntity,
    required this.status,
    required this.statusName,
  });

  @override
  State<UpdateResponse> createState() => _UpdateResponseState();
}

class _UpdateResponseState extends State<UpdateResponse> {
  final updateFormKey = GlobalKey<FormState>();
  late final TextEditingController reviewByController;
  late final TextEditingController statusController;

  @override
  void initState() {
    super.initState();
    reviewByController = TextEditingController();
    statusController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    reviewByController.dispose();
    statusController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int newReviewer = 0;
    int newStatus = 0;

    for (var rev in widget.reviewers) {
      if ("${rev.firstName} ${rev.lastName}" == widget.reviewer) {
        newReviewer = rev.id!;
        break;
      }
    }

    for (var st in widget.status) {
      if (st.status == widget.statusName) {
        newStatus = st.id!;
        break;
      }
    }

    return Form(
      key: updateFormKey,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 15, bottom: 0),
              child: DropdownButtonFormField(
                hint: const Text("Select reviewer"),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  )),
                ),
                value: widget.reviewer == 'NA' ? null : widget.reviewer,
                items: widget.reviewers.map((reviewer) {
                  return DropdownMenuItem(
                    value: "${reviewer.firstName} ${reviewer.lastName}",
                    child: Text("${reviewer.firstName} ${reviewer.lastName}"),
                  );
                }).toList(),
                onChanged: (value) {
                  for (var rev in widget.reviewers) {
                    if ("${rev.firstName} ${rev.lastName}" == value) {
                      newReviewer = rev.id!;
                      break;
                    }
                  }
                },
                icon: const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Icon(Icons.arrow_circle_down_sharp)),
                iconEnabledColor: Colors.black,
                style: const TextStyle(color: Colors.black, fontSize: 20),
                dropdownColor: Colors.white,
                isExpanded: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 15, bottom: 0),
              child: DropdownButtonFormField(
                hint: const Text("Select status"),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  )),
                ),
                value: widget.statusName == 'NA' ? null : widget.statusName,
                items: widget.status.map((st) {
                  return DropdownMenuItem(
                    value: st.status,
                    child: Text("${st.status}"),
                  );
                }).toList(),
                onChanged: (value) {
                  for (var st in widget.status) {
                    if (st.status == value) {
                      newStatus = st.id!;
                      break;
                    }
                  }
                },
                icon: const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Icon(Icons.arrow_circle_down_sharp)),
                iconEnabledColor: Colors.black,
                style: const TextStyle(color: Colors.black, fontSize: 20),
                dropdownColor: Colors.white,
                isExpanded: true,
              ),
            ),
            BlocConsumer<RemoteResponseBloc, RemoteResponseState>(
              builder: (context, state) {
                return SizedBox(
                  height: 50,
                  width: 250,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        ResponseEntity response = ResponseEntity(
                          id: widget.responseEntity.id,
                          reviewedBy: newReviewer,
                          statusId: newStatus,
                        );
                        BlocProvider.of<RemoteResponseBloc>(context)
                            .add(UpdateResponseEvent(
                          responseEntity: response,
                        ));
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
                if (state is ResponseErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(state.message),
                    ),
                  );
                }
                if (state is ResponseUpdatedState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green,
                      content: Text(state.message),
                    ),
                  );
                  BlocProvider.of<RemoteResponseBloc>(context)
                      .add(const GetResponsesEvent());
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
