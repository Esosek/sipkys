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

class _PlayerListState extends ConsumerState<MenuPlayerList>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 600),
    vsync: this,
  );

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(1.5, 0.0),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOut,
  ));

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

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
                    SlideTransition(
                      key: ValueKey(player.id),
                      position: _offsetAnimation,
                      child: MenuPlayerListItem(
                        key: ValueKey(player.id),
                        player,
                        onPressed: deactivatePlayer,
                      ),
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
