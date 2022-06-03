import 'package:flutter/material.dart';
import 'package:tetris_master/game/core/theme/game_theme.dart';
import 'package:tetris_master/game/pages/game/game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: GameTheme.themeData,
      // theme: ThemeData.dark().copyWith(),
      home: const Game(),
    );
  }
}
