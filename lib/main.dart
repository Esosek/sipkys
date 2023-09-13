import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sipkys/screens/tabs_screen.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 83, 175, 26),
  ),
  textTheme: GoogleFonts.ubuntuTextTheme().copyWith(
    titleLarge: const TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    titleMedium: const TextStyle(color: Colors.white),
    labelLarge: const TextStyle(
        color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
    labelMedium: const TextStyle(
        color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
    bodyLarge: const TextStyle(color: Colors.white, fontSize: 20),
    bodyMedium: const TextStyle(
      color: Colors.white30,
      fontSize: 18,
    ),
  ),
);

void main() {
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const TabsScreen(),
    );
  }
}
