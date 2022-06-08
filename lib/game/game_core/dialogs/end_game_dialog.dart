import 'package:flutter/material.dart';
import 'package:tetris_master/game/core/theme/game_color.dart';
import 'package:tetris_master/game/core/utils/hand_tracker.dart';
import 'package:tetris_master/game/core/widgets/tetris_button.dart';

class EndGameDialog extends StatelessWidget {
  const EndGameDialog({
    Key? key,
    required this.onRestart,
    required this.child,
  }) : super(key: key);
  final VoidCallback onRestart;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
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
              TetrisButton(
                color: GameColor.orange,
                onTap: () {
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
              const SizedBox(height: 12),
              TetrisButton(
                color: GameColor.turquoise,
                onTap: () {
                  HandTracker.toggle();
                },
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'TOGGLE HAND TRACKER',
                      style: TextStyle(color: Colors.brown[600]),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TetrisButton(
                color: GameColor.brown,
                onTap: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text('BACK TO HOME'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
