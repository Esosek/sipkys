import 'package:flutter/material.dart';

class CustomElevatedBtn extends StatelessWidget {
  const CustomElevatedBtn(
      {super.key, required this.title, required this.onPressed});

  final void Function() onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          elevation: 5,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          shape: const LinearBorder()),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .labelLarge!
            .copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer),
      ),
    );
  }
}
