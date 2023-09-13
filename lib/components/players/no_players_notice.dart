import 'package:flutter/material.dart';

import 'package:sipkys/components/players/menu/create_player_modal.dart';
import 'package:sipkys/components/ui/custom_elevated_btn.dart';

class NoPlayersNotice extends StatelessWidget {
  const NoPlayersNotice({
    super.key,
    this.popContext = false,
  });

  final bool popContext;

  @override
  Widget build(BuildContext context) {
    void showCreatePlayerModal(BuildContext context) {
      if (popContext) {
        Navigator.pop(context);
      }
      showModalBottomSheet(
          context: context,
          useSafeArea: true,
          isScrollControlled: true,
          builder: (context) {
            return const CreatePlayerModal();
          });
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Žádní dostupní hráči...',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(
            height: 24,
          ),
          CustomElevatedBtn(
            title: 'Vytvořit nového hráče',
            onPressed: () => showCreatePlayerModal(context),
          ),
        ],
      ),
    );
  }
}
