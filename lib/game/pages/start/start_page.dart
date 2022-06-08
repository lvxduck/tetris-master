import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tetris_master/game/core/theme/game_color.dart';
import 'package:tetris_master/game/game_core/controller/audio_controller.dart';
import 'package:tetris_master/game/game_core/widgets/hand_tracker_widget.dart';
import 'package:tetris_master/game/pages/start/start_controller.dart';

import 'pages/forty_lines/forty_lines_details/forty_lines_details_page.dart';
import 'widgets/tetris_mode_button.dart';

class StartPage extends ConsumerWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final audioController = ref.watch(audioProvider.notifier);
    final controller = ref.watch(startProvider.notifier);
    final currentButtonIndex = ref.watch(startProvider).currentButtonIndex;
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 64, left: 64),
        child: Row(
          children: [
            ref.watch(audioProvider)
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(right: 32),
                    child: CircularProgressIndicator(
                      color: GameColor.brown[200],
                    ),
                  ),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'TETRIS MASTER',
                  textStyle: TextStyle(
                    fontSize: 46,
                    fontWeight: FontWeight.bold,
                    color: GameColor.brown[200],
                  ),
                  speed: const Duration(milliseconds: 100),
                ),
              ],
              totalRepeatCount: 1000,
              pause: const Duration(milliseconds: 100),
            ),
          ],
        ),
      ),
      body: RawKeyboardListener(
        focusNode: controller.focusNode,
        autofocus: true,
        onKey: (event) {
          if (event is RawKeyDownEvent) {
            if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
              audioController.playClick();
              controller.updateButtonIndex();
            }
            if (event.isKeyPressed(LogicalKeyboardKey.space)) {
              if (controller.currentButtonIndex == 0) {
                audioController.playClick();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const FortyLinesDetailPage(),
                  ),
                );
              } else {
                audioController.playClick();
              }
            }
          }
        },
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.14,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      if (currentButtonIndex == 0)
                        const Icon(Icons.chevron_right_outlined),
                      Expanded(
                        child: TetrisModeButton(
                          color: GameColor.brown,
                          type: '5L',
                          title: '5 LINES',
                          description:
                              'COMPLETE 10 LINES AS QUICKLY AS POSSIBLE',
                          onTap: () {
                            audioController.playClick();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const FortyLinesDetailPage(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      if (currentButtonIndex == 1)
                        const Icon(Icons.chevron_right_outlined),
                      Expanded(
                        child: TetrisModeButton(
                          color: GameColor.orange,
                          type: 'BLZ',
                          title: 'BLITZ',
                          description: 'A TWO-MINUTE RACE AGAINST THE CLOCK',
                          onTap: () async {
                            audioController.playClick();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      if (currentButtonIndex == 2)
                        const Icon(Icons.chevron_right_outlined),
                      Expanded(
                        child: TetrisModeButton(
                          color: GameColor.purple,
                          type: 'ZEN',
                          title: 'ZEN',
                          description:
                              'RELAX OR TRAIN IN THIS NEVERENDING MODE',
                          onTap: () {
                            audioController.playClick();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const HandTrackerWidget(),
          ],
        ),
      ),
    );
  }
}
