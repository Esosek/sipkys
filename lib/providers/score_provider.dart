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
  ScoreNotifier({required this.players, required this.initialScore})
      : super({});

  final List<Player> players;
  final int initialScore;

  void setScoreboard() {
    state = {
      for (Player player in players)
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

  void resetPlayerRoundScore(Player player) {
    final playerScore = state[player]!.copyWith(
      curRoundScores: [],
    );
    state = {...state, player: playerScore};
  }
}

final scoreProvider =
    StateNotifierProvider<ScoreNotifier, Map<Player, PlayerScore>>((ref) {
  final activePlayers = ref.watch(activePlayersProvider);
  ref.listen(modifierProvider, (prevModifiers, newModifiers) {
    modifiers = newModifiers;
  });
  return ScoreNotifier(
    players: activePlayers,
    initialScore: int.parse(
      ref.watch(gameModeProvider),
    ),
  );
});
