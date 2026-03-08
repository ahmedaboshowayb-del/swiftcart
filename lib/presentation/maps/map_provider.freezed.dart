// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MapState {
  LatLng? get selectedLocation => throw _privateConstructorUsedError;
  String? get selectedAddress => throw _privateConstructorUsedError;
  bool get isLoadingLocation => throw _privateConstructorUsedError;
  bool get isLoadingAddress => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MapStateCopyWith<MapState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MapStateCopyWith<$Res> {
  factory $MapStateCopyWith(MapState value, $Res Function(MapState) then) =
      _$MapStateCopyWithImpl<$Res, MapState>;
  @useResult
  $Res call(
      {LatLng? selectedLocation,
      String? selectedAddress,
      bool isLoadingLocation,
      bool isLoadingAddress,
      String? errorMessage});
}

/// @nodoc
class _$MapStateCopyWithImpl<$Res, $Val extends MapState>
    implements $MapStateCopyWith<$Res> {
  _$MapStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedLocation = freezed,
    Object? selectedAddress = freezed,
    Object? isLoadingLocation = null,
    Object? isLoadingAddress = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      selectedLocation: freezed == selectedLocation
          ? _value.selectedLocation
          : selectedLocation // ignore: cast_nullable_to_non_nullable
              as LatLng?,
      selectedAddress: freezed == selectedAddress
          ? _value.selectedAddress
          : selectedAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoadingLocation: null == isLoadingLocation
          ? _value.isLoadingLocation
          : isLoadingLocation // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingAddress: null == isLoadingAddress
          ? _value.isLoadingAddress
          : isLoadingAddress // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MapStateImplCopyWith<$Res>
    implements $MapStateCopyWith<$Res> {
  factory _$$MapStateImplCopyWith(
          _$MapStateImpl value, $Res Function(_$MapStateImpl) then) =
      __$$MapStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {LatLng? selectedLocation,
      String? selectedAddress,
      bool isLoadingLocation,
      bool isLoadingAddress,
      String? errorMessage});
}

/// @nodoc
class __$$MapStateImplCopyWithImpl<$Res>
    extends _$MapStateCopyWithImpl<$Res, _$MapStateImpl>
    implements _$$MapStateImplCopyWith<$Res> {
  __$$MapStateImplCopyWithImpl(
      _$MapStateImpl _value, $Res Function(_$MapStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedLocation = freezed,
    Object? selectedAddress = freezed,
    Object? isLoadingLocation = null,
    Object? isLoadingAddress = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$MapStateImpl(
      selectedLocation: freezed == selectedLocation
          ? _value.selectedLocation
          : selectedLocation // ignore: cast_nullable_to_non_nullable
              as LatLng?,
      selectedAddress: freezed == selectedAddress
          ? _value.selectedAddress
          : selectedAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoadingLocation: null == isLoadingLocation
          ? _value.isLoadingLocation
          : isLoadingLocation // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingAddress: null == isLoadingAddress
          ? _value.isLoadingAddress
          : isLoadingAddress // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$MapStateImpl with DiagnosticableTreeMixin implements _MapState {
  const _$MapStateImpl(
      {this.selectedLocation,
      this.selectedAddress,
      this.isLoadingLocation = false,
      this.isLoadingAddress = false,
      this.errorMessage});

  @override
  final LatLng? selectedLocation;
  @override
  final String? selectedAddress;
  @override
  @JsonKey()
  final bool isLoadingLocation;
  @override
  @JsonKey()
  final bool isLoadingAddress;
  @override
  final String? errorMessage;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MapState(selectedLocation: $selectedLocation, selectedAddress: $selectedAddress, isLoadingLocation: $isLoadingLocation, isLoadingAddress: $isLoadingAddress, errorMessage: $errorMessage)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MapState'))
      ..add(DiagnosticsProperty('selectedLocation', selectedLocation))
      ..add(DiagnosticsProperty('selectedAddress', selectedAddress))
      ..add(DiagnosticsProperty('isLoadingLocation', isLoadingLocation))
      ..add(DiagnosticsProperty('isLoadingAddress', isLoadingAddress))
      ..add(DiagnosticsProperty('errorMessage', errorMessage));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MapStateImpl &&
            (identical(other.selectedLocation, selectedLocation) ||
                other.selectedLocation == selectedLocation) &&
            (identical(other.selectedAddress, selectedAddress) ||
                other.selectedAddress == selectedAddress) &&
            (identical(other.isLoadingLocation, isLoadingLocation) ||
                other.isLoadingLocation == isLoadingLocation) &&
            (identical(other.isLoadingAddress, isLoadingAddress) ||
                other.isLoadingAddress == isLoadingAddress) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedLocation,
      selectedAddress, isLoadingLocation, isLoadingAddress, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MapStateImplCopyWith<_$MapStateImpl> get copyWith =>
      __$$MapStateImplCopyWithImpl<_$MapStateImpl>(this, _$identity);
}

abstract class _MapState implements MapState {
  const factory _MapState(
      {final LatLng? selectedLocation,
      final String? selectedAddress,
      final bool isLoadingLocation,
      final bool isLoadingAddress,
      final String? errorMessage}) = _$MapStateImpl;

  @override
  LatLng? get selectedLocation;
  @override
  String? get selectedAddress;
  @override
  bool get isLoadingLocation;
  @override
  bool get isLoadingAddress;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$MapStateImplCopyWith<_$MapStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
