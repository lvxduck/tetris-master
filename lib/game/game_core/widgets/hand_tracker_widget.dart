import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tetris_master/game/core/utils/hand_tracker.dart';

class HandTrackerWidget extends ConsumerWidget {
  const HandTrackerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final handTrackerController = ref.watch(handTrackerProvider.notifier);
    final isStarting = ref.watch(handTrackerProvider).isStarting;
    return Positioned(
      bottom: 20,
      left: 20,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (isStarting) const CircularProgressIndicator(),
          IconButton(
            icon: const Icon(Icons.camera),
            onPressed: handTrackerController.toggle,
          ),
        ],
      ),
    );
  }
}
