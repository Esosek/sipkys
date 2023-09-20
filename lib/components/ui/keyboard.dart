import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sipkys/components/ui/keyboard_key.dart';
import 'package:sipkys/providers/modifier_provider.dart';

class Keyboard extends ConsumerWidget {
  const Keyboard({super.key, required this.onTap});

  final double _spacing = 2.5;
  final void Function(String) onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modifiers = ref.watch(modifierProvider);

    return Container(
      color: Theme.of(context).colorScheme.background,
      padding: EdgeInsets.all(_spacing),
      child: Column(
        children: [
          Row(
            children: [
              KeyboardKey('0', spacing: _spacing, onTap: onTap),
              KeyboardKey(
                'Double',
                isActive: modifiers[Modifier.double]!,
                spacing: _spacing,
                flex: 2,
                onTap: onTap,
                foregroundColor: Colors.white,
                backgroundColor:
                    Theme.of(context).colorScheme.primary.withOpacity(.3),
              ),
              KeyboardKey(
                'Triple',
                spacing: _spacing,
                isActive: modifiers[Modifier.triple]!,
                flex: 2,
                onTap: onTap,
                foregroundColor: Colors.white,
                backgroundColor:
                    Theme.of(context).colorScheme.primary.withOpacity(.5),
              ),
              KeyboardKey(
                'Vrátit',
                spacing: _spacing,
                flex: 2,
                onTap: onTap,
                foregroundColor: Colors.white,
                backgroundColor: Theme.of(context).colorScheme.errorContainer,
              )
            ],
          ),
          Row(
            children: [
              for (int i = 1; i <= 7; i++)
                KeyboardKey(i.toString(), spacing: _spacing, onTap: onTap),
            ],
          ),
          Row(
            children: [
              for (int i = 8; i <= 14; i++)
                KeyboardKey(i.toString(), spacing: _spacing, onTap: onTap),
            ],
          ),
          Row(
            children: [
              for (int i = 15; i <= 20; i++)
                KeyboardKey(i.toString(), spacing: _spacing, onTap: onTap),
              KeyboardKey('25', spacing: _spacing, onTap: onTap),
            ],
          ),
        ],
      ),
    );
  }
}
