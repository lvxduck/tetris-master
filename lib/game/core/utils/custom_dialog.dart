import 'package:flutter/material.dart';

Future<T?> showCustomDialog<T>({
  required BuildContext context,
  required Widget dialog,
}) {
  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    transitionBuilder: (context, animation1, animation2, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: const Offset(0, 0),
        ).animate(animation1),
        child: child,
      );
    },
    pageBuilder: (context, _, __) {
      return dialog;
    },
  );
}
