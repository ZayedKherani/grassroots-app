import 'package:flutter/material.dart';

class GrassrootsCalendar extends StatefulWidget {
  const GrassrootsCalendar({
    super.key,
  });

  @override
  State<GrassrootsCalendar> createState() => _GrassrootsCalendarState();
}

class _GrassrootsCalendarState extends State<GrassrootsCalendar> {
  @override
  Widget build(
    BuildContext? context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: "title",
          child: Text(
            "Calendar",
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
      body: const Center(
        child: Text(
          'Calendar',
        ),
      ),
    );
  }
}
