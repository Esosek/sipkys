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
    } else if (modifiers[Modifier.triple]! && value != 25) {
      value *= 3;
    }

    // Overthrow
    if (value > state[player]!.totalScore) {
      return false; // submitting failed
    }

    final playerScore = state[player]!.copyWith(
      totalScore: state[player]!.totalScore - value,
      curRoundScores: [...state[player]!.curRoundScores, value],
      throwScores: [...state[player]!.throwScores, value],
    );
    state = {...state, player: playerScore};
    return true;
  }

  void revertThrow(Player player) {
    final throwValue = state[player]!.throwScores.last;
    final playerScore = state[player]!.copyWith(
      totalScore: state[player]!.totalScore + throwValue,
      curRoundScores: state[player]!.curRoundScores.isEmpty
          ? []
          : [...state[player]!.curRoundScores..removeLast()],
      throwScores: [...state[player]!.throwScores..removeLast()],
    );
    state = {...state, player: playerScore};
  }

  void resetPlayerRoundScore(Player player) {
    final playerScore = state[player]!.copyWith(
      curRoundScores: [],
    );
    state = {...state, player: playerScore};
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
