import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sipkys/components/ui/custom_elevated_btn.dart';
import 'package:sipkys/models/player.dart';
import 'package:sipkys/providers/players_provider.dart';

class PlayerRecord extends ConsumerWidget {
  const PlayerRecord(this.player, {super.key});

  final Player player;

  void _showDeleteDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.spaceAround,
          content: Text(
            'Opravdu chceš smazat hráče ${player.name}?',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Ne'),
            ),
            CustomElevatedBtn(
              onPressed: () {
                ref.read(playersProvider.notifier).removePlayer(player.id);
                Navigator.pop(ctx);
              },
              title: 'Ano',
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            onPressed: () => _showDeleteDialog(context, ref),
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
