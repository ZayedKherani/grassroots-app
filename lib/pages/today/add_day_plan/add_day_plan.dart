import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:grassroots_app/models/dayPlan/day_plan.dart';
import 'package:grassroots_app/services/dayPlanService/day_plan_service.dart';
import 'package:grassroots_app/universals/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GrassrootsTodayAddDayPlan extends StatefulWidget {
  const GrassrootsTodayAddDayPlan({
    super.key,
  });

  @override
  State<GrassrootsTodayAddDayPlan> createState() =>
      _GrassrootsTodayAddDayPlanState();
}

class _GrassrootsTodayAddDayPlanState extends State<GrassrootsTodayAddDayPlan> {
  GlobalKey<FormState>? addDayPlanFormKey = GlobalKey<FormState>();
  TextEditingController? dayPlanNameController = TextEditingController();

  bool? savedChanges = true;

  @override
  Widget build(
    BuildContext? context,
  ) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (
        BuildContext? context,
        AsyncSnapshot<SharedPreferences?>? snapshot,
      ) {
        return Scaffold(
          appBar: AppBar(
            title: Hero(
              tag: "title",
              child: Text(
                () {
                  String? appTitle;

                  appTitle = (snapshot != null &&
                          snapshot.data != null &&
                          snapshot.data!.getBool(
                                'isDayPlanned',
                              ) !=
                              null &&
                          snapshot.data!.getBool(
                            'isDayPlanned',
                          )!)
                      ? "Your Day Plan${globalDayPlans!.dayPlansList!.length == 1 ? "" : "s"}"
                      : "Plan Your Day";

                  return appTitle;
                }(),
                style: Theme.of(
                  context!,
                ).textTheme.titleLarge,
              ),
            ),
            centerTitle: true,
            backgroundColor: Theme.of(
              context,
            ).colorScheme.background,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_rounded,
              ),
              onPressed: () {
                savedChanges!
                    ? Navigator.pushReplacementNamed(
                        context,
                        '/home',
                      )
                    : showDialog(
                        context: context,
                        builder: (
                          BuildContext? context,
                        ) =>
                            AlertDialog(
                          title: const Text(
                            "Are you sure you want to return to the previous page?",
                          ),
                          content: const Text(
                            "You will lose any unsaved changes.",
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(
                                  context!,
                                );
                              },
                              child: const Text(
                                "No",
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(
                                  context,
                                );

                                Navigator.pushReplacementNamed(
                                  context,
                                  '/home',
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(
                                  context!,
                                ).colorScheme.error,
                              ),
                              child: const Text(
                                "Yes",
                              ),
                            ),
                          ],
                        ),
                      );
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(
              20.0,
              0.0,
              20.0,
              0.0,
            ),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: globalDayPlans!.dayPlansList!.length,
              itemBuilder: (
                BuildContext? context,
                int? index,
              ) =>
                  Dismissible(
                key: Key(
                  globalDayPlans!.dayPlansList![index!]!.title!,
                ),
                background: Card(
                  color: Theme.of(
                    context!,
                  ).colorScheme.error,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                      ),
                      child: Icon(
                        Icons.delete,
                        color: Theme.of(
                          context,
                        ).colorScheme.onBackground,
                      ),
                    ),
                  ),
                ),
                secondaryBackground: Card(
                  color: Theme.of(
                    context,
                  ).colorScheme.error,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 16.0,
                      ),
                      child: Icon(
                        Icons.delete,
                        color: Theme.of(
                          context,
                        ).colorScheme.onBackground,
                      ),
                    ),
                  ),
                ),
                confirmDismiss: (
                  DismissDirection? direction,
                ) async {
                  if (direction == DismissDirection.endToStart ||
                      direction == DismissDirection.startToEnd) {
                    ScaffoldFeatureController<SnackBar, SnackBarClosedReason?>?
                        snackBarController;

                    bool? delete;

                    await showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (
                        BuildContext? context,
                      ) =>
                          AlertDialog(
                        title: const Text(
                          "Confirm",
                        ),
                        content: const Text(
                          "Are you sure you want to delete this item?",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              delete = false;

                              Navigator.of(
                                context!,
                              ).pop();
                            },
                            child: const Text(
                              "No",
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              delete = true;

                              Navigator.of(
                                context!,
                              ).pop();

                              snackBarController = ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                    "Day Plan Deleted",
                                  ),
                                  action: SnackBarAction(
                                    label: 'Undo',
                                    onPressed: () => delete = false,
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              "Yes",
                            ),
                          ),
                        ],
                      ),
                    );

                    DayPlan? dayPlanToDelete =
                        globalDayPlans!.dayPlansList![index];

                    setState(
                      () {
                        globalDayPlans!.dayPlansList!.removeAt(
                          index,
                        );
                      },
                    );

                    if (snackBarController != null) {
                      await snackBarController!.closed;
                    }

                    if (delete!) {
                      savedChanges = false;

                      await DayPlanService.deleteDayPlan(
                        dayPlan: dayPlanToDelete,
                      );

                      setState(
                        () {},
                      );

                      if (context.mounted) {}

                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Day Plan Deleted",
                          ),
                        ),
                      );
                    } else if (!delete!) {
                      setState(
                        () {
                          globalDayPlans!.dayPlansList!.insert(
                            index,
                            dayPlanToDelete,
                          );
                        },
                      );
                    }

                    return delete;
                  } else {
                    return false;
                  }
                },
                child: Hero(
                  tag: globalDayPlans!.dayPlansList![index]!.title!,
                  child: Card(
                    child: CheckboxListTile(
                      title: Text(
                        globalDayPlans!.dayPlansList![index]!.title!,
                      ),
                      value: globalDayPlans!.dayPlansList![index]!.isComplete,
                      onChanged: (
                        bool? value,
                      ) {
                        DayPlanService.toggleDayPlanCompletion(
                          dayPlan: globalDayPlans!.dayPlansList![index]!,
                        );

                        DayPlanService.writeDayPlansToStorage();

                        setState(
                          () {},
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          floatingActionButton: SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            children: [
              SpeedDialChild(
                child: const Icon(
                  Icons.check_rounded,
                ),
                label: "Save",
                onTap: () {
                  if (globalDayPlans!.dayPlansList!.isEmpty) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "No Day Plans To Save",
                        ),
                      ),
                    );
                  } else {
                    savedChanges = true;

                    DayPlanService.writeDayPlansToStorage();

                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Day Plans Saved",
                        ),
                      ),
                    );

                    snapshot!.data!.reload();
                  }
                },
              ),
              SpeedDialChild(
                child: const Icon(
                  Icons.add_rounded,
                ),
                label: "Add Item",
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (
                      BuildContext? context,
                    ) =>
                        AlertDialog(
                      title: const Text(
                        "Add Item",
                      ),
                      content: Form(
                        key: addDayPlanFormKey,
                        child: TextFormField(
                          controller: dayPlanNameController,
                          decoration: const InputDecoration(
                            labelText: "Item",
                          ),
                          validator: (
                            String? value,
                          ) {
                            if (value!.isEmpty) {
                              return "Please Enter a Day Plan";
                            }

                            for (int i = 0;
                                i < globalDayPlans!.dayPlansList!.length;
                                i++) {
                              if (value ==
                                  globalDayPlans!.dayPlansList![i]!.title) {
                                return "Day Plan Already Exists";
                              }
                            }

                            return null;
                          },
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(
                              context!,
                            );
                          },
                          child: const Text(
                            "Cancel",
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            if (addDayPlanFormKey!.currentState!.validate()) {
                              globalDayPlans!.dayPlansList!.add(
                                DayPlan(
                                  title: dayPlanNameController!.text,
                                  isComplete: false,
                                ),
                              );

                              dayPlanNameController!.clear();

                              addDayPlanFormKey!.currentState!.reset();

                              savedChanges = false;

                              Navigator.pop(
                                context!,
                              );

                              setState(
                                () {},
                              );
                            }
                          },
                          child: const Text(
                            "Add",
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
