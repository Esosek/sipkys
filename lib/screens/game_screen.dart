import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sipkys/components/ingame/game_player_list.dart';
import 'package:sipkys/components/ui/custom_elevated_btn.dart';
import 'package:sipkys/components/ui/keyboard.dart';
import 'package:sipkys/models/player.dart';
import 'package:sipkys/models/player_score.dart';
import 'package:sipkys/providers/game_mode_provider.dart';
import 'package:sipkys/providers/modifier_provider.dart';
import 'package:sipkys/providers/players_provider.dart';
import 'package:sipkys/providers/score_provider.dart';
import 'package:sipkys/screens/end_screen.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key, this.activePlayerIndex = 0});

  final int activePlayerIndex;

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  late List<Player> activePlayers;
  late String gameMode;
  late ScoreNotifier scoreProviderNotifier;
  late Map<Player, PlayerScore> scores;
  late ModifierNotifier modifierNotifier;

  @override
  void initState() {
    super.initState();
    activePlayers = ref.read(activePlayersProvider);
    gameMode = ref.read(gameModeProvider);
    scoreProviderNotifier = ref.read(scoreProvider.notifier);
    modifierNotifier = ref.read(modifierProvider.notifier);
    _activePlayerId = widget.activePlayerIndex;
  }

  int _activePlayerId = 0;
  int _darts = 3;

  void onKeyboardTap(String keyCode) {
    if (keyCode == 'Vrátit') {
      modifierNotifier.toggleModifier(Modifier.double, false);
      modifierNotifier.toggleModifier(Modifier.triple, false);
      revertThrow();
    } else if (keyCode == 'Double') {
      modifierNotifier.toggleModifier(Modifier.triple, false);
      modifierNotifier.toggleModifier(Modifier.double);
    } else if (keyCode == 'Triple') {
      modifierNotifier.toggleModifier(Modifier.triple);
      modifierNotifier.toggleModifier(Modifier.double, false);
    } else {
      int value = int.parse(keyCode);

      final submitSucceeded = scoreProviderNotifier.submitThrow(
          activePlayers[_activePlayerId], value);

      modifierNotifier.toggleModifier(Modifier.double, false);
      modifierNotifier.toggleModifier(Modifier.triple, false);

      if (!submitSucceeded) {
        passTurn();
        return;
      }

      // Check if the player closed the game
      if (ref.read(scoreProvider)[activePlayers[_activePlayerId]]!.totalScore ==
          0) {
        activePlayers[_activePlayerId].wins++;
        /*ref
            .read(playersProvider.notifier)
            .updatePlayerWins(activePlayers[_activePlayerId].id, 1);*/

        _darts--;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => EndScreen(
              winner: activePlayers[_activePlayerId],
              winnerIndex: _activePlayerId,
            ),
          ),
        );
        return;
      }

      // If not, use a dart and eventually pass the turn
      _darts--;
      if (_darts == 0) {
        passTurn();
      }
    }
  }

  void passTurn() {
    _darts = 3;
    setState(() {
      if (_activePlayerId == activePlayers.length - 1) {
        _activePlayerId = 0;
      } else {
        _activePlayerId++;
      }
    });

    // Clear current round scores UI for newly active player
    scoreProviderNotifier.resetPlayerRoundScore(activePlayers[_activePlayerId]);
  }

  void revertThrow() {
    if (_activePlayerId == 0) {
      // No throws to revert
      if (scores[activePlayers[_activePlayerId]]!.throwScores.isEmpty) {
        return;
        // Revert to last player
      } else if (_darts == 3) {
        _activePlayerId = activePlayers.length - 1;
        _darts = 1;
      } else {
        _darts++;
      }
    } else {
      // Revert to previous player
      if (_darts == 3) {
        _activePlayerId--;
        _darts = 1;
      } else {
        // Revert throw for current player
        _darts++;
      }
    }
    scoreProviderNotifier.revertThrow(activePlayers[_activePlayerId]);
  }

  Future<bool> _showCancelDialog() async {
    final shouldClose = await showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.spaceAround,
          title: Text(
            'Opravdu chceš hru ukončit?',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          content: Text(
            'Všechny hody budou ztraceny.',
            textAlign: TextAlign.center,
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop(false);
              },
              child: const Text('Ne'),
            ),
            CustomElevatedBtn(
              onPressed: () {
                Navigator.of(ctx).pop(true);
              },
              title: 'Ano',
            ),
          ],
        );
      },
    );

    return shouldClose ?? false;
  }

  @override
  Widget build(BuildContext context) {
    scores = ref.watch(scoreProvider);

    String playerText = 'hráči';
    if (activePlayers.length == 1) {
      playerText = 'hráč';
    } else if (activePlayers.length > 4) {
      playerText = 'hráčů';
    }

    final screenTitle =
        'Mód $gameMode - ${activePlayers.length.toString()} $playerText';

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
      body: WillPopScope(
        onWillPop: () async {
          final shouldPop = await _showCancelDialog();
          return shouldPop;
        },
        child: Column(
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
      ),
    );
  }
}
