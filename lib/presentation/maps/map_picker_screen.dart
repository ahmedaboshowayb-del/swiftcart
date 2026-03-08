import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/extensions.dart';
import '../../core/widgets/app_button.dart';
import 'map_provider.dart';
import 'dart:ui' as ui;

class MapPickerScreen extends ConsumerStatefulWidget {
  const MapPickerScreen({super.key});

  @override
  ConsumerState<MapPickerScreen> createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends ConsumerState<MapPickerScreen> {
  late final MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(mapNotifierProvider.notifier).onMapCreated(_mapController);
    });
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mapState = ref.watch(mapNotifierProvider);
    final notifier = ref.read(mapNotifierProvider.notifier);

    ref.listen(mapNotifierProvider, (_, next) {
      if (next.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
          ),
        );
        notifier.clearError();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Delivery Location'),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => context.pop(),
        ),
        actions: [
          if (mapState.selectedLocation != null)
            TextButton(
              onPressed: () => context.pop({
                'lat':     mapState.selectedLocation!.latitude,
                'lng':     mapState.selectedLocation!.longitude,
                'address': mapState.selectedAddress ?? '',
              }),
              child: const Text(
                'Confirm',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),
        ],
      ),
      body: Stack(
        children: [

          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: mapState.selectedLocation ??
                  const LatLng(24.7136, 46.6753),
              initialZoom: 13,
              onTap: notifier.onMapTap,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.swiftcart',
                maxZoom: 19,
              ),

              if (mapState.selectedLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: mapState.selectedLocation!,
                      width: 50,
                      height: 50,
                      child: const _LocationPin(),
                    ),
                  ],
                ),

              const RichAttributionWidget(
                attributions: [
                  TextSourceAttribution('OpenStreetMap contributors'),
                ],
              ),
            ],
          ),

          Positioned(
            top: 12,
            right: 12,
            child: _GpsButton(
              isLoading: mapState.isLoadingLocation,
              onTap: notifier.getCurrentLocation,
            ),
          ),

          if (mapState.selectedLocation == null)
            Positioned(
              top: 12,
              left: 16,
              right: 70,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: AppColors.cardShadow,
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.touch_app_rounded,
                        color: AppColors.primary, size: 16),
                    SizedBox(width: 6),
                    Text(
                      'Tap anywhere on the map',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 400.ms),
            ),

          if (mapState.selectedLocation != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _BottomPanel(
                address: mapState.selectedAddress,
                isLoadingAddress: mapState.isLoadingAddress,
                onConfirm: () => context.pop({
                  'lat':     mapState.selectedLocation!.latitude,
                  'lng':     mapState.selectedLocation!.longitude,
                  'address': mapState.selectedAddress ?? '',
                }),
              ).animate().slideY(
                    begin: 0.3,
                    end: 0,
                    duration: 300.ms,
                    curve: Curves.easeOut,
                  ),
            ),
        ],
      ),
    );
  }
}

class _LocationPin extends StatelessWidget {
  const _LocationPin();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: AppColors.primaryShadow,
          ),
          child: const Icon(
            Icons.location_on_rounded,
            color: Colors.white,
            size: 20,
          ),
        ),
        CustomPaint(
          size: const Size(12, 8),
          painter: _PinTailPainter(),
        ),
      ],
    );
  }
}

class _PinTailPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.primary;
    final path = ui.Path()          
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_) => false;
}


class _GpsButton extends StatelessWidget {
  const _GpsButton({required this.isLoading, required this.onTap});
  final bool       isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: AppColors.cardShadow,
        ),
        child: isLoading
            ? const Padding(
                padding: EdgeInsets.all(12),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.primary,
                ),
              )
            : const Icon(
                Icons.my_location_rounded,
                color: AppColors.primary,
                size: 22,
              ),
      ),
    );
  }
}

class _BottomPanel extends StatelessWidget {
  const _BottomPanel({
    required this.address,
    required this.isLoadingAddress,
    required this.onConfirm,
  });
  final String?      address;
  final bool         isLoadingAddress;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.isDark ? AppColors.darkSurface : Colors.white,
        borderRadius:
            const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(
        24,
        20,
        24,
        24 + MediaQuery.of(context).padding.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: AppColors.grey300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          const Text(
            'Delivery Location',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),

          Row(
            children: [
              const Icon(Icons.location_on_rounded,
                  color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  address ?? 'Location selected',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: context.isDark
                        ? AppColors.textDarkPrimary
                        : AppColors.textPrimary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          AppButton(
            label: 'Confirm Delivery Location',
            onPressed: onConfirm,
            icon: const Icon(Icons.check_circle_outline_rounded),
          ),
        ],
      ),
    );
  }
}