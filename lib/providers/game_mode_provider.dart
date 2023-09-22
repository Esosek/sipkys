import 'package:flutter_riverpod/flutter_riverpod.dart';

final gameModes = ['5', '301', '501'];

class GameModeNotifier extends StateNotifier<String> {
  GameModeNotifier() : super(gameModes[0]);

  void setMode(String newMode) {
    if (!gameModes.contains(newMode)) {
      return;
    }
    state = newMode;
  }
}

final gameModeProvider = StateNotifierProvider<GameModeNotifier, String>(
  (ref) => GameModeNotifier(),
);
