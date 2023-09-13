import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sipkys/data/dummy_players.dart';

import 'package:sipkys/models/player.dart';

class PlayersNotifier extends StateNotifier<List<Player>> {
  PlayersNotifier() : super(dummyPlayers);

  void addPlayer(Player player) => state = [...dummyPlayers, player];

  void removePlayer(int playerId) {
    state = state.where((player) => player.id != playerId).toList();
  }

  void setPlayerStatus(int playerId, bool newStatus) {
    final player = state[playerId];
    player.isActive = newStatus;
    state = [...state, player];
  }
}

final playersProvider = StateNotifierProvider<PlayersNotifier, List<Player>>(
  (ref) => PlayersNotifier(),
);

final activePlayersProvider = Provider((ref) {
  return ref.watch(playersProvider).where((player) => player.isActive).toList();
});
