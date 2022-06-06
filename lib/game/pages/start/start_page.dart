import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tetris_master/game/core/theme/game_color.dart';

import 'pages/forty_lines/forty_lines_details/forty_lines_details_page.dart';
import 'widgets/tetris_mode_button.dart';

class StartPage extends ConsumerWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.14,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TetrisModeButton(
              color: GameColor.brown,
              type: '5L',
              title: '5 LINES',
              description: 'COMPLETE 10 LINES AS QUICKLY AS POSSIBLE',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const FortyLinesDetailPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            TetrisModeButton(
              color: GameColor.orange,
              type: 'BLZ',
              title: 'BLITZ',
              description: 'A TWO-MINUTE RACE AGAINST THE CLOCK',
              onTap: () {
                // final fortyLinesProvider = ref.watch(fortyLineApiProvider);
                // print(fortyLinesProvider.get().toJson());
                // showDialog(
                //   context: context,
                //   builder: (_) => EndGamePage(),
                // );
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (_) => const EndGamePage(),
                //   ),
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}
