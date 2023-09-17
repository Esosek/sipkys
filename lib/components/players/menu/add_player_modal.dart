import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sipkys/components/players/no_players_notice.dart';
import 'package:sipkys/components/ui/custom_fab.dart';
import 'package:sipkys/components/players/menu/player_display.dart';
import 'package:sipkys/models/player.dart';
import 'package:sipkys/providers/players_provider.dart';

class AddPlayerModal extends ConsumerStatefulWidget {
  const AddPlayerModal({super.key});

  @override
  ConsumerState<AddPlayerModal> createState() => _AddPlayerModalState();
}

class _AddPlayerModalState extends ConsumerState<AddPlayerModal> {
  @override
  Widget build(BuildContext context) {
    final List<Player> availablePlayers =
        ref.watch(playersProvider).where((player) => !player.isActive).toList();
    Widget content = const NoPlayersNotice(popContext: true);

    void activatePlayer(int playerId) {
      ref.read(playersProvider.notifier).setPlayerActiveStatus(playerId, true);
    }

    if (availablePlayers.isNotEmpty) {
      content = Expanded(
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 40,
            crossAxisSpacing: 40,
          ),
          children: [
            for (Player player in availablePlayers)
              PlayerDisplay(
                key: ValueKey(player.id),
                player,
                onTap: activatePlayer,
                showWins: true,
              ),
          ],
        ),
      );
    }
    return Scaffold(
      floatingActionButton: CustomFAB(
          icon: Icons.check,
          onPressed: () {
            Navigator.pop(context);
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.all(60),
        child: Column(
          children: [
            Text(
              'Přidat hráče',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            content,
          ],
        ),
      ),
    );
  }
}
