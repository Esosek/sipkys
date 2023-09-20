import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Modifier { double, triple }

Map<Modifier, bool> _defaultState = {
  Modifier.double: false,
  Modifier.triple: false,
};

class ModifierNotifier extends StateNotifier<Map<Modifier, bool>> {
  ModifierNotifier() : super(_defaultState);

  void toggleModifier(Modifier modifierKey, [bool? value]) {
    bool newValue = value ?? !state[modifierKey]!;
    state = {...state, modifierKey: newValue};
  }
}

final modifierProvider =
    StateNotifierProvider<ModifierNotifier, Map<Modifier, bool>>(
        (ref) => ModifierNotifier());
