import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sipkys/components/players/endscreen/endscreen_player_item.dart';
import 'package:sipkys/models/player.dart';
import 'package:sipkys/models/player_score.dart';
import 'package:sipkys/providers/score_provider.dart';

class EndScreenPlayerList extends ConsumerWidget {
  const EndScreenPlayerList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playersScore = ref.watch(scoreProvider);

    final List<MapEntry<Player, PlayerScore>> sortedPlayersList = playersScore
        .entries
        .toList()
      ..sort((p1, p2) => p1.value.totalScore.compareTo(p2.value.totalScore));

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              color: Theme.of(context)
                  .colorScheme
                  .secondaryContainer
                  .withOpacity(.6),
              width: double.infinity,
              child: Text(
                'Pořadí',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: playersScore.length,
                itemBuilder: (context, index) {
                  return EndScreenPlayerItem(
                      player: sortedPlayersList[index].key,
                      standing: index + 1);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
