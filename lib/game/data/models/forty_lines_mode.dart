import 'package:freezed_annotation/freezed_annotation.dart';

part 'forty_lines_mode.freezed.dart';
part 'forty_lines_mode.g.dart';

@freezed
class FortyLinesMode with _$FortyLinesMode {
  factory FortyLinesMode({
    required String songMode,
    required int? personalBest,
  }) = _FortyLinesMode;

  factory FortyLinesMode.empty() => FortyLinesMode(
        songMode: "",
        personalBest: null,
      );

  factory FortyLinesMode.fromJson(Map<String, Object?> json) =>
      _$FortyLinesModeFromJson(json);
}
