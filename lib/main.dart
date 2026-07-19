import 'package:flutter/material.dart';
import 'screens/game_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const NatureBlastApp());
}

class NatureBlastApp extends StatelessWidget {
  const NatureBlastApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nature Blast',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.buildTheme(),
      home: const GameScreen(),
    );
  }
}

class MyApp extends NatureBlastApp {
  const MyApp({super.key});
}
