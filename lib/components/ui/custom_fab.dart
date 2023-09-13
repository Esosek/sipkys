import 'package:flutter/material.dart';

class CustomFAB extends StatelessWidget {
  const CustomFAB({super.key, required this.icon, required this.onPressed});

  final IconData icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 70,
      child: FloatingActionButton(
        onPressed: onPressed,
        splashColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.3),
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: const CircleBorder(),
        child: Icon(
          icon,
          size: 40,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
