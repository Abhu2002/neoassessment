import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoassessment_flutter/domain/entities/level/level_entity.dart';
import 'package:neoassessment_flutter/presentation/bloc/levels/remote_levels_event.dart';
import 'package:neoassessment_flutter/presentation/pages/level/createLevelForm.dart';
import 'package:neoassessment_flutter/presentation/pages/level/update_level.dart';

import '../../bloc/levels/remote_levels_bloc.dart';
import '../../bloc/levels/remote_levels_state.dart';
import '../../widgets/modal.dart';
import 'delete_modal.dart';

class LevelScreen extends StatefulWidget {
  const LevelScreen({Key? key}) : super(key: key);

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<RemoteLevelsBloc>(context).add(GetLevelEvent());
  }

  final createFormKey = GlobalKey<FormState>();
  TextEditingController levelNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RemoteLevelsBloc, RemoteLevelsState>(
      builder: ((context, state) {
        if (state is RemoteLevelsDone) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 4, left: 4, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Levels",
                          style: Theme.of(context).textTheme.headlineMedium),
                      ElevatedButton(
                          onPressed: () {
                            showModal(context,
                                form: createForm(
                                  context,
                                  levelNameController: levelNameController,
                                ),
                                title: "Create Level");
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
                          List<LevelEntity> data = state.result;
                          return Card(
                              color: Colors.white,
                              child: ListTile(
                                title: Text(data[index].number!.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          levelNameController.text =
                                              data[index].number.toString();

                                          showModal(context,
                                              form: updateLevelForm(context,
                                                  id: data[index].id!,
                                                  levelNameController:
                                                      levelNameController),
                                              title: "Update Level ");
                                        },
                                        icon: const Icon(Icons.edit)),
                                    IconButton(
                                        onPressed: () {
                                          deleteLevelModal(
                                              context, data[index].id,
                                              title: "Level Delete");
                                        },
                                        icon: Icon(Icons.delete))
                                  ],
                                ),
                              ));
                        }))
              ],
            ),
          );
        }

        if (state is RemoteLevelsError) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text("${state.errormsg}"),
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
      listener: (BuildContext context, RemoteLevelsState state) {},
    );
  }
}
