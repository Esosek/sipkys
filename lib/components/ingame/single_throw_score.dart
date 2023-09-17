import 'package:flutter/material.dart';

class SingleThrowScore extends StatelessWidget {
  const SingleThrowScore(this.value, {super.key});

  final int value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      color: Theme.of(context).colorScheme.secondaryContainer,
      height: 30,
      width: 25,
      child: Center(
        child: Text(
          value.toString(),
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }
}
