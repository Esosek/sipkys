import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sipkys/components/ingame/game_player_tile.dart';
import 'package:sipkys/models/player.dart';
import 'package:sipkys/providers/players_provider.dart';

class GamePlayerList extends ConsumerStatefulWidget {
  const GamePlayerList({super.key, required this.activePlayerIndex});

  final int activePlayerIndex;

  @override
  ConsumerState<GamePlayerList> createState() => _GamePlayerListState();
}

class _GamePlayerListState extends ConsumerState<GamePlayerList> {
  late List<Player> activePlayers;

  @override
  void initState() {
    super.initState();
    activePlayers = ref.read(activePlayersProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: activePlayers.length,
        itemBuilder: (context, index) {
          return GamePlayerTile(
            player: activePlayers[index],
            isActive: index == widget.activePlayerIndex,
          );
        },
      ),
    );
  }
}
