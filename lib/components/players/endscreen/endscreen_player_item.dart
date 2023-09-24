import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sipkys/models/player.dart';
import 'package:sipkys/providers/score_provider.dart';

class EndScreenPlayerItem extends ConsumerWidget {
  const EndScreenPlayerItem({
    super.key,
    required this.player,
    required this.standing,
  });

  final Player player;
  final int standing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerScores = ref.watch(scoreProvider);

    Widget standingContent = SizedBox(
        width: 30,
        child: Text(
          standing.toString(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: standing == 1
                    ? Colors.black.withOpacity(.8)
                    : Theme.of(context).colorScheme.onSecondaryContainer,
              ),
        ));

    if (standing == 1) {
      standingContent = SizedBox(
        width: 30,
        child: CircleAvatar(
          backgroundColor: const Color.fromARGB(255, 203, 209, 78),
          radius: 15,
          child: standingContent,
        ),
      );
    }

    return Container(
      color: Theme.of(context).colorScheme.secondaryContainer,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: [
          standingContent,
          const SizedBox(width: 16),
          Image.asset(
            player.imageUrl,
            height: 40,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              player.name,
              softWrap: true,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            playerScores[player]!.totalScore.toString(),
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(width: 38),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    playerScores[player]!.roundAvg.toStringAsFixed(1),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text('Avg',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: Colors.white54)),
                ],
              ),
              const SizedBox(width: 12),
              Column(
                children: [
                  Text(
                    player.wins.toString(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text('Wins',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: Colors.white54)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
