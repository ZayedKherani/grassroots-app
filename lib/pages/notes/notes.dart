import 'package:flutter/material.dart';

class GrassrootsNotes extends StatefulWidget {
  const GrassrootsNotes({
    super.key,
  });

  @override
  State<GrassrootsNotes> createState() => _GrassrootsNotesState();
}

class _GrassrootsNotesState extends State<GrassrootsNotes> {
  @override
  Widget build(
    BuildContext? context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: "title",
          child: Text(
            "Notes",
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
          'Notes',
        ),
      ),
    );
  }
}
