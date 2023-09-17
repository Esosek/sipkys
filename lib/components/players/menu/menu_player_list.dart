import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sipkys/components/players/menu/menu_player_list_item.dart';
import 'package:sipkys/models/player.dart';
import 'package:sipkys/providers/players_provider.dart';

class MenuPlayerList extends ConsumerStatefulWidget {
  const MenuPlayerList({super.key});

  @override
  ConsumerState<MenuPlayerList> createState() => _PlayerListState();
}

class _PlayerListState extends ConsumerState<MenuPlayerList> {
  @override
  Widget build(BuildContext context) {
    final activePlayers = ref.watch(activePlayersProvider);

    void deactivatePlayer(Player player) {
      ref
          .read(playersProvider.notifier)
          .setPlayerActiveStatus(player.id, false);
    }

    void reorderPlayers(int oldIndex, int newIndex) {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final player = activePlayers.removeAt(oldIndex);
      setState(() {
        activePlayers.insert(newIndex, player);
      });
    }

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
                onReorder: reorderPlayers,
                children: [
                  for (Player player in activePlayers)
                    MenuPlayerListItem(
                      key: ValueKey(player.id),
                      player,
                      onPressed: deactivatePlayer,
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
