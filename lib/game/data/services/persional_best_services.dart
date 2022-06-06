import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:tetris_master/game/data/models/forty_lines_mode.dart';

class FortyLinesModeService {
  final Box<String> box = Hive.box('HIVE');
  final String key = 'forty_lines';

  FortyLinesMode get() {
    final raw = box.get(key);
    if (raw == null) return FortyLinesMode.empty();
    return FortyLinesMode.fromJson(jsonDecode(raw));
  }
}
