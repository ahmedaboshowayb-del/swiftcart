import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/product_entity.dart';
import '../constants/app_colors.dart';
import '../routing/app_router.dart';
import '../utils/extensions.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.onAddToCart,
    this.width,
  });
  final ProductEntity product;
  final VoidCallback? onAddToCart;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppRoutes.productPath(product.id)),
      child: Container(
        width: width ?? 170,
        decoration: BoxDecoration(
          color: context.isDark ? AppColors.darkSurface : AppColors.lightSurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: context.isDark
                ? AppColors.darkBorder
                : AppColors.lightBorder,
          ),
          boxShadow: context.isDark ? [] : AppColors.cardShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,  
          children: [
            _Image(product: product),
Padding(
  padding: const EdgeInsets.fromLTRB(8, 6, 8, 6), 
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        product.categoryName,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 9,
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      const SizedBox(height: 2),

      Text(
        product.name,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: context.isDark
              ? AppColors.textDarkPrimary
              : AppColors.textPrimary,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      const SizedBox(height: 2), 

      Row(
        children: [
          RatingBarIndicator(
            rating: product.rating,
            itemBuilder: (_, __) => const Icon(
              Icons.star_rounded,
              color: AppColors.warning,
            ),
            itemCount: 5,
            itemSize: 10,
          ),
          const SizedBox(width: 3),
          Text(
            '(${product.reviewCount})',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 9,
              color: AppColors.grey500,
            ),
          ),
        ],
      ),
      const SizedBox(height: 4), 

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (product.hasDiscount)
                  Text(
                    'SAR ${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 9,
                      color: AppColors.grey400,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                Text(
                  'SAR ${product.effectivePrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          _AddBtn(
            onTap: onAddToCart,
            inStock: product.isInStock,
          ),
        ],
      ),
    ],
  ),
),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.08, end: 0);
  }
}

class _Image extends StatelessWidget {
  const _Image({required this.product});
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: product.primaryImage,
            height: 130,          
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: (_, __) => Container(
              height: 130,
              color: AppColors.grey100,
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                  strokeWidth: 2,
                ),
              ),
            ),
            errorWidget: (_, __, ___) => Container(
              height: 130,
              color: AppColors.grey100,
              child: const Icon(
                Icons.image_not_supported_outlined,
                color: AppColors.grey400,
              ),
            ),
          ),

          if (product.hasDiscount)
            Positioned(
              top: 6,
              left: 6,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.error,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '-${product.discountPercentage.toInt()}%',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

          if (product.isNew && !product.hasDiscount)
            Positioned(
              top: 6,
              left: 6,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.success,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'NEW',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

          
          if (!product.isInStock)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Out of Stock',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _AddBtn extends StatelessWidget {
  const _AddBtn({this.onTap, required this.inStock});
  final VoidCallback? onTap;
  final bool inStock;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: inStock ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 30,             
        height: 30,            
        decoration: BoxDecoration(
          color: inStock ? AppColors.primary : AppColors.grey300,
          borderRadius: BorderRadius.circular(9),
          boxShadow: inStock ? AppColors.primaryShadow : [],
        ),
        child: const Icon(
          Icons.add_rounded,
          color: Colors.white,
          size: 16,           
        ),
      ),
    );
  }
}