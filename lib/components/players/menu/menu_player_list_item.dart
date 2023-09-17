import 'package:flutter/material.dart';

import 'package:sipkys/models/player.dart';

class MenuPlayerListItem extends StatelessWidget {
  const MenuPlayerListItem(this.player, {super.key, required this.onPressed});

  final Player player;
  final void Function(Player) onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: ValueKey(player.id),
      leading: Image.asset(
        player.imageUrl,
        height: 40,
      ),
      title: Text(
        player.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      trailing: IconButton(
        onPressed: () => onPressed(player),
        icon: const Icon(Icons.remove_circle_outline),
      ),
    );
  }
}
