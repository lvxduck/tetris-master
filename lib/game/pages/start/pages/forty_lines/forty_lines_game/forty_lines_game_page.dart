import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tetris_master/game/data/apis/ramdom_image_apis.dart';
import 'package:tetris_master/game/game_core/game_core.dart';
import 'package:tetris_master/game/pages/start/pages/forty_lines/forty_lines_game/forty_lines_game_controller.dart';
import 'package:tetris_master/game/pages/start/pages/forty_lines/forty_lines_game/forty_lines_game_state.dart';
import 'package:tetris_master/game/pages/start/widgets/group_button_controls.dart';

import '../../../../../game_core/dialogs/end_game_dialog.dart';
import 'widgets/game_result.dart';

class FortyLinesGamePage extends ConsumerWidget {
  const FortyLinesGamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    ref.listen<FortyLinesGameState>(
      fortyLineGameProvider,
      (previous, next) {
        next.whenOrNull(end: (status, time) {
          showDialog(
            context: context,
            builder: (_) => EndGameDialog(
              onRestart: () {
                Navigator.of(context).pop();
                ref.watch(fortyLineGameProvider.notifier).restartGame();
              },
              child: GameResult(
                status: status,
                time: time,
              ),
            ),
          );
        });
      },
    );
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: ref.watch(randomImageProvider),
              fit: BoxFit.cover,
            ),
          ),
          const Positioned.fill(
            child: ColoredBox(
              color: Colors.black54,
            ),
          ),
          Column(
            children: const [
              Expanded(
                child: GameCore(),
              ),
              GroupButtonControls(),
            ],
          ),
        ],
      ),
    );
  }
}
