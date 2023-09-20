import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sipkys/components/players/endscreen/endscreen_player_list.dart';
import 'package:sipkys/components/ui/custom_elevated_btn.dart';

import 'package:sipkys/components/ui/custom_fab.dart';
import 'package:sipkys/providers/score_provider.dart';
import 'package:sipkys/screens/game_screen.dart';
import 'package:sipkys/screens/tabs_screen.dart';

class EndScreen extends ConsumerWidget {
  const EndScreen({
    super.key,
    required this.winnerName,
  });

  final String winnerName;

  void _resetGame(BuildContext context, WidgetRef ref) {
    ref.read(scoreProvider.notifier).setScoreboard();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const GameScreen()),
    );
  }

  void _switchScreen(BuildContext context, int index) {
    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => TabsScreen(screenIndex: index),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(
          '$winnerName vyhrál!',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
          indicatorShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onDestinationSelected: (index) => _switchScreen(context, index),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.ads_click), label: 'Hrát!'),
            NavigationDestination(
                icon: Icon(Icons.person_add_alt_1), label: 'Hráči'),
          ]),
      floatingActionButton: CustomFAB(
        icon: Icons.refresh,
        onPressed: () => _resetGame(context, ref),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(
        children: [
          const EndScreenPlayerList(),
          const SizedBox(height: 16),
          CustomElevatedBtn(
              title: 'Menu', onPressed: () => Navigator.pop(context)),
          const SizedBox(height: 16),
          CustomElevatedBtn(title: 'Vrátit hod', onPressed: () {}),
          const SizedBox(height: 64)
        ],
      ),
    );
  }
}
