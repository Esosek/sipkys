import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

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
  final _scrollController = ItemScrollController();

  @override
  void initState() {
    super.initState();
    activePlayers = ref.read(activePlayersProvider);
  }

  void scrollToActiveIndex() {
    if (!_scrollController.isAttached || activePlayers.length < 5) {
      return;
    }
    double scrollOffset =
        widget.activePlayerIndex / (activePlayers.length + 0.8);
    _scrollController.scrollTo(
      index: widget.activePlayerIndex,
      alignment: scrollOffset,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    scrollToActiveIndex();
    return Expanded(
      child: ScrollablePositionedList.builder(
        itemScrollController: _scrollController,
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
