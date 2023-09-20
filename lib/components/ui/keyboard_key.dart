import 'package:flutter/material.dart';

class KeyboardKey extends StatelessWidget {
  const KeyboardKey(
    this.label, {
    super.key,
    required this.onTap,
    this.flex = 1,
    this.spacing = 0,
    this.isActive = false,
    this.backgroundColor,
    this.foregroundColor,
  });

  final String label;
  final void Function(String) onTap;
  final int flex;
  final double spacing;
  final bool isActive;
  final Color? backgroundColor;
  final Color? foregroundColor;

  static const double borderWidth = 2.5;

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
              padding: EdgeInsets.symmetric(
                  vertical: isActive ? 14 - borderWidth : 14),
              decoration: BoxDecoration(
                border: isActive
                    ? Border.all(
                        width: borderWidth,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    : null,
                color: backgroundColor ??
                    Theme.of(context).colorScheme.onBackground,
              ),
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
