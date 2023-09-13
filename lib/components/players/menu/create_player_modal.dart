import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sipkys/components/ui/custom_fab.dart';
import 'package:sipkys/data/player_icons.dart';
import 'package:sipkys/providers/players_provider.dart';

class CreatePlayerModal extends ConsumerStatefulWidget {
  const CreatePlayerModal({super.key});

  @override
  ConsumerState<CreatePlayerModal> createState() => _CreatePlayerModalState();
}

class _CreatePlayerModalState extends ConsumerState<CreatePlayerModal> {
  final nameController = TextEditingController();
  int activeIcon = 0;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  void _selectIcon(int index) {
    setState(() {
      activeIcon = index;
    });
  }

  void _submitPlayer() {
    if (nameController.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(
            'Prázdné jméno',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          content: Text(
            'Prosím vyplň jméno hráče.',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.white60,
                ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }
    ref
        .read(playersProvider.notifier)
        .addPlayer(nameController.text.trim(), playerIconsUrl[activeIcon]);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      floatingActionButton: CustomFAB(
        icon: Icons.check,
        onPressed: _submitPlayer,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
        child: Column(
          children: [
            Text(
              'Jméno',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            TextField(
                controller: nameController,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
                autofocus: true,
                keyboardType: TextInputType.name,
                maxLength: 12),
            const SizedBox(height: 24),
            Text(
              'Ikona',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 40,
                  crossAxisSpacing: 40,
                  childAspectRatio: 1,
                ),
                children: [
                  for (int i = 0; i < playerIconsUrl.length; i++)
                    InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => _selectIcon(i),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: activeIcon == i
                            ? Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(.75)
                            : Colors.transparent,
                        child: Image.asset(playerIconsUrl[i], height: 45),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
