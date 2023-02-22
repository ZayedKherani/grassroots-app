import 'package:flutter/material.dart';

class GrassrootsSupport extends StatefulWidget {
  const GrassrootsSupport({
    super.key,
  });

  @override
  State<GrassrootsSupport> createState() => _GrassrootsSupportState();
}

class _GrassrootsSupportState extends State<GrassrootsSupport> {
  @override
  Widget build(
    BuildContext? context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: "title",
          child: Text(
            "Support",
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
          'Support',
        ),
      ),
    );
  }
}
