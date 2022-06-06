import 'package:flutter/material.dart';
import 'package:tetris_master/game/core/theme/game_color.dart';
import 'package:tetris_master/game/core/widgets/tetris_button.dart';
import 'package:tetris_master/game/pages/game/game.dart';

class EndGamePage extends StatefulWidget {
  const EndGamePage({Key? key, required this.time}) : super(key: key);
  final int time;

  @override
  _EndGamePageState createState() => _EndGamePageState();
}

class _EndGamePageState extends State<EndGamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Align(
        alignment: Alignment.centerRight,
        child: SizedBox(
          width: 320,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'TIME',
                      style: TextStyle(fontSize: 21),
                    ),
                    Text(
                      Duration(milliseconds: widget.time)
                          .toString()
                          .substring(0, 9),
                      style: const TextStyle(fontSize: 32),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              TetrisButton(
                color: GameColor.orange,
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => const Game(),
                    ),
                  );
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
