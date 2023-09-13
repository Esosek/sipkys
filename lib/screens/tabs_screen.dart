import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sipkys/components/players/menu/create_player_modal.dart';
import 'package:sipkys/components/ui/custom_alert.dart';
import 'package:sipkys/components/ui/custom_fab.dart';
import 'package:sipkys/screens/game_screen.dart';
import 'package:sipkys/screens/menu_screen.dart';
import 'package:sipkys/screens/players_screen.dart';
import 'package:sipkys/providers/players_provider.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int activeScreenIndex = 0;

  void _switchScreen(BuildContext context, int index) {
    setState(() {
      activeScreenIndex = index;
    });
  }

  void _showNoActivePlayersDialog() {
    showDialog(
        context: context,
        builder: (ctx) {
          return CustomAlert(ctx,
              title: 'Nedostatek hráčů',
              content: 'Abys mohl začít hru, přidej alespoň jednoho hráče.');
        });
  }

  @override
  Widget build(BuildContext context) {
    String screenTitle = 'Šipkys Počítadlo';
    Widget fab = CustomFAB(
      icon: Icons.play_arrow_rounded,
      onPressed: () {
        if (ref.read(activePlayersProvider).isEmpty) {
          _showNoActivePlayersDialog();
          return;
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const GameScreen(),
          ),
        );
      },
    );
    Widget activeScreen = const MenuScreen();

    if (activeScreenIndex == 1) {
      screenTitle = 'Hráči';
      fab = CustomFAB(
        icon: Icons.add,
        onPressed: () {
          showModalBottomSheet(
              context: context,
              useSafeArea: true,
              isScrollControlled: true,
              builder: (context) {
                return const CreatePlayerModal();
              });
        },
      );
      activeScreen = const PlayersScreen();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(
          screenTitle,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
          selectedIndex: activeScreenIndex,
          indicatorShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onDestinationSelected: (index) => _switchScreen(context, index),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.ads_click), label: 'Hrát!'),
            NavigationDestination(
                icon: Icon(Icons.person_add_alt_1), label: 'Hráči'),
          ]),
      floatingActionButton: fab,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: activeScreen,
    );
  }
}
