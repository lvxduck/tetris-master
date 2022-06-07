import 'package:freezed_annotation/freezed_annotation.dart';

part 'forty_lines_game_state.freezed.dart';

enum EndGameStatus {
  newRecord,
  failure,
  success,
}

@freezed
class FortyLinesGameState with _$FortyLinesGameState {
  factory FortyLinesGameState.initial() = _initial;

  factory FortyLinesGameState.running() = _running;

  factory FortyLinesGameState.end({
    required EndGameStatus status,
    required int time,
  }) = _end;
}
