// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checkout_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CheckoutState {
  String get paymentMethod => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  double get deliveryLat => throw _privateConstructorUsedError;
  double get deliveryLng => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isSuccess => throw _privateConstructorUsedError;
  OrderEntity? get placedOrder => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CheckoutStateCopyWith<CheckoutState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckoutStateCopyWith<$Res> {
  factory $CheckoutStateCopyWith(
          CheckoutState value, $Res Function(CheckoutState) then) =
      _$CheckoutStateCopyWithImpl<$Res, CheckoutState>;
  @useResult
  $Res call(
      {String paymentMethod,
      String address,
      double deliveryLat,
      double deliveryLng,
      bool isLoading,
      bool isSuccess,
      OrderEntity? placedOrder,
      String? errorMessage});
}

/// @nodoc
class _$CheckoutStateCopyWithImpl<$Res, $Val extends CheckoutState>
    implements $CheckoutStateCopyWith<$Res> {
  _$CheckoutStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentMethod = null,
    Object? address = null,
    Object? deliveryLat = null,
    Object? deliveryLng = null,
    Object? isLoading = null,
    Object? isSuccess = null,
    Object? placedOrder = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      deliveryLat: null == deliveryLat
          ? _value.deliveryLat
          : deliveryLat // ignore: cast_nullable_to_non_nullable
              as double,
      deliveryLng: null == deliveryLng
          ? _value.deliveryLng
          : deliveryLng // ignore: cast_nullable_to_non_nullable
              as double,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isSuccess: null == isSuccess
          ? _value.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      placedOrder: freezed == placedOrder
          ? _value.placedOrder
          : placedOrder // ignore: cast_nullable_to_non_nullable
              as OrderEntity?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CheckoutStateImplCopyWith<$Res>
    implements $CheckoutStateCopyWith<$Res> {
  factory _$$CheckoutStateImplCopyWith(
          _$CheckoutStateImpl value, $Res Function(_$CheckoutStateImpl) then) =
      __$$CheckoutStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String paymentMethod,
      String address,
      double deliveryLat,
      double deliveryLng,
      bool isLoading,
      bool isSuccess,
      OrderEntity? placedOrder,
      String? errorMessage});
}

/// @nodoc
class __$$CheckoutStateImplCopyWithImpl<$Res>
    extends _$CheckoutStateCopyWithImpl<$Res, _$CheckoutStateImpl>
    implements _$$CheckoutStateImplCopyWith<$Res> {
  __$$CheckoutStateImplCopyWithImpl(
      _$CheckoutStateImpl _value, $Res Function(_$CheckoutStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentMethod = null,
    Object? address = null,
    Object? deliveryLat = null,
    Object? deliveryLng = null,
    Object? isLoading = null,
    Object? isSuccess = null,
    Object? placedOrder = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_$CheckoutStateImpl(
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      deliveryLat: null == deliveryLat
          ? _value.deliveryLat
          : deliveryLat // ignore: cast_nullable_to_non_nullable
              as double,
      deliveryLng: null == deliveryLng
          ? _value.deliveryLng
          : deliveryLng // ignore: cast_nullable_to_non_nullable
              as double,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isSuccess: null == isSuccess
          ? _value.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      placedOrder: freezed == placedOrder
          ? _value.placedOrder
          : placedOrder // ignore: cast_nullable_to_non_nullable
              as OrderEntity?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$CheckoutStateImpl implements _CheckoutState {
  const _$CheckoutStateImpl(
      {this.paymentMethod = AppConstants.paymentCash,
      this.address = '',
      this.deliveryLat = 0.0,
      this.deliveryLng = 0.0,
      this.isLoading = false,
      this.isSuccess = false,
      this.placedOrder,
      this.errorMessage});

  @override
  @JsonKey()
  final String paymentMethod;
  @override
  @JsonKey()
  final String address;
  @override
  @JsonKey()
  final double deliveryLat;
  @override
  @JsonKey()
  final double deliveryLng;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isSuccess;
  @override
  final OrderEntity? placedOrder;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'CheckoutState(paymentMethod: $paymentMethod, address: $address, deliveryLat: $deliveryLat, deliveryLng: $deliveryLng, isLoading: $isLoading, isSuccess: $isSuccess, placedOrder: $placedOrder, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckoutStateImpl &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.deliveryLat, deliveryLat) ||
                other.deliveryLat == deliveryLat) &&
            (identical(other.deliveryLng, deliveryLng) ||
                other.deliveryLng == deliveryLng) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess) &&
            (identical(other.placedOrder, placedOrder) ||
                other.placedOrder == placedOrder) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      paymentMethod,
      address,
      deliveryLat,
      deliveryLng,
      isLoading,
      isSuccess,
      placedOrder,
      errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckoutStateImplCopyWith<_$CheckoutStateImpl> get copyWith =>
      __$$CheckoutStateImplCopyWithImpl<_$CheckoutStateImpl>(this, _$identity);
}

abstract class _CheckoutState implements CheckoutState {
  const factory _CheckoutState(
      {final String paymentMethod,
      final String address,
      final double deliveryLat,
      final double deliveryLng,
      final bool isLoading,
      final bool isSuccess,
      final OrderEntity? placedOrder,
      final String? errorMessage}) = _$CheckoutStateImpl;

  @override
  String get paymentMethod;
  @override
  String get address;
  @override
  double get deliveryLat;
  @override
  double get deliveryLng;
  @override
  bool get isLoading;
  @override
  bool get isSuccess;
  @override
  OrderEntity? get placedOrder;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$CheckoutStateImplCopyWith<_$CheckoutStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
