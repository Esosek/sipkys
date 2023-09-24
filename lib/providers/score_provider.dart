import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sipkys/models/player.dart';
import 'package:sipkys/models/player_score.dart';
import 'package:sipkys/providers/game_mode_provider.dart';
import 'package:sipkys/providers/modifier_provider.dart';
import 'package:sipkys/providers/players_provider.dart';

Map<Modifier, bool> modifiers = {
  Modifier.double: false,
  Modifier.triple: false,
};

class ScoreNotifier extends StateNotifier<Map<Player, PlayerScore>> {
  ScoreNotifier({required this.initialScore, required this.ref}) : super({});

  final int initialScore;
  final StateNotifierProviderRef ref;

  void setScoreboard() {
    state = {
      for (Player player in ref.read(activePlayersProvider))
        player: PlayerScore(totalScore: initialScore),
    };
  }

  bool submitThrow(Player player, int value) {
    // Double and Triple modifiers
    if (modifiers[Modifier.double]!) {
      value *= 2;
    } else if (modifiers[Modifier.triple]!) {
      value *= 3;
    }

    PlayerScore updatedPlayerScore = state[player]!;

    // Overthrow
    if (value > updatedPlayerScore.totalScore) {
      int newTotalScore = updatedPlayerScore.totalScore;
      List<int> updatedThrowScores = updatedPlayerScore.throwScores;

      for (var throwValue in updatedPlayerScore.curRoundScores) {
        newTotalScore += throwValue;
        updatedThrowScores.removeLast();
      }

      updatedPlayerScore = updatedPlayerScore.copyWith(
        totalScore: newTotalScore,
        curRoundScores: [],
        throwScores: updatedThrowScores,
      );

      state = {...state, player: updatedPlayerScore};
      return false; // submit failed
    } else {
      updatedPlayerScore = updatedPlayerScore.copyWith(
        totalScore: updatedPlayerScore.totalScore - value,
        curRoundScores: [...updatedPlayerScore.curRoundScores, value],
        throwScores: [...updatedPlayerScore.throwScores, value],
      );
    }

    state = {...state, player: updatedPlayerScore};
    return true; // submit succeeded
  }

  // if player had to be switched, returns true
  bool revertThrow(Player currentPlayer, {Player? previousPlayer}) {
    bool playerWasSwitched =
        state[currentPlayer]!.throwScores.length % 3 == 0 &&
            state[currentPlayer]!.totalScore != 0;
    Player player = playerWasSwitched ? previousPlayer! : currentPlayer;

    final bool hasScores = state[player]!.curRoundScores.isNotEmpty;

    // Probably overthrew or reverting to deep history
    // Deep history is edge case, not working atm
    if (!hasScores) {
      return playerWasSwitched;
    }

    final throwValue = state[player]!.throwScores.last;

    final playerScore = state[player]!.copyWith(
      totalScore: state[player]!.totalScore + throwValue,
      curRoundScores:
          !hasScores ? [] : [...state[player]!.curRoundScores..removeLast()],
      throwScores: hasScores
          ? [...state[player]!.throwScores..removeLast()]
          : [...state[player]!.throwScores],
    );
    state = {...state, player: playerScore};
    return playerWasSwitched;
  }

  void resetPlayerRoundScore(Player player) {
    final playerScore = state[player]!.copyWith(
      curRoundScores: [],
    );
    state = {...state, player: playerScore};
  }

  bool isTurnOver(Player player) {
    if (state[player]!.throwScores.length % 3 == 0) {
      return true;
    }
    return false;
  }
}

final scoreProvider =
    StateNotifierProvider<ScoreNotifier, Map<Player, PlayerScore>>((ref) {
  ref.listen(modifierProvider, (prevModifiers, newModifiers) {
    modifiers = newModifiers;
  });
  return ScoreNotifier(
    ref: ref,
    initialScore: int.parse(
      ref.watch(gameModeProvider),
    ),
  );
});
