import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoassessment_flutter/core/resources/capitalize.dart';
import 'package:neoassessment_flutter/domain/entities/candidates/candidate_entity.dart';
import 'package:neoassessment_flutter/presentation/pages/candidate/update_candidate.dart';

import '../../bloc/candidiates/remote_candidates_bloc.dart';
import '../../bloc/candidiates/remote_candidates_event.dart';
import '../../bloc/candidiates/remote_candidates_state.dart';
import '../../widgets/modal.dart';
import 'candidate_create_form_widget.dart';
import 'delete_modal.dart';

class CandidateScreen extends StatefulWidget {
  const CandidateScreen({Key? key}) : super(key: key);

  @override
  State<CandidateScreen> createState() => _CandidateScreenState();
}

class _CandidateScreenState extends State<CandidateScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<RemoteCandidatesBloc>(context)
        .add(const GetCandidatesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemoteCandidatesBloc, RemoteCandidatesState>(
      buildWhen: (previous, current) {
        return current is LoadCandidatesState ||
            current is CreateRemoteCandidateDone;
      },
      builder: (context, state) {
        if (state is LoadCandidatesState) {
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
                        "Candidates",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showModal(
                            context,
                            form: candidateCreateForm(
                              context: context,
                              domains: state.domains ?? [],
                              roles: state.roles ?? [],
                            ),
                            title: "Create Candidate",
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
                  child: state.allCandidates.isNotEmpty
                      ? ListView.builder(
                          itemCount: state.allCandidates.length,
                          itemBuilder: (context, index) {
                            List<CandidateEntity> data =
                                state.allCandidates.cast<CandidateEntity>();

                            return Card(
                              color: Colors.white,
                              child: ListTile(
                                title: Text(
                                  "${data[index].firstName!.capitalize()} ${data[index].lastName!.capitalize()}",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          List candidatedata = [
                                            data[index].firstName!.capitalize(),
                                            data[index].lastName!.capitalize(),
                                            data[index].email!,
                                            data[index].phone,
                                            data[index].experience,
                                            data[index].dob,
                                            data[index].domainId,
                                            data[index].password
                                          ];
                                          int candidateId = data[index].id!;
                                          // domainNameController.text =
                                          //     data[index].name!;
                                          // domainDescriptionController.text =
                                          //     data[index].description!;
                                          showModal(context,
                                              form: updateCandidatesForm(
                                                context,
                                                id: candidateId,
                                                data: candidatedata,
                                                domains: state.domains ?? [],
                                                roles: state.roles ?? [],
                                              ),
                                              title: "Update Candidates");
                                        },
                                        icon: const Icon(Icons.edit),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          deleteCandidateModal(
                                            context,
                                            data[index].id,
                                            title: "Delete Candidate",
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
                            children: [Text("No Candidates Exists")],
                          ),
                        ),
                )
              ],
            ),
          );
        }

        if (state is CandidateErrorState) {
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
