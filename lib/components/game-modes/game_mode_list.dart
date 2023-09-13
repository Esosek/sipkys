import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sipkys/components/game-modes/game_mode_item.dart';
import 'package:sipkys/providers/game_mode_provider.dart';

class GameModeList extends ConsumerWidget {
  const GameModeList({super.key});

  void setMode(String mode, WidgetRef ref) {
    ref.read(gameModeProvider.notifier).setMode(mode);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < gameModes.length; i++)
          GameModeItem(
            title: gameModes[i],
            isActive: ref.watch(gameModeProvider) == gameModes[i],
            onPressed: (String mode) {
              setMode(mode, ref);
            },
          ),
      ],
    );
  }
}
