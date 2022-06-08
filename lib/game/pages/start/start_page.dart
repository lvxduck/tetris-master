import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tetris_master/game/core/theme/game_color.dart';
import 'package:tetris_master/game/game_core/controller/audio_controller.dart';

import 'pages/forty_lines/forty_lines_details/forty_lines_details_page.dart';
import 'widgets/tetris_mode_button.dart';

class StartPage extends ConsumerWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
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
            Spacer(),
            Spacer(),
          ],
        ),
      ),
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(left: 32, top: 32),
      //   child: Text(
      //     'TETRIS MASTER',
      //     style: TextStyle(
      //       fontSize: 42,
      //       fontWeight: FontWeight.bold,
      //       color: GameColor.brown[200],
      //     ),
      //   ),
      // ),
      body: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.14,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TetrisModeButton(
              color: GameColor.brown,
              type: '5L',
              title: '5 LINES',
              description: 'COMPLETE 10 LINES AS QUICKLY AS POSSIBLE',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const FortyLinesDetailPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            TetrisModeButton(
              color: GameColor.orange,
              type: 'BLZ',
              title: 'BLITZ',
              description: 'A TWO-MINUTE RACE AGAINST THE CLOCK',
              onTap: () async {
                // FortyLinesModeApis().clear();
                final player = AudioPlayer();
                // print('call');
                // await player.setUrl("https://s3.amazonaws.com/404-file.mp3");
                await player.setAudioSource(
                  AudioSource.uri(
                    Uri.parse(
                      "https://res.cloudinary.com/leduck/video/upload/v1654689728/tetris_master/y2mate.com_-_Aerial_City_Chika_Menu_Music_udsl8h.mp3",
                    ),
                  ),
                );
                print('okee');
                await player.play();
                // await player.stop();
                // var duration = await player.setUrl('https://foo.com/bar.mp3');
              },
            ),
          ],
        ),
      ),
    );
  }
}
