import 'package:flutter/material.dart';

import 'package:sipkys/components/game-modes/game_mode_list.dart';
import 'package:sipkys/components/ui/custom_elevated_btn.dart';
import 'package:sipkys/components/players/menu/add_player_modal.dart';
import 'package:sipkys/components/players/menu/player_list.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  void _showAddPlayerModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) {
        return const AddPlayerModal();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Herní mód',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            const GameModeList(),
            const SizedBox(height: 24),
            const PlayerList(),
            const SizedBox(
              height: 24,
            ),
            CustomElevatedBtn(
                title: 'Přidat hráče',
                onPressed: () {
                  _showAddPlayerModal(context);
                }),
          ],
        ),
      ),
    );
  }
}
