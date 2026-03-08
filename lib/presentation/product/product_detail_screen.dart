import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/extensions.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/error_view.dart';
import '../../core/widgets/product_card.dart';
import '../../core/widgets/shimmer_loading.dart';
import '../../domain/entities/product_entity.dart';
import '../cart/cart_provider.dart';
import 'product_provider.dart';

class ProductDetailScreen extends ConsumerWidget {
  const ProductDetailScreen({super.key, required this.productId});
  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(productDetailProvider(productId));

    return async.when(
      data: (product) => _ProductDetailView(product: product),
      loading: () => const _ProductDetailSkeleton(),
      error: (e, _) => Scaffold(
        appBar: AppBar(),
        body: ErrorView(
          message: e.toString(),
          onRetry: () => ref.invalidate(productDetailProvider(productId)),
        ),
      ),
    );
  }
}

class _ProductDetailView extends ConsumerStatefulWidget {
  const _ProductDetailView({required this.product});
  final ProductEntity product;

  @override
  ConsumerState<_ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends ConsumerState<_ProductDetailView> {
  int _qty = 1;

  void _increment() => setState(() => _qty++);
  void _decrement() => setState(() { if (_qty > 1) _qty--; });

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    final cartState = ref.watch(cartNotifierProvider);

    return Scaffold(
      backgroundColor:
          context.isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 340,
            pinned: true,
            backgroundColor:
                context.isDark ? AppColors.darkSurface : AppColors.lightSurface,
            flexibleSpace: FlexibleSpaceBar(
              background: _ImageGallery(images: p.images),
            ),
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: context.isDark
                      ? AppColors.darkSurface.withOpacity(0.9)
                      : Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 18,
                  color: context.isDark
                      ? AppColors.textDarkPrimary
                      : AppColors.textPrimary,
                ),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: context.isDark
                        ? AppColors.darkSurface.withOpacity(0.9)
                        : Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.favorite_border_rounded,
                    size: 20,
                    color: context.isDark
                        ? AppColors.textDarkPrimary
                        : AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),

          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: context.isDark
                    ? AppColors.darkBackground
                    : AppColors.lightBackground,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primaryContainer,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            p.categoryName,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        _StockBadge(inStock: p.isInStock),
                      ],
                    ).animate().fadeIn(duration: 300.ms),

                    const SizedBox(height: 12),

                    Text(
                      p.name,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: context.isDark
                            ? AppColors.textDarkPrimary
                            : AppColors.textPrimary,
                        height: 1.3,
                      ),
                    )
                        .animate(delay: 50.ms)
                        .fadeIn(duration: 300.ms)
                        .slideY(begin: 0.1, end: 0),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: p.rating,
                          itemBuilder: (_, __) => const Icon(
                              Icons.star_rounded,
                              color: AppColors.warning),
                          itemCount: 5,
                          itemSize: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          p.rating.toStringAsFixed(1),
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: context.isDark
                                ? AppColors.textDarkPrimary
                                : AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(${p.reviewCount} reviews)',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ).animate(delay: 100.ms).fadeIn(duration: 300.ms),

                    const SizedBox(height: 16),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          p.effectivePrice.asCurrency,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                        if (p.hasDiscount) ...[
                          const SizedBox(width: 10),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              p.price.asCurrency,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 15,
                                color: AppColors.grey400,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.errorLight,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '-${p.discountPercentage.toInt()}%',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: AppColors.error,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ).animate(delay: 150.ms).fadeIn(duration: 300.ms),

                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 16),

                    Text(
                      'Description',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: context.isDark
                            ? AppColors.textDarkPrimary
                            : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _ExpandableText(text: p.description),

                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 16),

                    _InfoRow(label: 'Brand', value: p.brand),
                    const SizedBox(height: 8),
                    _InfoRow(label: 'In Stock', value: '${p.stock} units'),

                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Quantity',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: context.isDark
                                ? AppColors.textDarkPrimary
                                : AppColors.textPrimary,
                          ),
                        ),
                        _QuantitySelector(
                          qty: _qty,
                          onDecrement: _decrement,
                          onIncrement: _increment,
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    _SimilarProducts(
                        productId: p.id, categoryId: p.categoryId),

                    const SizedBox(height: 120), 
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: _BottomBar(
        product: p,
        qty: _qty,
        isLoading: cartState is AsyncLoading,
      ),
    );
  }
}

class _ImageGallery extends ConsumerWidget {
  const _ImageGallery({required this.images});
  final List<String> images;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final idx = ref.watch(productImageIndexProvider);

