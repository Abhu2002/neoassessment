import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoassessment_flutter/core/resources/capitalize.dart';
import 'package:neoassessment_flutter/domain/entities/questionCat/questionCat_entity.dart';
import 'package:neoassessment_flutter/presentation/bloc/questionCat/remote_questionCat_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/questionCat/remote_questionCat_event.dart';
import 'package:neoassessment_flutter/presentation/pages/questionCat/questionCat_create_form_widget.dart';
import 'package:neoassessment_flutter/presentation/pages/questionCat/questionCat_delete_modal.dart';
import 'package:neoassessment_flutter/presentation/pages/questionCat/questionCat_update_form_widget.dart';

import '../../../domain/entities/domains/domain_entity.dart';
import '../../bloc/questionCat/remote_questionCat_state.dart';
import '../../widgets/modal.dart';

class QuestionCategoryScreen extends StatefulWidget {
  const QuestionCategoryScreen({super.key});

  @override
  State<QuestionCategoryScreen> createState() => _QuestionCategoryScreenState();
}

class _QuestionCategoryScreenState extends State<QuestionCategoryScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<QuestionCatBloc>(context).add(const GetQuestionCatEvent());
  }

  TextEditingController questionCatController = TextEditingController();

  TextEditingController questionCatDescController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String domainName = "";
    return BlocBuilder<QuestionCatBloc, RemoteQuestionCatState>(
      builder: (context, state) {
        if (state is RemoteQuestionCatDone) {
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
                        "Question  Category ",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          questionCatController.clear();
                          questionCatDescController.clear();
                          showModal(
                            context,
                            form: createQuestionCatForm(context,
                                questionCatController: questionCatController,
                                questionCatDescController:
                                    questionCatDescController,
                                domains: state.domains ?? []),
                            title: "Create Question\nCategory",
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
                  child: state.result.isNotEmpty
                      ? ListView.builder(
                          itemCount: state.result.length,
                          itemBuilder: (context, index) {
                            List<DomainEntity>? domain = state.domains;
                            List<QuestionCatEntity> data = state.result;
                            for (int i = 0; i < domain!.length; i++) {
                              if (data[index].domainId == domain[i].id) {
                                domainName = domain[i].name!;
                              }
                            }
                            ;
                            return Card(
                              color: Colors.white,
                              child: ListTile(
                                title: Text(
                                  "${data[index].name!.capitalize()}($domainName)",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18),
                                ),
                                subtitle: Text(
                                  data[index].description!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(fontWeight: FontWeight.w300),
                                ),
                                trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          questionCatController.text =
                                              data[index].name!;
                                          questionCatDescController.text =
                                              data[index].description!;
                                          showModal(context,
                                              form: updateQuestionCatForm(
                                                  context,
                                                  id: data[index].id!,
                                                  dataDomainId:
                                                      data[index].domainId!,
                                                  domains: state.domains ?? [],
                                                  questionCatNameController:
                                                      questionCatController,
                                                  questionCatDescriptionController:
                                                      questionCatDescController),
                                              title: "UpdateCategory");
                                        },
                                        icon: const Icon(Icons.edit),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          deleteQuestionCatModal(
                                            context,
                                            data[index].id,
                                            title: "Delete Question \nCategory",
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

        if (state is RemoteQuestionCatError) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  state.errormsg,
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
