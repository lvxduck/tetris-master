import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tetris_master/game/core/theme/game_color.dart';
import 'package:tetris_master/game/core/widgets/tetris_button.dart';
import 'package:tetris_master/game/game_core/controller/audio_controller.dart';

final endGameDialogProvider = AutoDisposeChangeNotifierProvider(
  (ref) => EndGameDialogController(),
);

class EndGameDialogController extends ChangeNotifier {
  int currentButtonIndex = 0;
  final FocusNode focusNode = FocusNode();

  void handleKeyEvent(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.isKeyPressed(LogicalKeyboardKey.space)) {
        currentButtonIndex += 1;
        if (currentButtonIndex > 1) {
          currentButtonIndex = 0;
        }
      }
      if (event.isKeyPressed(LogicalKeyboardKey.enter)) {}
      notifyListeners();
    }
  }

  void updateButtonIndex() {
    currentButtonIndex += 1;
    if (currentButtonIndex > 1) {
      currentButtonIndex = 0;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }
}

class EndGameDialog extends ConsumerWidget {
  const EndGameDialog({
    Key? key,
    required this.onRestart,
    required this.child,
  }) : super(key: key);
  final VoidCallback onRestart;
  final Widget child;

  @override
  Widget build(BuildContext context, ref) {
    final audioController = ref.watch(audioProvider.notifier);
    final controller = ref.watch(endGameDialogProvider.notifier);
    final currentButtonIndex =
        ref.watch(endGameDialogProvider).currentButtonIndex;
    return RawKeyboardListener(
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
              onRestart();
            } else {
              audioController.playClick();
              Navigator.of(context).popUntil((route) => route.isFirst);
            }
          }
        }
      },
      child: Material(
        color: Colors.transparent,
        child: Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: 320,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                child,
                const SizedBox(height: 12),
                Row(
                  children: [
                    if (currentButtonIndex == 0)
                      const Icon(Icons.chevron_right_outlined),
                    Expanded(
                      child: TetrisButton(
                        color: GameColor.orange,
                        onTap: () {
                          audioController.playClick();
                          onRestart();
                        },
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text('RETRY'),
                          ),
                        ),
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
                      child: TetrisButton(
                        color: GameColor.brown,
                        onTap: () {
                          audioController.playClick();
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                        },
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text('BACK TO HOME'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
