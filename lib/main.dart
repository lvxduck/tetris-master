import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tetris_master/game/core/theme/game_theme.dart';
import 'package:tetris_master/game/pages/start/start_page.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox<String>('HIVE');
  runApp(const ProviderScope(child: MyApp()));
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
      home: const StartPage(),
    );
  }
}
