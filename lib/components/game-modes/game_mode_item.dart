import 'package:flutter/material.dart';

class GameModeItem extends StatelessWidget {
  const GameModeItem(
      {super.key,
      required this.title,
      required this.isActive,
      required this.onPressed});

  final String title;
  final bool isActive;
  final void Function(String) onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: isActive ? 5 : 0,
            backgroundColor: isActive
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondaryContainer,
            shape: const LinearBorder()),
        onPressed: () {
          onPressed(title);
        },
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(color: isActive ? Colors.black : Colors.white70),
        ),
      ),
    );
  }
}
