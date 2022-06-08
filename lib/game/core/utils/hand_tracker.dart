import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flython/flython.dart';
import 'package:window_manager/window_manager.dart';

final handTrackerProvider = AutoDisposeChangeNotifierProvider(
  ((ref) => HandTracker()),
);

class HandTracker extends Flython with ChangeNotifier {
  bool isRunning = false;
  bool isStarting = false;
  HandTracker? _instance;

  Future<void> start() async {
    _instance ??= HandTracker();
    isStarting = true;
    notifyListeners();

    var isSuccess = await _instance!.initialize('python', 'main.py', false);
    if (isSuccess) {
      while (await windowManager.isFocused()) {
        await Future.delayed(const Duration(milliseconds: 300));
      }
      await windowManager.focus();
    }
    isRunning = true;
    isStarting = false;
    notifyListeners();
  }

  Future<void> stop() async {
    _instance?.finalize();
    _instance = null;
    isStarting = false;
    isRunning = false;
    notifyListeners();
  }

  Future<void> toggle() async {
    if (isRunning) {
      await stop();
    } else {
      await start();
    }
  }
}
