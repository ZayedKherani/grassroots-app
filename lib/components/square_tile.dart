import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  const SquareTile({
    super.key,
    required this.imagePath,
    required this.onTap,
  });

  final String? imagePath;

  final Function()? onTap;

  @override
  Widget build(
    BuildContext? context,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(
            context!,
          ).colorScheme.surface,
          borderRadius: BorderRadius.circular(
            24.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(
                context,
              ).colorScheme.surface.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Image.asset(
          imagePath!,
          height: 40,
        ),
      ),
    );
  }
}
