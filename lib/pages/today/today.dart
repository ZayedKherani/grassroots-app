import 'package:flutter/material.dart';
import 'package:grassroots_app/models/dayPlan/day_plans.dart';
import 'package:grassroots_app/services/dayPlanService/day_plan_service.dart';
import 'package:grassroots_app/universals/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GrassrootsToday extends StatefulWidget {
  const GrassrootsToday({
    super.key,
  });

  @override
  State<GrassrootsToday> createState() => _GrassrootsTodayState();
}

class _GrassrootsTodayState extends State<GrassrootsToday> {
  @override
  void didUpdateWidget(
    covariant GrassrootsToday oldWidget,
  ) {
    setState(
      () {},
    );

    super.didUpdateWidget(
      oldWidget,
    );
  }

  @override
  Widget build(
    BuildContext? context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: "title",
          child: Text(
            "Today",
            style: Theme.of(
              context!,
            ).textTheme.titleLarge!,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(
          context,
        ).colorScheme.background,
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(
          context,
        ).colorScheme.onBackground,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: Center(
                child: Text(
                  "Grassroots",
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
              ),
              title: const Text(
                "Settings",
              ),
              onTap: () {
                Navigator.pop(
                  context,
                );

                Navigator.pushNamed(
                  context,
                  "/settings",
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                10.0,
                0.0,
                10.0,
                0.0,
              ),
              child: ListTile(
                title: Text(
                  "Here Are Your Plans For Today",
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge,
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.more_vert_rounded,
                  ),
                  onPressed: () {},
                ),
                // trailing: PopupMenuButton(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 0,
              child: FutureBuilder(
                future: SharedPreferences.getInstance(),
                builder: (
                  BuildContext? context,
                  AsyncSnapshot<SharedPreferences?>? snapshot,
                ) {
                  if ((snapshot!.connectionState == ConnectionState.done ||
                          snapshot.connectionState == ConnectionState.waiting ||
                          snapshot.connectionState == ConnectionState.active) &&
                      snapshot.hasData &&
                      snapshot.data != null) {
                    return Column(
                      children: [
                        () {
                          if (snapshot.data!.getBool(
                                    'isDayPlanned',
                                  ) !=
                                  null &&
                              snapshot.data!.getBool(
                                'isDayPlanned',
                              )!) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(
                                20.0,
                                0.0,
                                20.0,
                                0.0,
                              ),
                              child: StreamBuilder(
                                stream: Stream.fromIterable(
                                  [globalDayPlans!],
                                ),
                                builder: (
                                  BuildContext? context,
                                  AsyncSnapshot<DayPlans?>? dayPlanSnapshot,
                                ) {
                                  if (!dayPlanSnapshot!.hasData) {
                                    return const CircularProgressIndicator
                                        .adaptive();
                                  }

                                  return ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: dayPlanSnapshot
                                        .data!.dayPlansList!.length,
                                    itemBuilder: (
                                      BuildContext? context,
                                      int? index,
                                    ) {
                                      return Hero(
                                        tag: dayPlanSnapshot.data!
                                            .dayPlansList![index!]!.title!,
                                        child: Card(
                                          child: CheckboxListTile(
                                            title: Text(
                                              dayPlanSnapshot.data!
                                                  .dayPlansList![index]!.title!,
                                              style: Theme.of(
                                                context!,
                                              ).textTheme.bodyLarge,
                                            ),
                                            value: dayPlanSnapshot
                                                .data!
                                                .dayPlansList![index]!
                                                .isComplete!,
                                            onChanged: (
                                              bool? value,
                                            ) {
                                              DayPlanService
                                                  .toggleDayPlanCompletion(
                                                dayPlan: globalDayPlans!
                                                    .dayPlansList![index]!,
                                              );

                                              DayPlanService
                                                  .writeDayPlansToStorage();

                                              setState(
                                                () {},
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                          } else {
                            return Card(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                    context!,
                                    "/today/add_day_plan",
                                  );
                                },
                                child: const Text(
                                  "Plan Your Day",
                                ),
                              ),
                            );
                          }
                        }(),
                        Text(
                          snapshot.data!
                              .getBool(
                                'isDayPlanned',
                              )
                              .toString(),
                        ),
                        Text(
                          snapshot.data!
                              .getString(
                                'isDayPlannedDateTime',
                              )
                              .toString(),
                        ),
                        Text(
                          snapshot.data!
                              .getString(
                                'dateOfPlans${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}',
                              )
                              .toString(),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text(
                      "An Error has Occurred Please Report the Error and Try Again Later: ${snapshot.error}, ",
                      style: Theme.of(
                        context!,
                      ).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(
                              context,
                            ).colorScheme.error,
                          ),
                    );
                  } else {
                    return const CircularProgressIndicator.adaptive();
                  }
                },
              ),
            ),
            FutureBuilder(
              future: SharedPreferences.getInstance(),
              builder: (
                BuildContext? context,
                AsyncSnapshot<SharedPreferences?>? snapshot,
              ) {
                if ((snapshot!.connectionState == ConnectionState.done ||
                        snapshot.connectionState == ConnectionState.waiting ||
                        snapshot.connectionState == ConnectionState.active) &&
                    snapshot.hasData &&
                    snapshot.data != null) {
                  if (snapshot.data!.getBool(
                            'isDayPlanned',
                          ) !=
                          null &&
                      snapshot.data!.getBool(
                        'isDayPlanned',
                      )!) {
                    return TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context!,
                          "/today/add_day_plan",
                        );
                      },
                      child: const Text(
                        'Edit Day Plans',
                      ),
                    );
                  }
                }
                return const Text(
                  '',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
