import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sipkys/data/dummy_players.dart';
import 'package:sipkys/models/player.dart';

class PlayersNotifier extends StateNotifier<List<Player>> {
  PlayersNotifier() : super(dummyPlayers);

  void addPlayer(String name, String iconUrl) {
    final player =
        Player(id: state.length, name: name, imageUrl: iconUrl, isActive: true);
    state = [...state, player];
  }

  void removePlayer(int playerId) {
    state = state.where((player) => player.id != playerId).toList();
  }

  void setPlayerActiveStatus(int playerId, bool newActiveStatus) {
    state = state.map((player) {
      if (player.id == playerId) {
        return player.copyWith(isActive: newActiveStatus);
      }
      return player;
    }).toList();
  }
}

final playersProvider = StateNotifierProvider<PlayersNotifier, List<Player>>(
  (ref) => PlayersNotifier(),
);

final activePlayersProvider = Provider((ref) {
  return ref.watch(playersProvider).where((player) => player.isActive).toList();
});
