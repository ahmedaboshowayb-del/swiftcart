import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../constants/app_colors.dart';

class ShimmerBox extends StatelessWidget {
  const ShimmerBox({super.key, required this.width, required this.height, this.radius = 8});
  final double width, height, radius;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Shimmer.fromColors(
      baseColor:      dark ? AppColors.darkSurfaceVariant : AppColors.grey200,
      highlightColor: dark ? AppColors.darkBorder          : AppColors.grey100,
      child: Container(
        width: width, height: height,
        decoration: BoxDecoration(
          color: dark ? AppColors.darkSurfaceVariant : AppColors.grey200,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}

class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Shimmer.fromColors(
      baseColor: dark ? AppColors.darkSurfaceVariant : AppColors.grey200,
      highlightColor: dark ? AppColors.darkBorder    : AppColors.grey100,
      child: Container(
        width: 170,
        decoration: BoxDecoration(
          color: dark ? AppColors.darkSurface : AppColors.lightSurface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(height: 140, decoration: BoxDecoration(
            color: dark ? AppColors.darkSurfaceVariant : AppColors.grey200,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          )),
          Padding(padding: const EdgeInsets.all(10), child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 10, width: 60,
                  color: dark ? AppColors.darkSurfaceVariant : AppColors.grey200),
              const SizedBox(height: 6),
              Container(height: 12, width: 120,
                  color: dark ? AppColors.darkSurfaceVariant : AppColors.grey200),
              const SizedBox(height: 4),
              Container(height: 10, width: 80,
                  color: dark ? AppColors.darkSurfaceVariant : AppColors.grey200),
            ],
          )),
        ]),
      ),
    );
  }
}

class ProductRowShimmer extends StatelessWidget {
  const ProductRowShimmer({super.key, this.count = 4});
  final int count;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 250,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: count,
      separatorBuilder: (_, __) => const SizedBox(width: 12),
      itemBuilder: (_, __) => const ProductCardShimmer(),
    ),
  );
}