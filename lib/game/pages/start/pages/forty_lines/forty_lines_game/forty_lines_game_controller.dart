import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tetris_master/game/data/apis/forty_lines_apis.dart';
import 'package:tetris_master/game/game_core/controller/base_game_controller.dart';
import 'package:tetris_master/game/game_core/controller/game_core_controller.dart';
import 'package:tetris_master/game/game_core/models/game_config.dart';
import 'package:tetris_master/game/pages/start/pages/forty_lines/forty_lines_game/forty_lines_game_state.dart';

final fortyLineGameProvider = AutoDisposeStateNotifierProvider<
    FortyLinesGameController, FortyLinesGameState>(
  (ref) => FortyLinesGameController(
    gameCoreController: ref.watch(gameCoreProvider.notifier),
    fortyLinesModeApis: ref.watch(fortyLineApisProvider),
  ),
);

class FortyLinesGameController extends StateNotifier<FortyLinesGameState> {
  FortyLinesGameController({
    required this.gameCoreController,
    required this.fortyLinesModeApis,
  }) : super(FortyLinesGameState.initial()) {
    gameCoreController.init(
      config: GameConfig(
        speed: 10,
        accelerator: 0,
        gameSize: GameSize(10, 20),
      ),
    );
    gameCoreController.addListener(() {
      if (gameCoreController.numberOfLine >= maxLine) {
        gameCoreController.endGame();
        endGame();
      } else if (gameCoreController.gameState == GameState.gameOver) {
        endGame();
      }
    });
    state = FortyLinesGameState.running();
  }

  final GameCoreController gameCoreController;
  final FortyLinesModeApis fortyLinesModeApis;

  final maxLine = 1;

  final Size gameSize = const Size(10, 20);

  void restartGame() {
    gameCoreController.init(
      config: GameConfig(
        speed: 10,
        accelerator: 0,
        gameSize: GameSize(10, 20),
      ),
    );
  }

  void endGame() {
    var status = EndGameStatus.failure;
    if (gameCoreController.numberOfLine >= maxLine) {
      status = EndGameStatus.success;
      final fortyLineData = fortyLinesModeApis.get();
      final currentResult = gameCoreController.timeController.getTime();
      if (fortyLineData.personalBest == null ||
          fortyLineData.personalBest! > currentResult) {
        status = EndGameStatus.newRecord;
        fortyLinesModeApis.save(fortyLineData.copyWith(
          personalBest: currentResult,
        ));
      }
    }
    state = FortyLinesGameState.end(
      status: status,
      time: gameCoreController.timeController.getTime(),
    );
  }
}
