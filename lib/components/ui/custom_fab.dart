import 'package:flutter/material.dart';

class CustomFAB extends StatelessWidget {
  const CustomFAB({super.key, required this.icon, required this.onPressed});

  final IconData icon;
  final void Function() onPressed;

  Future<double> get _finalSize => Future<double>.value(70);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double>(
      future: _finalSize,
      initialData: 0,
      builder: ((context, snapshot) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeOut,
          width: snapshot.data,
          height: snapshot.data,
          child: FloatingActionButton(
            onPressed: onPressed,
            splashColor:
                Theme.of(context).colorScheme.onPrimary.withOpacity(0.3),
            backgroundColor: Theme.of(context).colorScheme.primary,
            shape: const CircleBorder(),
            child: Icon(
              icon,
              size: 40,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        );
      }),
    );
  }
}
