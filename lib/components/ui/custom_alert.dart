import 'package:flutter/material.dart';

class CustomAlert extends StatelessWidget {
  const CustomAlert(this.ctx, {super.key, this.title, required this.content});

  final BuildContext ctx;
  final String? title;
  final String content;

  @override
  Widget build(BuildContext context) {
    final titleWidget = title != null
        ? Text(
            title!,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          )
        : null;

    return AlertDialog(
      title: titleWidget,
      content: Text(
        content,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.white60,
            ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(ctx);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
