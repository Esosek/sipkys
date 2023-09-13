import 'package:flutter/material.dart';

import 'package:sipkys/components/players/no_players_notice.dart';
import 'package:sipkys/components/ui/custom_fab.dart';
import 'package:sipkys/components/players/menu/player_display.dart';
import 'package:sipkys/data/dummy_players.dart';
import 'package:sipkys/models/player.dart';

class AddPlayerModal extends StatefulWidget {
  const AddPlayerModal({super.key});

  @override
  State<AddPlayerModal> createState() => _AddPlayerModalState();
}

class _AddPlayerModalState extends State<AddPlayerModal> {
  final List<Player> availablePlayers = List.of(dummyPlayers);

  void _addPlayer(Player player) {
    setState(() {
      availablePlayers.remove(player);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const NoPlayersNotice(popContext: true);

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
                player,
                onTap: _addPlayer,
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
