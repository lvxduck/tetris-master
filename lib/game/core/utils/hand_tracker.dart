import 'package:flython/flython.dart';
import 'package:window_manager/window_manager.dart';

class HandTracker extends Flython {
  static bool isStarting = false;
  static HandTracker? _instance;

  static Future<void> start() async {
    _instance ??= HandTracker();
    isStarting = true;
    var isSuccess = await _instance!.initialize('python', 'main.py', false);
    if (isSuccess) {
      while (await windowManager.isFocused()) {
        await Future.delayed(const Duration(milliseconds: 300));
      }
      await windowManager.focus();
    }
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
