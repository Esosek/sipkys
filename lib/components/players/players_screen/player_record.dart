import 'package:flutter/material.dart';

import 'package:sipkys/models/player.dart';

class PlayerRecord extends StatelessWidget {
  const PlayerRecord(this.player, {super.key});

  final Player player;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            player.imageUrl,
            height: 40,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              player.name,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            player.wins.toString(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            width: 20,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.delete_forever_rounded,
              size: 40,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ],
      ),
    );
  }
}
