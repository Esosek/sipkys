import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sipkys/components/ingame/game_player_list.dart';
import 'package:sipkys/components/ui/keyboard.dart';
import 'package:sipkys/models/player.dart';
import 'package:sipkys/providers/game_mode_provider.dart';
import 'package:sipkys/providers/players_provider.dart';
import 'package:sipkys/providers/score_provider.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  late List<Player> players;
  late String gameMode;
  late ScoreNotifier scoreProviderNotifier;
  @override
  void initState() {
    super.initState();
    players = ref.read(activePlayersProvider);
    gameMode = ref.read(gameModeProvider);
    scoreProviderNotifier = ref.read(scoreProvider.notifier);
  }

  int _activePlayerId = 0;
  int _darts = 3;
  bool _isDouble = false;
  bool _isTriple = false;

  void onKeyboardTap(String keyCode) {
    if (keyCode == 'Vrátit') {
      _isTriple = false;
      _isDouble = false;
    } else if (keyCode == 'Double') {
      _isTriple = false;
      _isDouble = !_isDouble;
    } else if (keyCode == 'Triple') {
      _isTriple = !_isTriple;
      _isDouble = false;
    } else {
      int value = int.parse(keyCode);
      submitThrow(value);
    }
  }

  void submitThrow(int value) {
    int finalValue = value;
    if (_isTriple && value != 25) {
      finalValue = value * 3;
      _isTriple = false;
    }
    if (_isDouble) {
      finalValue = value * 2;
      _isDouble = false;
    }
    // Overthrew
    if (finalValue >
        ref.read(scoreProvider)[players[_activePlayerId]]!.totalScore) {
      passTurn();
      return;
    }
    scoreProviderNotifier.submitThrow(players[_activePlayerId], finalValue);
    _darts--;
    if (_darts == 0) {
      passTurn();
    }
  }

  void passTurn() {
    _darts = 3;
    setState(() {
      if (_activePlayerId == players.length - 1) {
        _activePlayerId = 0;
      } else {
        _activePlayerId++;
      }
    });

    // Clear current round scores UI for newly active player
    scoreProviderNotifier.resetPlayerRoundScore(players[_activePlayerId]);
  }

  @override
  Widget build(BuildContext context) {
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
          GamePlayerList(
            activePlayerIndex: _activePlayerId,
          ),
          const SizedBox(height: 5),
          Keyboard(
            onTap: onKeyboardTap,
          ),
        ],
      ),
    );
  }
}
