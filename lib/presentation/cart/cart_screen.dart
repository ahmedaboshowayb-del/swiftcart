import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';
import '../../core/routing/app_router.dart';
import '../../core/utils/extensions.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/error_view.dart';
import '../../domain/entities/cart_item_entity.dart';
import 'cart_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartAsync = ref.watch(cartItemsProvider);
    final subtotal  = ref.watch(cartSubtotalProvider);
    final fee       = ref.watch(deliveryFeeProvider);
    final total     = ref.watch(cartTotalProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        actions: [
          if ((cartAsync.valueOrNull ?? []).isNotEmpty)
            TextButton(
              onPressed: () => _confirmClear(context, ref),
              child: const Text('Clear', style: TextStyle(color: AppColors.error)),
            ),
        ],
      ),
      body: cartAsync.when(
        data: (items) {
          if (items.isEmpty) {
            return EmptyView(
              title: 'Cart is Empty',
              subtitle: 'Add some products to get started',
              action: () => context.go(AppRoutes.home),
              actionLabel: 'Browse Products',
            );
          }
          return Column(children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, i) => _CartItemCard(item: items[i]),
              ),
            ),
            _CheckoutPanel(subtotal: subtotal, fee: fee, total: total),
          ]);
        },
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
        error: (e, _) => ErrorView(message: e.toString()),
      ),
    );
  }

  void _confirmClear(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Clear Cart'),
        content: const Text('Remove all items from your cart?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              ref.read(cartNotifierProvider.notifier).clear();
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }
}

class _CartItemCard extends ConsumerWidget {
  const _CartItemCard({required this.item});
  final CartItemEntity item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(cartNotifierProvider.notifier);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.isDark ? AppColors.darkBorder : AppColors.lightBorder),
      ),
      child: Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            imageUrl: item.product.primaryImage,
            width: 80, height: 80, fit: BoxFit.cover,
            errorWidget: (_, __, ___) => Container(
              width: 80, height: 80, color: AppColors.grey100,
              child: const Icon(Icons.image_outlined, color: AppColors.grey400),
            ),
          ),
        ),
        const SizedBox(width: 12),

        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Name
          Text(item.product.name, maxLines: 2, overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'Poppins', fontSize: 13, fontWeight: FontWeight.w600,
              color: context.isDark ? AppColors.textDarkPrimary : AppColors.textPrimary,
            )),
          const SizedBox(height: 4),

          Text(item.product.effectivePrice.asCurrency,
            style: const TextStyle(fontFamily: 'Poppins', fontSize: 14,
                fontWeight: FontWeight.w700, color: AppColors.primary)),
          const SizedBox(height: 8),

          Row(children: [
            _QtyBtn(
              icon: Icons.remove_rounded,
              onTap: () => item.quantity <= 1
                  ? notifier.remove(item.product.id)
                  : notifier.updateQty(item.product.id, item.quantity - 1),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Text('${item.quantity}', style: TextStyle(
                fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.w700,
                color: context.isDark ? AppColors.textDarkPrimary : AppColors.textPrimary,
              )),
            ),
            _QtyBtn(
              icon: Icons.add_rounded,
              isPrimary: true,
              onTap: () => notifier.updateQty(item.product.id, item.quantity + 1),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.delete_outline_rounded, color: AppColors.error),
              onPressed: () => notifier.remove(item.product.id),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ]),
        ])),
      ]),
    ).animate().fadeIn(duration: 300.ms).slideX(begin: -0.05, end: 0);
  }
}

class _QtyBtn extends StatelessWidget {
  const _QtyBtn({required this.icon, required this.onTap, this.isPrimary = false});
  final IconData icon;
  final VoidCallback onTap;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: 32, height: 32,
      decoration: BoxDecoration(
        color: isPrimary ? AppColors.primary : AppColors.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 16, color: isPrimary ? Colors.white : AppColors.primary),
    ),
  );
}

class _CheckoutPanel extends StatelessWidget {
  const _CheckoutPanel({required this.subtotal, required this.fee, required this.total});
  final double subtotal, fee, total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      decoration: BoxDecoration(
        color: context.isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [BoxShadow(
          color: Colors.black.withOpacity(0.06), blurRadius: 20, offset: const Offset(0, -4))],
      ),
      child: SafeArea(top: false, child: Column(children: [
        _Row('Subtotal',     subtotal.asCurrency),
        const SizedBox(height: 8),
        _Row('Delivery Fee', fee == 0 ? 'FREE' : fee.asCurrency,
            valueColor: fee == 0 ? AppColors.success : null),
        const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Divider()),
        _Row('Total', total.asCurrency, isTotal: true),
        const SizedBox(height: 16),
        AppButton(
          label: 'Proceed to Checkout',
          onPressed: () => context.push(AppRoutes.checkout),
          icon: const Icon(Icons.arrow_forward_rounded),
        ),
        const SizedBox(height: 4),
      ])),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row(this.label, this.value, {this.isTotal = false, this.valueColor});
  final String label, value;
  final bool   isTotal;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: isTotal ? 16 : 14,
        fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
        color: isTotal
            ? (context.isDark ? AppColors.textDarkPrimary : AppColors.textPrimary)
            : AppColors.textSecondary,
      )),
      Text(value, style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: isTotal ? 18 : 14,
        fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
        color: valueColor ?? (isTotal ? AppColors.primary : null),
      )),
    ],
  );
}