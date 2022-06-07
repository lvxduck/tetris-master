import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:tetris_master/game/data/models/forty_lines_mode.dart';

final fortyLineApisProvider = Provider<FortyLinesModeApis>(
  (ref) => FortyLinesModeApis(),
);

class FortyLinesModeApis {
  final Box<String> box = Hive.box('HIVE');
  final String key = 'forty_lines';

  FortyLinesMode get() {
    final raw = box.get(key);
    if (raw == null) return FortyLinesMode.empty();
    return FortyLinesMode.fromJson(jsonDecode(raw));
  }

  Future save(FortyLinesMode data) {
    return box.put(key, jsonEncode(data.toJson()));
  }

  Future clear() {
    return box.clear();
  }
}
