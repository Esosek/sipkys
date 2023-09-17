import 'package:flutter/material.dart';

class KeyboardKey extends StatelessWidget {
  const KeyboardKey(
    this.label, {
    super.key,
    required this.onTap,
    this.flex = 1,
    this.spacing = 0,
    this.backgroundColor,
    this.foregroundColor,
  });

  final String label;
  final int flex;
  final void Function(String) onTap;
  final double spacing;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: EdgeInsets.all(spacing),
        child: Material(
          child: InkWell(
            onTap: () => onTap(label),
            child: Ink(
              padding: const EdgeInsets.symmetric(vertical: 14),
              color:
                  backgroundColor ?? Theme.of(context).colorScheme.onBackground,
              child: Center(
                child: Text(
                  label.toUpperCase(),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 13, color: foregroundColor ?? Colors.black),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
