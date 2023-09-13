import 'package:flutter_riverpod/flutter_riverpod.dart';

final gameModes = ['301', '501'];

class GameModeNotifier extends StateNotifier<String> {
  GameModeNotifier() : super('301');

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
