import 'package:flutter/material.dart';
import 'package:grassroots_app/models/dayPlan/day_plans.dart';
import 'package:grassroots_app/models/json/dayPlan/day_plan.dart';
import 'package:grassroots_app/models/json/dayPlan/day_plans.dart';
import 'package:grassroots_app/services/dayPlanService/day_plan_service.dart';
import 'package:grassroots_app/services/jsonService/json_decode_service.dart';
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
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (
        Duration? timeStamp,
      ) async {
        SharedPreferences? prefs = await SharedPreferences.getInstance();

        if (globalDayPlans == null) {
          if (prefs.containsKey(
              'dateOfPlans${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}')) {
            JsonDayPlans? jsonDayPlans = await JsonDecodeService.decodeDayPlans(
              prefs.getString(
                'dateOfPlans${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}',
              )!,
            );

            setState(
              () {
                globalDayPlans = DayPlans.fromJson(
                  {
                    'id': jsonDayPlans!.id,
                    'dayPlansList': jsonDayPlans!.dayPlansList!
                        .map(
                          (
                            JsonDayPlan? jsonDayPlan,
                          ) =>
                              jsonDayPlan!.toJson(),
                        )
                        .toList(),
                    'dayOfPlans': jsonDayPlans!.dayOfPlans!,
                  },
                );

                jsonDayPlans = null;

                prefs = null;
              },
            );
          } else {
            setState(
              () {
                globalDayPlans = DayPlans(
                  dayOfPlans: DateTime.now(),
                );

                prefs = null;
              },
            );
          }
        }
      },
    );

    super.initState();
  }

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
              onTap: () async {
                Navigator.pop(
                  context,
                );

                await Navigator.pushNamed(
                  context,
                  "/settings",
                ).then(
                  (
                    Object? value,
                  ) =>
                      setState(
                    () {},
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Scrollbar(
          interactive: true,
          child: SingleChildScrollView(
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
                  child: FutureBuilder(
                    future: SharedPreferences.getInstance(),
                    builder: (
                      BuildContext? context,
                      AsyncSnapshot<SharedPreferences?>? snapshot,
                    ) {
                      if ((snapshot!.connectionState == ConnectionState.done ||
                              snapshot.connectionState ==
                                  ConnectionState.waiting ||
                              snapshot.connectionState ==
                                  ConnectionState.active) &&
                          snapshot.hasData &&
                          snapshot.data != null) {
                        if (snapshot.data!.getBool(
                                  'isDayPlanned',
                                ) !=
                                null &&
                            snapshot.data!.getBool(
                              'isDayPlanned',
                            )!) {
                          return ListTile(
                            title: Text(
                              "Here Are Your Plans For Today",
                              style: Theme.of(
                                context!,
                              ).textTheme.titleLarge,
                            ),
                            trailing: PopupMenuButton(
                              onSelected: (
                                int? value,
                              ) async {
                                if (value == 1) {
                                  await Navigator.pushReplacementNamed(
                                    context,
                                    "/today/add_day_plan",
                                  );
                                }
                              },
                              itemBuilder: (
                                BuildContext? context,
                              ) =>
                                  [
                                PopupMenuItem(
                                  value: 1,
                                  child: Text(
                                    'Edit Day Plans',
                                    style: Theme.of(
                                      context!,
                                    ).textTheme.bodyMedium!.copyWith(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.secondary,
                                        ),
                                  ),
                                ),
                              ],
                              elevation: 2,
                              color: Theme.of(
                                context,
                              ).colorScheme.primary,
                            ),
                          );
                        } else {
                          return Center(
                            child: Text(
                              "You Haven't Planned Your Day Yet",
                              style: Theme.of(
                                context!,
                              ).textTheme.titleLarge,
                            ),
                          );
                        }
                      } else if (snapshot.hasError) {
                        return Text(
                          snapshot.error.toString(),
                        );
                      } else {
                        return const CircularProgressIndicator.adaptive();
                      }
                    },
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
                              snapshot.connectionState ==
                                  ConnectionState.waiting ||
                              snapshot.connectionState ==
                                  ConnectionState.active) &&
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
                                            child: GestureDetector(
                                              onLongPress: () {
                                                setState(
                                                  () {
                                                    dayPlanSnapshot
                                                            .data!
                                                            .dayPlansList![index]!
                                                            .isTodayExpanded =
                                                        !dayPlanSnapshot
                                                            .data!
                                                            .dayPlansList![
                                                                index]!
                                                            .isTodayExpanded!;
                                                  },
                                                );

                                                DayPlanService
                                                    .writeDayPlansToStorage();
                                              },
                                              child: Card(
                                                child: AnimatedSize(
                                                  duration: const Duration(
                                                    milliseconds: 250,
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      CheckboxListTile(
                                                        title: Text(
                                                          dayPlanSnapshot
                                                              .data!
                                                              .dayPlansList![
                                                                  index]!
                                                              .title!,
                                                          style: Theme.of(
                                                            context!,
                                                          ).textTheme.bodyLarge,
                                                        ),
                                                        value: dayPlanSnapshot
                                                            .data!
                                                            .dayPlansList![
                                                                index]!
                                                            .isComplete!,
                                                        onChanged: (
                                                          bool? value,
                                                        ) {
                                                          DayPlanService
                                                              .toggleDayPlanCompletion(
                                                            dayPlan: globalDayPlans!
                                                                    .dayPlansList![
                                                                index]!,
                                                          );

                                                          DayPlanService
                                                              .writeDayPlansToStorage();

                                                          setState(
                                                            () {},
                                                          );
                                                        },
                                                      ),
                                                      () {
                                                        if (dayPlanSnapshot
                                                            .data!
                                                            .dayPlansList![
                                                                index]!
                                                            .isTodayExpanded!) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .fromLTRB(
                                                              10.0,
                                                              0.0,
                                                              10.0,
                                                              0.0,
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Expanded(
                                                                  flex: 5,
                                                                  child:
                                                                      ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator
                                                                          .pushNamed(
                                                                        context,
                                                                        '/today/add_notes',
                                                                        arguments:
                                                                            index,
                                                                      );
                                                                    },
                                                                    style:
                                                                        ButtonStyle(
                                                                      backgroundColor:
                                                                          MaterialStateProperty.all<
                                                                              Color>(
                                                                        Theme
                                                                            .of(
                                                                          context,
                                                                        ).colorScheme.primary,
                                                                      ),
                                                                    ),
                                                                    child: Text(
                                                                      'Add Notes',
                                                                      style: Theme
                                                                              .of(
                                                                        context,
                                                                      )
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .copyWith(
                                                                            color:
                                                                                Theme.of(
                                                                              context,
                                                                            ).colorScheme.secondary,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Expanded(
                                                                  flex: 5,
                                                                  child:
                                                                      ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator
                                                                          .pushNamed(
                                                                        context,
                                                                        '/today/add_moods',
                                                                        arguments:
                                                                            index,
                                                                      );
                                                                    },
                                                                    style:
                                                                        ButtonStyle(
                                                                      backgroundColor:
                                                                          MaterialStateProperty.all<
                                                                              Color>(
                                                                        Theme
                                                                            .of(
                                                                          context,
                                                                        ).colorScheme.primary,
                                                                      ),
                                                                    ),
                                                                    child: Text(
                                                                      'Add Moods',
                                                                      style: Theme
                                                                              .of(
                                                                        context,
                                                                      )
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .copyWith(
                                                                            color:
                                                                                Theme.of(
                                                                              context,
                                                                            ).colorScheme.secondary,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        } else {
                                                          return Container();
                                                        }
                                                      }(),
                                                    ],
                                                  ),
                                                ),
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
                                    onPressed: () async {
                                      await Navigator.pushReplacementNamed(
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
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              snapshot.data!
                                  .getBool(
                                    'isDayPlanned',
                                  )
                                  .toString(),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              snapshot.data!
                                  .getString(
                                    'isDayPlannedDateTime',
                                  )
                                  .toString(),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              snapshot.data!
                                  .getString(
                                    'dateOfPlans${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}',
                                  )
                                  .toString(),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              globalDayPlans != null
                                  ? globalDayPlans!.toJson().toString()
                                  : 'null global day plans',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              snapshot.data!
                                  .getStringList(
                                    'dayPlanDates',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
