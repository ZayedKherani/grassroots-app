import 'package:flutter/material.dart';

class GrassrootsTodayAddDayPlan extends StatefulWidget {
  const GrassrootsTodayAddDayPlan({super.key});

  @override
  State<GrassrootsTodayAddDayPlan> createState() =>
      _GrassrootsTodayAddDayPlanState();
}

class _GrassrootsTodayAddDayPlanState extends State<GrassrootsTodayAddDayPlan> {
  @override
  Widget build(
    BuildContext? context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: "title",
          child: Text(
            "Plan Your Day",
            style: Theme.of(
              context!,
            ).textTheme.titleLarge,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(
          context,
        ).colorScheme.background,
      ),
      body: Container(),
    );
  }
}
