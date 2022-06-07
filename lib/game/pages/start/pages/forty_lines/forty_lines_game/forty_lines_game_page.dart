import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tetris_master/game/game_core/game_core.dart';
import 'package:tetris_master/game/pages/start/pages/forty_lines/end_game/end_game_page.dart';
import 'package:tetris_master/game/pages/start/pages/forty_lines/forty_lines_game/forty_lines_game_controller.dart';
import 'package:tetris_master/game/pages/start/widgets/group_button_controls.dart';

class Game extends ConsumerWidget {
  const Game({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final controller = ref.watch(fortyLineGameProvider.notifier);
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
                child: GameCore(
                  gameSize: controller.gameSize,
                  onNumberOfLineChange: (numberOfLine) {
                    print(numberOfLine);
                    if (numberOfLine >= 5) {
                      // boardKey.currentState!.endGame();
                    }
                  },
                  onEndGame: () {
                    var status = EndGameStatus.failure;
                    // if (boardKey.currentState!.numberOfLine >= 5) {
                    //   status = EndGameStatus.success;
                    //   final fortyLineData = FortyLinesModeApis().get();
                    //   final currentResult = boardKey
                    //       .currentState!.leftBoardKey.currentState!
                    //       .getTime();
                    //   if (fortyLineData.personalBest == null ||
                    //       fortyLineData.personalBest! > currentResult) {
                    //     status = EndGameStatus.newRecord;
                    //     FortyLinesModeApis().save(fortyLineData.copyWith(
                    //       personalBest: currentResult,
                    //     ));
                    //   }
                    // }
                    //
                    // showDialog(
                    //   context: context,
                    //   builder: (_) => EndGamePage(
                    //     status: status,
                    //     time: boardKey.currentState!.leftBoardKey.currentState!
                    //         .getTime(),
                    //   ),
                    // );
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
