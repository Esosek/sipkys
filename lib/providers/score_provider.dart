import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sipkys/models/player.dart';
import 'package:sipkys/models/player_score.dart';
import 'package:sipkys/providers/game_mode_provider.dart';
import 'package:sipkys/providers/players_provider.dart';

class ScoreNotifier extends StateNotifier<Map<Player, PlayerScore>> {
  ScoreNotifier({required this.players, required this.initialScore})
      : super({}) {
    setScoreboard();
  }

  final List<Player> players;
  final int initialScore;

  void setScoreboard() {
    state = {
      for (Player player in players) player: PlayerScore(initialScore),
    };
  }

  void subtractScore(Player player, int value) {
    PlayerScore playerScore = state[player]!;
    playerScore.saveThrow(value);
  }
}

final scoreProvider =
    StateNotifierProvider<ScoreNotifier, Map<Player, PlayerScore>>((ref) {
  final activePlayers = ref.watch(activePlayersProvider);
  return ScoreNotifier(
    players: activePlayers,
    initialScore: int.parse(
      ref.watch(gameModeProvider),
    ),
  );
});