    return Stack(
      children: [
        PageView.builder(
          onPageChanged: (i) =>
              ref.read(productImageIndexProvider.notifier).setIndex(i),
          itemCount: images.isEmpty ? 1 : images.length,
          itemBuilder: (_, i) {
            final url = images.isEmpty ? '' : images[i];
            return CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(color: AppColors.grey100,
                  child: const Center(child: CircularProgressIndicator(
                      color: AppColors.primary, strokeWidth: 2))),
              errorWidget: (_, __, ___) => Container(color: AppColors.grey100,
                  child: const Icon(Icons.image_not_supported_outlined,
                      color: AppColors.grey400, size: 48)),
            );
          },
        ),

        if (images.length > 1)
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                images.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: i == idx ? 18 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: i == idx
                        ? AppColors.primary
                        : Colors.white.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _StockBadge extends StatelessWidget {
  const _StockBadge({required this.inStock});
  final bool inStock;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: inStock ? AppColors.successLight : AppColors.errorLight,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            inStock ? Icons.check_circle_rounded : Icons.cancel_rounded,
            size: 12,
            color: inStock ? AppColors.success : AppColors.error,
          ),
          const SizedBox(width: 4),
          Text(
            inStock ? 'In Stock' : 'Out of Stock',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: inStock ? AppColors.success : AppColors.error,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});
  final String label, value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: AppColors.textSecondary)),
        Text(value,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: context.isDark
                    ? AppColors.textDarkPrimary
                    : AppColors.textPrimary)),
      ],
    );
  }
}

class _QuantitySelector extends StatelessWidget {
  const _QuantitySelector({
    required this.qty,
    required this.onDecrement,
    required this.onIncrement,
  });
  final int qty;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _QBtn(icon: Icons.remove_rounded, onTap: onDecrement),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '$qty',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: context.isDark
                  ? AppColors.textDarkPrimary
                  : AppColors.textPrimary,
            ),
          ),
        ),
        _QBtn(icon: Icons.add_rounded, onTap: onIncrement, primary: true),
      ],
    );
  }
}

class _QBtn extends StatelessWidget {
  const _QBtn({required this.icon, required this.onTap, this.primary = false});
  final IconData icon;
  final VoidCallback onTap;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: primary ? AppColors.primary : AppColors.primaryContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon,
            size: 18,
            color: primary ? Colors.white : AppColors.primary),
      ),
    );
  }
}

class _ExpandableText extends StatefulWidget {
  const _ExpandableText({required this.text});
  final String text;

  @override
  State<_ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<_ExpandableText> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedCrossFade(
          firstChild: Text(
            widget.text,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
          secondChild: Text(
            widget.text,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
          crossFadeState: _expanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () => setState(() => _expanded = !_expanded),
          child: Text(
            _expanded ? 'Show less' : 'Read more',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}

class _SimilarProducts extends ConsumerWidget {
  const _SimilarProducts(
      {required this.productId, required this.categoryId});
  final String productId;
  final String categoryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async =
        ref.watch(similarProductsProvider(productId, categoryId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'You May Also Like',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: context.isDark
                ? AppColors.textDarkPrimary
                : AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        async.when(
          data: (products) => products.isEmpty
              ? const SizedBox.shrink()
              : SizedBox(
                  height: 258,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: products.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (_, i) => ProductCard(
                      product: products[i],
                      onAddToCart: () => ref
                          .read(cartNotifierProvider.notifier)
                          .addToCart(products[i]),
                    ),
                  ),
                ),
          loading: () => const ProductRowShimmer(count: 3),
          error: (_, __) => const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class _BottomBar extends ConsumerWidget {
  const _BottomBar(
      {required this.product, required this.qty, required this.isLoading});
  final ProductEntity product;
  final int qty;
  final bool isLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      decoration: BoxDecoration(
        color: context.isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius:
            const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: context.isDark
                    ? AppColors.darkSurfaceVariant
                    : AppColors.lightSurfaceVariant,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                    color: context.isDark
                        ? AppColors.darkBorder
                        : AppColors.lightBorder),
              ),
              child: const Icon(Icons.favorite_border_rounded,
                  color: AppColors.primary),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: AppButton(
                label: product.isInStock ? 'Add to Cart' : 'Out of Stock',
                onPressed: product.isInStock
                    ? () async {
                        await ref
                            .read(cartNotifierProvider.notifier)
                            .addToCart(product, quantity: qty);
                        if (context.mounted) {
                          context.showSuccessSnackBar(
                              '${product.name} added to cart!');
                        }
                      }
                    : null,
                isLoading: isLoading,
                icon: const Icon(Icons.shopping_cart_outlined),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductDetailSkeleton extends StatelessWidget {
  const _ProductDetailSkeleton();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ShimmerBox(width: double.infinity, height: 340, radius: 0),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerBox(width: 100, height: 28, radius: 8),
                const SizedBox(height: 12),
                ShimmerBox(width: double.infinity, height: 22, radius: 6),
                const SizedBox(height: 6),
                ShimmerBox(width: 200, height: 22, radius: 6),
                const SizedBox(height: 16),
                ShimmerBox(width: 140, height: 36, radius: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}