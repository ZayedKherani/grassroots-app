import 'package:flutter/material.dart';

class GrassrootsTodayAddNotes extends StatefulWidget {
  const GrassrootsTodayAddNotes({
    super.key,
  });

  @override
  State<GrassrootsTodayAddNotes> createState() =>
      _GrassrootsTodayAddNotesState();
}

class _GrassrootsTodayAddNotesState extends State<GrassrootsTodayAddNotes> {
  @override
  Widget build(
    BuildContext? context,
  ) {
    final int? args = ModalRoute.of(
      context!,
    )!
        .settings
        .arguments as int?;

    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: "title",
          child: Text(
            'Add Notes',
            style: Theme.of(
              context,
            ).textTheme.titleLarge,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(
          context,
        ).colorScheme.background,
      ),
      body: Center(
        child: Text(
          'Add Notes: $args',
        ),
      ),
    );
  }
}
