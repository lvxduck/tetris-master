import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tetris_master/game/core/theme/game_color.dart';
import 'package:tetris_master/game/core/utils/hand_tracker.dart';
import 'package:tetris_master/game/core/widgets/tetris_card.dart';
import 'package:tetris_master/game/data/apis/forty_lines_apis.dart';

import '../forty_lines_game/forty_lines_game_page.dart';

class FortyLinesDetailPage extends ConsumerWidget {
  const FortyLinesDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final fortyLineApis = ref.watch(fortyLineApisProvider);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: GameColor.brown[300],
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        automaticallyImplyLeading: false,
        backgroundColor: GameColor.brown[600],
        title: Text(
          '5 LINES',
          style: TextStyle(
            color: GameColor.brown[300],
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.14,
        ),
        children: [
          const SizedBox(height: 120),
          TetrisCard(
            color: GameColor.brown,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '5 LINES',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 26,
                    color: GameColor.brown[100],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'CLEAR 5 LINES IN THE SHORTEST AMOUNT OF TIME POSSIBLE. SCORE DOESN\'T MATTER HERE. JUST GO FOR THE WORLD RECORD',
                  style: TextStyle(
                    color: GameColor.brown[100],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'PERSIONAL BEST',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: GameColor.brown[100],
                    fontSize: 14,
                  ),
                ),
                Text(
                  fortyLineApis.get().personalBest == null
                      ? 'N/A'
                      : Duration(
                          milliseconds: fortyLineApis.get().personalBest!,
                        ).toString().substring(0, 9),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: GameColor.brown[100],
                    fontSize: 26,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const FortyLinesGamePage()),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: GameColor.brown[300],
                border: Border(
                  top: BorderSide(color: GameColor.brown[400]!, width: 2),
                  bottom: BorderSide(color: GameColor.brown[700]!, width: 2),
                  left: BorderSide(color: GameColor.brown[500]!, width: 2),
                ),
              ),
              child: const Text(
                'START',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () async {
              await HandTracker.start();

              // ignore: use_build_context_synchronously
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const FortyLinesGamePage()),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: GameColor.brown[300],
                border: Border(
                  top: BorderSide(color: GameColor.brown[400]!, width: 2),
                  bottom: BorderSide(color: GameColor.brown[700]!, width: 2),
                  left: BorderSide(color: GameColor.brown[500]!, width: 2),
                ),
              ),
              child: const Text(
                'START WITH HAND TRACKER',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
