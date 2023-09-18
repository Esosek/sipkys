import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sipkys/components/ingame/game_player_list.dart';
import 'package:sipkys/components/ui/keyboard.dart';
import 'package:sipkys/providers/game_mode_provider.dart';
import 'package:sipkys/providers/players_provider.dart';
import 'package:sipkys/providers/score_provider.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  @override
  void onKeyboardTap(String keyCode) {
    print('$keyCode was pressed');
  }

  @override
  Widget build(BuildContext context) {
    final players = ref.read(activePlayersProvider);
    final gameMode = ref.read(gameModeProvider);

    String playerText = 'hráči';
    if (players.length == 1) {
      playerText = 'hráč';
    } else if (players.length > 4) {
      playerText = 'hráčů';
    }

    final screenTitle =
        'Mód $gameMode - ${players.length.toString()} $playerText';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(
          screenTitle,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
        ),
      ),
      body: Column(
        children: [
          const GamePlayerList(),
          const SizedBox(height: 5),
          Keyboard(
            onTap: onKeyboardTap,
          ),
        ],
      ),
    );
  }
}
