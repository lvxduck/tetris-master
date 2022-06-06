import 'package:flutter/material.dart';
import 'package:tetris_master/game/data/apis/forty_lines_apis.dart';
import 'package:tetris_master/game/data/models/forty_lines_mode.dart';
import 'package:tetris_master/game/pages/end_game/end_game_page.dart';
import 'package:tetris_master/game/pages/game/widgets/board.dart';

import '../../group_button_controls.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> with SingleTickerProviderStateMixin {
  final boardKey = GlobalKey<BoardState>();
  final gameSize = const Size(10, 20);
  int time = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              'http://chiase24.com/wp-content/uploads/2022/02/Tong-hop-cac-hinh-anh-background-dep-nhat-21.jpg',
              fit: BoxFit.cover,
            ),
          ),
          const Positioned.fill(
            child: ColoredBox(
              color: Colors.black45,
            ),
          ),
          Column(
            children: [
              Expanded(
                child: Board(
                  key: boardKey,
                  gameSize: gameSize,
                  onNumberOfLineChange: (numberOfLine) {
                    print(numberOfLine);
                    if (numberOfLine >= 5) {
                      boardKey.currentState!.endGame();
                    }
                  },
                  onEndGame: () {
                    var status = EndGameStatus.failure;
                    if (boardKey.currentState!.numberOfLine >= 5) {
                      status = EndGameStatus.success;
                      final fortyLineData = FortyLinesModeApis().get();
                      final currentResult = boardKey
                          .currentState!.leftBoardKey.currentState!
                          .getTime();
                      if (fortyLineData.personalBest == null ||
                          fortyLineData.personalBest > currentResult) {
                        status = EndGameStatus.newRecord;
                        FortyLinesModeApis().save(
                          FortyLinesMode(
                            songMode: fortyLineData.songMode,
                            personalBest: currentResult,
                          ),
                        );
                      }
                    }

                    showDialog(
                      context: context,
                      builder: (_) => EndGamePage(
                        status: status,
                        time: boardKey.currentState!.leftBoardKey.currentState!
                            .getTime(),
                      ),
                    );
                  },
                ),
              ),
              const GroupButtonControls(),
            ],
          ),
        ],
      ),
    );
  }
}
