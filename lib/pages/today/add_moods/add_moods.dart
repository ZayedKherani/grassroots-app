import 'package:flutter/material.dart';

class GrassrootsTodayAddMoods extends StatefulWidget {
  const GrassrootsTodayAddMoods({
    super.key,
  });

  @override
  State<GrassrootsTodayAddMoods> createState() =>
      _GrassrootsTodayAddMoodsState();
}

class _GrassrootsTodayAddMoodsState extends State<GrassrootsTodayAddMoods> {
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
            'Add Moods',
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
          'Add Moods: $args',
        ),
      ),
    );
  }
}
