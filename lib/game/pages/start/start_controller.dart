import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final startProvider = AutoDisposeChangeNotifierProvider<StartController>(
  (ref) => StartController(),
);

class StartController extends ChangeNotifier {
  int currentButtonIndex = 0;
  final FocusNode focusNode = FocusNode();

  void updateButtonIndex() {
    currentButtonIndex += 1;
    if (currentButtonIndex > 2) {
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
