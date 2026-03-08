import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/extensions.dart';
import '../../core/widgets/error_view.dart';
import '../../domain/entities/order_entity.dart';
import 'orders_provider.dart';

class OrderDetailScreen extends ConsumerWidget {
  const OrderDetailScreen({super.key, required this.orderId});
  final String orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use the stream provider for real-time status updates
    final statusStream = ref.watch(orderStatusProvider(orderId));

    return statusStream.when(
      data: (order) => _OrderDetailBody(order: order),
      loading: () => Scaffold(
        appBar: AppBar(title: const Text('Order Details')),
        body: const Center(
            child: CircularProgressIndicator(color: AppColors.primary)),
      ),
      error: (e, _) => Scaffold(
        appBar: AppBar(title: const Text('Order Details')),
        body: ErrorView(message: e.toString()),
      ),
    );
  }
}

class _OrderDetailBody extends StatelessWidget {
  const _OrderDetailBody({required this.order});
  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _StatusTracker(status: order.status)
                .animate()
                .fadeIn(duration: 400.ms),

            const SizedBox(height: 20),

            _InfoCard(
              children: [
                _InfoRow('Order ID',
                    '#${order.id.substring(0, 8).toUpperCase()}'),
                _InfoRow('Date', order.createdAt.formattedDateTime),
                _InfoRow('Payment', _paymentLabel(order.paymentMethod)),
                _InfoRow('Delivery Address', order.deliveryAddress),
              ],
            ).animate(delay: 100.ms).fadeIn(duration: 300.ms),

            const SizedBox(height: 16),

            Text(
              'Items Ordered',
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

            _InfoCard(
              children: order.items
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              '${item.product.name} × ${item.quantity}',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                color: context.isDark
                                    ? AppColors.textDarkPrimary
                                    : AppColors.textPrimary,
                              ),
                            ),
                          ),
                          Text(
                            item.itemTotal.asCurrency,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ).animate(delay: 200.ms).fadeIn(duration: 300.ms),

            const SizedBox(height: 16),

            _InfoCard(
              children: [
                _InfoRow('Subtotal', order.subtotal.asCurrency),
                _InfoRow(
                    'Delivery Fee',
                    order.deliveryFee == 0
                        ? 'FREE'
                        : order.deliveryFee.asCurrency,
                    valueColor: order.deliveryFee == 0
                        ? AppColors.success
                        : null),
                const Divider(height: 16),
                _InfoRow('Total', order.total.asCurrency,
                    valueColor: AppColors.primary, isBold: true),
              ],
            ).animate(delay: 300.ms).fadeIn(duration: 300.ms),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  String _paymentLabel(String method) => switch (method) {
    'card'   => 'Credit / Debit Card',
    'wallet' => 'Digital Wallet',
    _        => 'Cash on Delivery',
  };
}

class _StatusTracker extends StatelessWidget {
  const _StatusTracker({required this.status});
  final OrderStatus status;

  static const _steps = [
    OrderStatus.preparing,
    OrderStatus.onTheWay,
    OrderStatus.delivered,
  ];

  bool _isActive(OrderStatus step) {
    final stepIdx   = _steps.indexOf(step);
    final statusIdx = _steps.indexOf(status);
    return stepIdx <= statusIdx;
  }

  @override
  Widget build(BuildContext context) {
    if (status == OrderStatus.cancelled) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.errorLight,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cancel_rounded, color: AppColors.error),
            SizedBox(width: 8),
            Text('Order Cancelled', style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              color: AppColors.error,
            )),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.isDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),
      ),
      child: Row(
        children: _steps.asMap().entries.map((entry) {
          final i    = entry.key;
          final step = entry.value;
          final done = _isActive(step);

          return Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: done ? AppColors.primary : AppColors.grey200,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _stepIcon(step),
                          size: 18,
                          color: done ? Colors.white : AppColors.grey400,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        step.label,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 10,
                          fontWeight: done ? FontWeight.w600 : FontWeight.w400,
                          color: done
                              ? AppColors.primary
                              : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                if (i < _steps.length - 1)
                  Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      height: 2,
                      color: _isActive(_steps[i + 1])
                          ? AppColors.primary
                          : AppColors.grey200,
                    ),
                  ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  IconData _stepIcon(OrderStatus s) => switch (s) {
    OrderStatus.preparing  => Icons.restaurant_menu_rounded,
    OrderStatus.onTheWay   => Icons.delivery_dining_rounded,
    OrderStatus.delivered  => Icons.check_circle_rounded,
    OrderStatus.cancelled  => Icons.cancel_rounded,
  };
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: context.isDark ? AppColors.darkSurface : AppColors.lightSurface,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: context.isDark ? AppColors.darkBorder : AppColors.lightBorder,
      ),
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
  );
}

class _InfoRow extends StatelessWidget {
  const _InfoRow(this.label, this.value,
      {this.valueColor, this.isBold = false});
  final String label, value;
  final Color? valueColor;
  final bool isBold;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(
            fontFamily: 'Poppins', fontSize: 13, color: AppColors.textSecondary)),
        const SizedBox(width: 12),
        Flexible(child: Text(value, textAlign: TextAlign.end, style: TextStyle(
          fontFamily: 'Poppins', fontSize: 13,
          fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
          color: valueColor ??
              (context.isDark ? AppColors.textDarkPrimary : AppColors.textPrimary),
        ))),
      ],
    ),
  );
}