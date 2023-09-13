import 'package:flutter/material.dart';
import 'package:sipkys/components/players/menu/player_list_item.dart';
import 'package:sipkys/data/dummy_players.dart';

import 'package:sipkys/models/player.dart';

class PlayerList extends StatefulWidget {
  const PlayerList({super.key});

  @override
  State<PlayerList> createState() => _PlayerListState();
}

class _PlayerListState extends State<PlayerList> {
  final List<Player> activePlayers = List<Player>.from(dummyPlayers);
  //final List<Player> activePlayers = [];

  void _removePlayer(Player player) {
    setState(() {
      activePlayers.remove(player);
    });
  }

  void _reorderPlayers(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final player = activePlayers.removeAt(oldIndex);
    setState(() {
      activePlayers.insert(newIndex, player);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 30),
      child: Text(
        'Žádní aktivní hráči...',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );

    if (activePlayers.isNotEmpty) {
      content = Expanded(
        child: Column(
          children: [
            Expanded(
              child: ReorderableListView(
                header: Center(
                  child: Text(
                    'Aktivní hráči',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                onReorder: _reorderPlayers,
                children: [
                  for (Player player in activePlayers)
                    PlayerListItem(
                      key: ValueKey(player.id),
                      player,
                      onPressed: _removePlayer,
                    ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    return content;
  }
}
