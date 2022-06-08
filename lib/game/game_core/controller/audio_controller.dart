import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

final audioProvider = AutoDisposeStateNotifierProvider<AudioController, bool>(
  (ref) => AudioController(),
);

class AudioController extends StateNotifier<bool> {
  AudioController() : super(false) {
    _initAudio();
  }

  final backgroundPlayer = AudioPlayer();

  Future<void> _initAudio() async {
    print('start init audio');
    await backgroundPlayer.setLoopMode(LoopMode.all);
    await backgroundPlayer.setAudioSource(
      AudioSource.uri(
        Uri.parse(
          "https://res.cloudinary.com/leduck/video/upload/v1654689728/tetris_master/y2mate.com_-_Aerial_City_Chika_Menu_Music_udsl8h.mp3",
        ),
      ),
    );
    state = true;
    print('finished init audio');
  }

  void playRandomBackgroundMusic() async {
    await backgroundPlayer.play();
  }

  void stopBackgroundMusic() {
    backgroundPlayer.pause();
  }
}
