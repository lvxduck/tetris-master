import 'package:flutter/material.dart';
import 'package:tetris_master/game/core/theme/game_color.dart';
import 'package:tetris_master/game/pages/game/game.dart';

import 'widgets/tetris_mode_button.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.14,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TetrisModeButton(
              color: GameColor.brown,
              type: '40L',
              title: '40 LINES',
              description: 'COMPLETE 40 LINES AS QUICKLY AS POSSIBLE',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const Game()),
                );
              },
            ),
            const SizedBox(height: 12),
            TetrisModeButton(
              color: GameColor.orange,
              type: 'BLZ',
              title: 'BLITZ',
              description: 'A TWO-MINUTE RACE AGAINST THE CLOCK',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
