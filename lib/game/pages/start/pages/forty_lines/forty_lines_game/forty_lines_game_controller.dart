import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tetris_master/game/game_core/controller/game_core_controller.dart';
import 'package:tetris_master/game/game_core/models/game_config.dart';

final fortyLineGameProvider =
    AutoDisposeChangeNotifierProvider<FortyLinesGameController>(
  (ref) => FortyLinesGameController(
    gameCoreController: ref.watch(gameCoreProvider.notifier),
  ),
);

class FortyLinesGameController extends ChangeNotifier {
  FortyLinesGameController({required this.gameCoreController}) {
    gameCoreController.init(
      config: GameConfig(
        speed: 10,
        accelerator: 0,
        gameSize: GameSize(10, 20),
      ),
    );
  }

  final Size gameSize = const Size(10, 20);

  final GameCoreController gameCoreController;
}
