import 'package:flutter/material.dart';

import 'package:sipkys/models/player.dart';

class PlayerDisplay extends StatelessWidget {
  const PlayerDisplay(this.player, {super.key, this.onTap});

  final Player player;
  final void Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap != null
          ? () {
              onTap!(player.id);
            }
          : null,
      child: Column(
        children: [
          Text(
            player.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: 8),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Image.asset(
                player.imageUrl,
                height: 60,
              ),
              Positioned(
                bottom: -15,
                left: 0,
                child: CircleAvatar(
                  foregroundColor: Colors.black,
                  radius: 15,
                  backgroundColor: const Color.fromARGB(255, 203, 209, 78),
                  child: Text(
                    player.wins.toString(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
