import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/routing/app_router.dart';
import '../../core/utils/extensions.dart';
import '../../core/widgets/app_button.dart';
import 'cart_provider.dart';
import 'checkout_provider.dart';

class CheckoutScreen extends ConsumerWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state    = ref.watch(checkoutNotifierProvider);
    final items    = ref.watch(cartItemsProvider).valueOrNull ?? [];
    final subtotal = ref.watch(cartSubtotalProvider);
    final fee      = ref.watch(deliveryFeeProvider);
    final total    = ref.watch(cartTotalProvider);

    ref.listen(checkoutNotifierProvider, (_, next) {
      if (next.isSuccess && next.placedOrder != null) {
        context.go(AppRoutes.orderSuccess,
            extra: next.placedOrder!.id);
      }
      if (next.errorMessage != null) {
        context.showErrorSnackBar(next.errorMessage!);
        ref.read(checkoutNotifierProvider.notifier).clearError();
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionCard(
              title: 'Delivery Address',
              icon: Icons.location_on_outlined,
              child: state.address.isEmpty
                  ? GestureDetector(
                      onTap: () async {
                        final result = await context.push<Map<String, dynamic>>(
                            AppRoutes.mapPicker);
                        if (result != null) {
                          ref
                              .read(checkoutNotifierProvider.notifier)
                              .setAddress(
                                result['address'] as String,
                                result['lat'] as double,
                                result['lng'] as double,
                              );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.primaryContainer,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: AppColors.primary.withOpacity(0.3)),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.add_location_alt_outlined,
                                color: AppColors.primary),
                            SizedBox(width: 10),
                            Text(
                              'Choose delivery location on map',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        width: 44,
                        height: 44,
                        decoration: const BoxDecoration(
                          color: AppColors.primaryContainer,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.location_on_rounded,
                            color: AppColors.primary, size: 22),
                      ),
                      title: Text(
                        state.address,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: context.isDark
                              ? AppColors.textDarkPrimary
                              : AppColors.textPrimary,
                        ),
                      ),
                      trailing: TextButton(
                        onPressed: () async {
                          final result =
                              await context.push<Map<String, dynamic>>(
                                  AppRoutes.mapPicker);
                          if (result != null) {
                            ref
                                .read(checkoutNotifierProvider.notifier)
                                .setAddress(
                                  result['address'] as String,
                                  result['lat'] as double,
                                  result['lng'] as double,
                                );
                          }
                        },
                        child: const Text('Change'),
                      ),
                    ),
            ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.05, end: 0),

            const SizedBox(height: 16),

            _SectionCard(
              title: 'Payment Method',
              icon: Icons.payment_outlined,
              child: Column(
                children: [
                  _PaymentOption(
                    label: 'Cash on Delivery',
                    icon: Icons.money_rounded,
                    value: AppConstants.paymentCash,
                    selected: state.paymentMethod,
                    onTap: () => ref
                        .read(checkoutNotifierProvider.notifier)
                        .setPaymentMethod(AppConstants.paymentCash),
                  ),
                  const SizedBox(height: 10),
                  _PaymentOption(
                    label: 'Credit / Debit Card',
                    icon: Icons.credit_card_rounded,
                    value: AppConstants.paymentCard,
                    selected: state.paymentMethod,
                    onTap: () => ref
                        .read(checkoutNotifierProvider.notifier)
                        .setPaymentMethod(AppConstants.paymentCard),
                  ),
                  const SizedBox(height: 10),
                  _PaymentOption(
                    label: 'Digital Wallet',
                    icon: Icons.account_balance_wallet_outlined,
                    value: AppConstants.paymentWallet,
                    selected: state.paymentMethod,
                    onTap: () => ref
                        .read(checkoutNotifierProvider.notifier)
                        .setPaymentMethod(AppConstants.paymentWallet),
                  ),
                ],
              ),
            )
                .animate(delay: 100.ms)
                .fadeIn(duration: 300.ms)
                .slideY(begin: 0.05, end: 0),

            const SizedBox(height: 16),

            _SectionCard(
              title: 'Order Summary',
              icon: Icons.receipt_long_outlined,
              child: Column(
                children: [
                  ...items.map(
                    (item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              '${item.product.name} × ${item.quantity}',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                color: context.isDark
                                    ? AppColors.textDarkSecondary
                                    : AppColors.textSecondary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            item.itemTotal.asCurrency,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: context.isDark
                                  ? AppColors.textDarkPrimary
                                  : AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(height: 20),

                  _SummaryRow('Subtotal', subtotal.asCurrency),
                  const SizedBox(height: 6),
                  _SummaryRow(
                    'Delivery Fee',
                    fee == 0 ? 'FREE' : fee.asCurrency,
                    valueColor: fee == 0 ? AppColors.success : null,
                  ),
                  const Divider(height: 20),
                  _SummaryRow(
                    'Total',
                    total.asCurrency,
                    isTotal: true,
                  ),
                ],
              ),
            )
                .animate(delay: 200.ms)
                .fadeIn(duration: 300.ms)
                .slideY(begin: 0.05, end: 0),

            const SizedBox(height: 32),

            AppButton(
              label: 'Place Order  •  ${total.asCurrency}',
              onPressed: () =>
                  ref.read(checkoutNotifierProvider.notifier).placeOrder(),
              isLoading: state.isLoading,
              icon: const Icon(Icons.check_circle_outline_rounded),
            )
                .animate(delay: 300.ms)
                .fadeIn(duration: 300.ms)
                .slideY(begin: 0.1, end: 0),

            const SizedBox(height: 8),
            Center(
              child: Text(
                '🔒 Secured checkout',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}


class _SectionCard extends StatelessWidget {
  const _SectionCard(
      {required this.title, required this.icon, required this.child});
  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color:
                context.isDark ? AppColors.darkBorder : AppColors.lightBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(icon, color: AppColors.primary, size: 18),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: context.isDark
                    ? AppColors.textDarkPrimary
                    : AppColors.textPrimary,
              ),
            ),
          ]),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}


class _PaymentOption extends StatelessWidget {
  const _PaymentOption({
    required this.label,
    required this.icon,
    required this.value,
    required this.selected,
    required this.onTap,
  });
  final String label, value, selected;
  final IconData icon;
  final VoidCallback onTap;

  bool get isSelected => value == selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryContainer : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : (context.isDark ? AppColors.darkBorder : AppColors.lightBorder),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(children: [
          Icon(icon,
              color: isSelected ? AppColors.primary : AppColors.grey500,
              size: 22),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected
                  ? AppColors.primary
                  : (context.isDark
                      ? AppColors.textDarkPrimary
                      : AppColors.textPrimary),
            ),
          ),
          const Spacer(),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.grey400,
                  width: 2),
              color: isSelected ? AppColors.primary : Colors.transparent,
            ),
            child: isSelected
                ? const Icon(Icons.check, size: 12, color: Colors.white)
                : null,
          ),
        ]),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow(this.label, this.value,
      {this.isTotal = false, this.valueColor});
  final String label, value;
  final bool isTotal;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: isTotal ? 15 : 13,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
              color: isTotal
                  ? (context.isDark
                      ? AppColors.textDarkPrimary
                      : AppColors.textPrimary)
                  : AppColors.textSecondary,
            )),
        Text(value,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: isTotal ? 17 : 13,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
              color: valueColor ??
                  (isTotal
                      ? AppColors.primary
                      : (context.isDark
                          ? AppColors.textDarkPrimary
                          : AppColors.textPrimary)),
            )),
      ],
    );
  }
}