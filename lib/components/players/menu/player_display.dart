import 'package:flutter/material.dart';

import 'package:sipkys/models/player.dart';

class PlayerDisplay extends StatelessWidget {
  const PlayerDisplay(this.player,
      {super.key,
      this.onTap,
      this.showWins = false,
      this.iconSize = 60,
      this.crossAxisAlignment = CrossAxisAlignment.center});

  final Player player;
  final void Function(String)? onTap;
  final bool showWins;
  final double iconSize;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap != null
          ? () {
              onTap!(player.id);
            }
          : null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: crossAxisAlignment,
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
                height: iconSize,
              ),
              if (showWins)
                Positioned(
                  bottom: -15,
                  left: 0,
                  child: CircleAvatar(
                    foregroundColor: Colors.black,
                    radius: 17,
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
