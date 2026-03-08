import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/foundation.dart';

part 'map_provider.freezed.dart';
part 'map_provider.g.dart';

@freezed
class MapState with _$MapState {
  const factory MapState({
    LatLng?         selectedLocation,
    String?         selectedAddress,
    @Default(false) bool isLoadingLocation,
    @Default(false) bool isLoadingAddress,
    String?         errorMessage,
  }) = _MapState;
}

const _defaultLocation = LatLng(24.7136, 46.6753);

@riverpod
class MapNotifier extends _$MapNotifier {
  MapController? mapController;

  @override
  MapState build() => const MapState(
        selectedLocation: _defaultLocation,
      );

  void onMapCreated(MapController controller) {
    mapController = controller;
  }

  Future<void> onMapTap(TapPosition tapPosition, LatLng position) async {
    state = state.copyWith(
      selectedLocation: position,
      selectedAddress:
          '${position.latitude.toStringAsFixed(5)}, ${position.longitude.toStringAsFixed(5)}',
      errorMessage: null,
    );
  }

  Future<void> getCurrentLocation() async {
    state = state.copyWith(isLoadingLocation: true, errorMessage: null);

    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        state = state.copyWith(
          isLoadingLocation: false,
          errorMessage: 'Please enable GPS on your device.',
        );
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          state = state.copyWith(
            isLoadingLocation: false,
            errorMessage: 'Location permission denied.',
          );
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        await openAppSettings();
        state = state.copyWith(
          isLoadingLocation: false,
          errorMessage: 'Enable location in Settings and try again.',
        );
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      ).timeout(const Duration(seconds: 15));

      final latLng = LatLng(position.latitude, position.longitude);

      mapController?.move(latLng, 16);

      state = state.copyWith(
        selectedLocation: latLng,
        isLoadingLocation: false,
        selectedAddress:
            '${latLng.latitude.toStringAsFixed(5)}, ${latLng.longitude.toStringAsFixed(5)}',
      );
    } catch (e) {
      debugPrint('❌ getCurrentLocation: $e');
      state = state.copyWith(
        isLoadingLocation: false,
        errorMessage: 'Could not get location. Tap on the map instead.',
      );
    }
  }

  void clearError() => state = state.copyWith(errorMessage: null);
}