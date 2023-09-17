import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sipkys/models/player.dart';
import 'package:sipkys/providers/players_provider.dart';

class ScoreNotifier extends StateNotifier<Map<Player, int>> {
  ScoreNotifier({required this.players}) : super({});

  final List<Player> players;

  void setScoreboard(int initialScore) {
    state = {
      for (Player player in players) player: initialScore,
    };
  }

  void subtractScore(Player player, int value) {
    int currentScore = state[player]!;
    if (currentScore - value < 0) {
      // reset
      state = {...state};
    } else {
      state = {...state, player: currentScore - value};
    }
  }
}

final scoreProvider =
    StateNotifierProvider<ScoreNotifier, Map<Player, int>>((ref) {
  final activePlayers = ref.watch(activePlayersProvider);
  return ScoreNotifier(players: activePlayers);
});
