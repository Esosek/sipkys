import 'package:flutter/material.dart';
import 'package:sipkys/components/game-modes/game_mode_item.dart';

class GameModeList extends StatefulWidget {
  const GameModeList({super.key});

  @override
  State<GameModeList> createState() => _GameModeListState();
}

class _GameModeListState extends State<GameModeList> {
  String activeMode = '301';

  void setMode(String mode) {
    setState(() {
      activeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> gameModes = ['301', '501'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < gameModes.length; i++)
          GameModeItem(
            title: gameModes[i],
            isActive: activeMode == gameModes[i],
            onPressed: setMode,
          ),
      ],
    );
  }
}
