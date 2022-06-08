// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'forty_lines_mode.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FortyLinesMode _$FortyLinesModeFromJson(Map<String, dynamic> json) {
  return _FortyLinesMode.fromJson(json);
}

/// @nodoc
mixin _$FortyLinesMode {
  String get songMode => throw _privateConstructorUsedError;
  int? get personalBest => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FortyLinesModeCopyWith<FortyLinesMode> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FortyLinesModeCopyWith<$Res> {
  factory $FortyLinesModeCopyWith(
          FortyLinesMode value, $Res Function(FortyLinesMode) then) =
      _$FortyLinesModeCopyWithImpl<$Res>;
  $Res call({String songMode, int? personalBest});
}

/// @nodoc
class _$FortyLinesModeCopyWithImpl<$Res>
    implements $FortyLinesModeCopyWith<$Res> {
  _$FortyLinesModeCopyWithImpl(this._value, this._then);

  final FortyLinesMode _value;
  // ignore: unused_field
  final $Res Function(FortyLinesMode) _then;

  @override
  $Res call({
    Object? songMode = freezed,
    Object? personalBest = freezed,
  }) {
    return _then(_value.copyWith(
      songMode: songMode == freezed
          ? _value.songMode
          : songMode // ignore: cast_nullable_to_non_nullable
              as String,
      personalBest: personalBest == freezed
          ? _value.personalBest
          : personalBest // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$$_FortyLinesModeCopyWith<$Res>
    implements $FortyLinesModeCopyWith<$Res> {
  factory _$$_FortyLinesModeCopyWith(
          _$_FortyLinesMode value, $Res Function(_$_FortyLinesMode) then) =
      __$$_FortyLinesModeCopyWithImpl<$Res>;
  @override
  $Res call({String songMode, int? personalBest});
}

/// @nodoc
class __$$_FortyLinesModeCopyWithImpl<$Res>
    extends _$FortyLinesModeCopyWithImpl<$Res>
    implements _$$_FortyLinesModeCopyWith<$Res> {
  __$$_FortyLinesModeCopyWithImpl(
      _$_FortyLinesMode _value, $Res Function(_$_FortyLinesMode) _then)
      : super(_value, (v) => _then(v as _$_FortyLinesMode));

  @override
  _$_FortyLinesMode get _value => super._value as _$_FortyLinesMode;

  @override
  $Res call({
    Object? songMode = freezed,
    Object? personalBest = freezed,
  }) {
    return _then(_$_FortyLinesMode(
      songMode: songMode == freezed
          ? _value.songMode
          : songMode // ignore: cast_nullable_to_non_nullable
              as String,
      personalBest: personalBest == freezed
          ? _value.personalBest
          : personalBest // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FortyLinesMode implements _FortyLinesMode {
  _$_FortyLinesMode({required this.songMode, required this.personalBest});

  factory _$_FortyLinesMode.fromJson(Map<String, dynamic> json) =>
      _$$_FortyLinesModeFromJson(json);

  @override
  final String songMode;
  @override
  final int? personalBest;

  @override
  String toString() {
    return 'FortyLinesMode(songMode: $songMode, personalBest: $personalBest)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FortyLinesMode &&
            const DeepCollectionEquality().equals(other.songMode, songMode) &&
            const DeepCollectionEquality()
                .equals(other.personalBest, personalBest));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(songMode),
      const DeepCollectionEquality().hash(personalBest));

  @JsonKey(ignore: true)
  @override
  _$$_FortyLinesModeCopyWith<_$_FortyLinesMode> get copyWith =>
      __$$_FortyLinesModeCopyWithImpl<_$_FortyLinesMode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FortyLinesModeToJson(this);
  }
}

abstract class _FortyLinesMode implements FortyLinesMode {
  factory _FortyLinesMode(
      {required final String songMode,
      required final int? personalBest}) = _$_FortyLinesMode;

  factory _FortyLinesMode.fromJson(Map<String, dynamic> json) =
      _$_FortyLinesMode.fromJson;

  @override
  String get songMode => throw _privateConstructorUsedError;
  @override
  int? get personalBest => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_FortyLinesModeCopyWith<_$_FortyLinesMode> get copyWith =>
      throw _privateConstructorUsedError;
}
