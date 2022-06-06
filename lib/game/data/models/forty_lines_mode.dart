import 'package:json_annotation/json_annotation.dart';

import 'game_mode.dart';

part 'forty_lines_mode.g.dart';

@JsonSerializable()
class FortyLinesMode extends GameMode {
  FortyLinesMode({
    required super.songMode,
    int? super.personalBest,
  });

  factory FortyLinesMode.empty() => FortyLinesMode(songMode: "");

  Map<String, dynamic> toJson() => _$FortyLinesModeToJson(this);

  factory FortyLinesMode.fromJson(Map<String, dynamic> json) =>
      _$FortyLinesModeFromJson(json);
}
