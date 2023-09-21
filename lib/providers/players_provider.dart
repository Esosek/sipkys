import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sipkys/models/player.dart';

const uuid = Uuid();

class PlayersNotifier extends StateNotifier<List<Player>> {
  PlayersNotifier() : super([]) {
    getPrefsData();
  }

  void addPlayer(String name, String iconUrl) {
    final player =
        Player(id: uuid.v4(), name: name, imageUrl: iconUrl, isActive: true);
    state = [...state, player];
    createPrefsPlayer(player);
  }

  void removePlayer(String playerId) {
    state = state.where((player) => player.id != playerId).toList();
    deletePrefsPlayer(playerId);
  }

  void setPlayerActiveStatus(String playerId, bool newActiveStatus) {
    state = state.map((player) {
      if (player.id == playerId) {
        return player.copyWith(isActive: newActiveStatus);
      }
      return player;
    }).toList();
    updatePrefsPlayer(playerId, isActive: newActiveStatus);
  }

  void updatePlayerWins(String playerId, int value) {
    state = state.map((player) {
      if (player.id == playerId) {
        updatePrefsPlayer(playerId, wins: player.wins + value);
        return player.copyWith(wins: player.wins + value);
      }
      return player;
    }).toList();
  }

  void getPrefsData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final playerIds = prefs.getKeys();

    final List<Player> playerList = [];

    for (String id in playerIds) {
      final [name, imageUrl, wins, isActive] = prefs.getStringList(id)!;
      playerList.add(Player(
        id: id,
        name: name,
        imageUrl: imageUrl,
        wins: int.parse(wins),
        isActive: bool.parse(isActive),
      ));
    }
    state = playerList;
  }

  void createPrefsPlayer(Player player) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(player.id, [
      player.name,
      player.imageUrl,
      player.wins.toString(),
      'true' // isActive
    ]);
  }

  void deletePrefsPlayer(String playerId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(playerId);
  }

  void updatePrefsPlayer(String playerId, {bool? isActive, int? wins}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final prefsPlayer = prefs.getStringList(playerId);

    if (prefsPlayer != null) {
      final updatedPlayer = [
        prefsPlayer[0],
        prefsPlayer[1],
        wins?.toString() ?? prefsPlayer[2],
        isActive?.toString() ?? prefsPlayer[3],
      ];

      prefs.setStringList(playerId, updatedPlayer);
    }
  }
}

final playersProvider = StateNotifierProvider<PlayersNotifier, List<Player>>(
  (ref) => PlayersNotifier(),
);

final activePlayersProvider = Provider((ref) {
  return ref.watch(playersProvider).where((player) => player.isActive).toList();
});
