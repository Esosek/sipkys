import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:sipkys/components/ingame/game_player_tile.dart';
import 'package:sipkys/providers/players_provider.dart';

class GamePlayerList extends ConsumerWidget {
  GamePlayerList({super.key, required this.activePlayerIndex});

  final int activePlayerIndex;

  final _scrollController = ItemScrollController();

  void scrollToActiveIndex(int length) {
    if (!_scrollController.isAttached || length < 5) {
      return;
    }
    double scrollOffset = activePlayerIndex / (length + 0.8);
    _scrollController.scrollTo(
      index: activePlayerIndex,
      alignment: scrollOffset,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activePlayers = ref.watch(activePlayersProvider);
    scrollToActiveIndex(activePlayers.length);
    return Expanded(
      child: ScrollablePositionedList.builder(
        itemScrollController: _scrollController,
        itemCount: activePlayers.length,
        itemBuilder: (context, index) {
          return GamePlayerTile(
            player: activePlayers[index],
            isActive: index == activePlayerIndex,
          );
        },
      ),
    );
  }
}
