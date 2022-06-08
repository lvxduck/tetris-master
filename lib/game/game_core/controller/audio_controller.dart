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
  final clickPlayer = AudioPlayer();
  final moveFastPlayer = AudioPlayer();

  Future<void> _initAudio() async {
    print('start init audio');
    await backgroundPlayer.setLoopMode(LoopMode.all);
    await backgroundPlayer.setVolume(0.5);
    await backgroundPlayer.setAudioSource(
      AudioSource.uri(
        Uri.parse(
          "https://res.cloudinary.com/leduck/video/upload/v1654689728/tetris_master/y2mate.com_-_Aerial_City_Chika_Menu_Music_udsl8h.mp3",
        ),
      ),
    );
    await clickPlayer.setAudioSource(
      AudioSource.uri(
        Uri.parse(
          "https://dm0qx8t0i9gc9.cloudfront.net/previews/audio/BsTwCwBHBjzwub4i4/switch-click-button_GJXJl2NO_NWM.mp3",
        ),
      ),
    );
    await moveFastPlayer.setAudioSource(
      AudioSource.uri(
        Uri.parse(
          "https://dm0qx8t0i9gc9.cloudfront.net/previews/audio/BsTwCwBHBjzwub4i4/audioblocks-flash-flash-whoosh-swoosh-3_rYefuQM8CwU_NWM.mp3",
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

  void playClick() {
    clickPlayer.play();
  }

  void playMoveFast() {
    moveFastPlayer.play();
  }
}
