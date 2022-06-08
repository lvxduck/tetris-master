import 'package:flython/flython.dart';

class HandTracker extends Flython {
  static bool isStarting = false;
  static HandTracker? _instance;

  static Future<bool> start() async {
    _instance ??= HandTracker();
    isStarting = true;
    return await _instance!.initialize('python', 'main.py', false);
  }

  static Future<void> stop() async {
    if (_instance != null) {
      _instance?.finalize();
      _instance = null;
      isStarting = false;
    }
  }

  static Future<void> toggle() async {
    if (isStarting) {
      await stop();
    } else {
      await start();
    }
  }
}
