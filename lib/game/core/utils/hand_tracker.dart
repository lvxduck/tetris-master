import 'package:flython/flython.dart';

class HandTracker extends Flython {
  static HandTracker? _instance;

  static Future<bool> start() async {
    _instance ??= HandTracker();
    return await _instance!.initialize('python', 'main.py', false);
  }

  static Future<void> stop() async {
    if (_instance != null) {
      _instance?.finalize();
      _instance = null;
    }
  }
}
