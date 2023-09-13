import 'package:flutter/material.dart';
import 'package:sipkys/components/players/no_players_notice.dart';
import 'package:sipkys/components/players/players_screen/player_record.dart';

import 'package:sipkys/data/dummy_players.dart';
import 'package:sipkys/models/player.dart';

class PlayersScreen extends StatelessWidget {
  const PlayersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final players = dummyPlayers;

    Widget content = const NoPlayersNotice();

    if (players.isNotEmpty) {
      content = Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Jméno',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      'Výhry',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Expanded(
                child: ListView(
                  children: [
                    for (Player player in players) PlayerRecord(player),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return content;
  }
}
