// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'otp_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OtpState {
  bool get isVerifying => throw _privateConstructorUsedError;
  bool get isResending => throw _privateConstructorUsedError;
  bool get isSuccess => throw _privateConstructorUsedError;
  int get resendCooldown =>
      throw _privateConstructorUsedError; // seconds remaining
  UserEntity? get user => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OtpStateCopyWith<OtpState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtpStateCopyWith<$Res> {
  factory $OtpStateCopyWith(OtpState value, $Res Function(OtpState) then) =
      _$OtpStateCopyWithImpl<$Res, OtpState>;
  @useResult
  $Res call(
      {bool isVerifying,
      bool isResending,
      bool isSuccess,
      int resendCooldown,
      UserEntity? user,
      String? errorMessage});
}

/// @nodoc
class _$OtpStateCopyWithImpl<$Res, $Val extends OtpState>
    implements $OtpStateCopyWith<$Res> {
  _$OtpStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isVerifying = null,
    Object? isResending = null,
    Object? isSuccess = null,
    Object? resendCooldown = null,
    Object? user = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      isVerifying: null == isVerifying
          ? _value.isVerifying
          : isVerifying // ignore: cast_nullable_to_non_nullable
              as bool,
      isResending: null == isResending
          ? _value.isResending
          : isResending // ignore: cast_nullable_to_non_nullable
              as bool,
      isSuccess: null == isSuccess
          ? _value.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      resendCooldown: null == resendCooldown
          ? _value.resendCooldown
          : resendCooldown // ignore: cast_nullable_to_non_nullable
              as int,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserEntity?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OtpStateImplCopyWith<$Res>
    implements $OtpStateCopyWith<$Res> {
  factory _$$OtpStateImplCopyWith(
          _$OtpStateImpl value, $Res Function(_$OtpStateImpl) then) =
      __$$OtpStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isVerifying,
      bool isResending,
      bool isSuccess,
      int resendCooldown,
      UserEntity? user,
      String? errorMessage});
}

/// @nodoc
class __$$OtpStateImplCopyWithImpl<$Res>
    extends _$OtpStateCopyWithImpl<$Res, _$OtpStateImpl>
    implements _$$OtpStateImplCopyWith<$Res> {
  __$$OtpStateImplCopyWithImpl(
      _$OtpStateImpl _value, $Res Function(_$OtpStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isVerifying = null,
    Object? isResending = null,
    Object? isSuccess = null,
    Object? resendCooldown = null,
    Object? user = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_$OtpStateImpl(
      isVerifying: null == isVerifying
          ? _value.isVerifying
          : isVerifying // ignore: cast_nullable_to_non_nullable
              as bool,
      isResending: null == isResending
          ? _value.isResending
          : isResending // ignore: cast_nullable_to_non_nullable
              as bool,
      isSuccess: null == isSuccess
          ? _value.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      resendCooldown: null == resendCooldown
          ? _value.resendCooldown
          : resendCooldown // ignore: cast_nullable_to_non_nullable
              as int,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserEntity?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$OtpStateImpl implements _OtpState {
  const _$OtpStateImpl(
      {this.isVerifying = false,
      this.isResending = false,
      this.isSuccess = false,
      this.resendCooldown = 0,
      this.user,
      this.errorMessage});

  @override
  @JsonKey()
  final bool isVerifying;
  @override
  @JsonKey()
  final bool isResending;
  @override
  @JsonKey()
  final bool isSuccess;
  @override
  @JsonKey()
  final int resendCooldown;
// seconds remaining
  @override
  final UserEntity? user;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'OtpState(isVerifying: $isVerifying, isResending: $isResending, isSuccess: $isSuccess, resendCooldown: $resendCooldown, user: $user, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtpStateImpl &&
            (identical(other.isVerifying, isVerifying) ||
                other.isVerifying == isVerifying) &&
            (identical(other.isResending, isResending) ||
                other.isResending == isResending) &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess) &&
            (identical(other.resendCooldown, resendCooldown) ||
                other.resendCooldown == resendCooldown) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isVerifying, isResending,
      isSuccess, resendCooldown, user, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OtpStateImplCopyWith<_$OtpStateImpl> get copyWith =>
      __$$OtpStateImplCopyWithImpl<_$OtpStateImpl>(this, _$identity);
}

abstract class _OtpState implements OtpState {
  const factory _OtpState(
      {final bool isVerifying,
      final bool isResending,
      final bool isSuccess,
      final int resendCooldown,
      final UserEntity? user,
      final String? errorMessage}) = _$OtpStateImpl;

  @override
  bool get isVerifying;
  @override
  bool get isResending;
  @override
  bool get isSuccess;
  @override
  int get resendCooldown;
  @override // seconds remaining
  UserEntity? get user;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$OtpStateImplCopyWith<_$OtpStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
