import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sipkys/components/ingame/single_throw_score.dart';
import 'package:sipkys/components/players/menu/player_display.dart';

import 'package:sipkys/models/player.dart';
import 'package:sipkys/providers/score_provider.dart';

class GamePlayerTile extends ConsumerWidget {
  const GamePlayerTile(
      {super.key, required this.player, required this.isActive});

  final Player player;
  final bool isActive;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final score = ref.watch(scoreProvider)[player]!;
    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Container(
        padding: const EdgeInsets.only(right: 10),
        height: 85,
        child: Row(
          children: [
            isActive
                ? SizedBox(
                    width: 70,
                    child: Icon(
                      Icons.arrow_right_rounded,
                      color: Theme.of(context).colorScheme.primary,
                      size: 70,
                    ),
                  )
                : const SizedBox(
                    width: 70,
                  ),
            Expanded(
              child: PlayerDisplay(
                player,
                iconSize: 30,
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  score.totalScore.toString(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    SingleThrowScore(score.curRoundScores.isNotEmpty
                        ? score.curRoundScores[0].toString()
                        : ''),
                    SingleThrowScore(score.curRoundScores.length > 1
                        ? score.curRoundScores[1].toString()
                        : ''),
                    SingleThrowScore(score.curRoundScores.length > 2
                        ? score.curRoundScores[2].toString()
                        : ''),
                    const SizedBox(width: 5),
                    Text(
                      score.totalRoundScore.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(width: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Ø',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(fontSize: 18),
                ),
                Text(
                  //score.roundAvg.toString(),
                  '20.0',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
