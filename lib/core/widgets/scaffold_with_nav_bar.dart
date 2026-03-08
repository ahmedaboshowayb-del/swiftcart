import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';
import '../../presentation/cart/cart_provider.dart';

class ScaffoldWithNavBar extends ConsumerWidget {
  const ScaffoldWithNavBar({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartCount = ref.watch(cartItemCountProvider);
    final isDark    = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
          border: Border(
            top: BorderSide(
              color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
              width: 1,
            ),
          ),
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 58,
            child: Row(
              children: [
                _NavTab(
                  index: 0,
                  icon:       Icons.home_outlined,
                  activeIcon: Icons.home_rounded,
                  label: 'Home',
                  current: navigationShell.currentIndex,
                  onTap: () => _go(0),
                ),
                _NavTab(
                  index: 1,
                  icon:       Icons.grid_view_outlined,
                  activeIcon: Icons.grid_view_rounded,
                  label: 'Categories',
                  current: navigationShell.currentIndex,
                  onTap: () => _go(1),
                ),
                Expanded(
                  child: _CartTab(
                    index: 2,
                    count: cartCount,
                    current: navigationShell.currentIndex,
                    onTap: () => _go(2),
                  ),
                ),
                _NavTab(
                  index: 3,
                  icon:       Icons.receipt_long_outlined,
                  activeIcon: Icons.receipt_long_rounded,
                  label: 'Orders',
                  current: navigationShell.currentIndex,
                  onTap: () => _go(3),
                ),
                _NavTab(
                  index: 4,
                  icon:       Icons.person_outline_rounded,
                  activeIcon: Icons.person_rounded,
                  label: 'Profile',
                  current: navigationShell.currentIndex,
                  onTap: () => _go(4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _go(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}


class _NavTab extends StatelessWidget {
  const _NavTab({
    required this.index,
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.current,
    required this.onTap,
  });
  final int      index;
  final IconData icon, activeIcon;
  final String   label;
  final int      current;
  final VoidCallback onTap;

  bool get _selected => index == current;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                _selected ? activeIcon : icon,
                key: ValueKey(_selected),
                color: _selected ? AppColors.primary : AppColors.grey400,
                size: 24,
              ),
            ),
            const SizedBox(height: 3),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 10,
                fontWeight:
                    _selected ? FontWeight.w600 : FontWeight.w400,
                color:
                    _selected ? AppColors.primary : AppColors.grey400,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartTab extends StatelessWidget {
  const _CartTab({
    required this.index,
    required this.count,
    required this.current,
    required this.onTap,
  });
  final int index, count, current;
  final VoidCallback onTap;

  bool get _selected => index == current;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          badges.Badge(
            showBadge: count > 0,
            badgeContent: Text(
              count > 99 ? '99+' : '$count',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 9,
                fontWeight: FontWeight.w700,
              ),
            ),
            badgeStyle: const badges.BadgeStyle(
              badgeColor: AppColors.primary,
              padding: EdgeInsets.all(4),
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                _selected
                    ? Icons.shopping_cart_rounded
                    : Icons.shopping_cart_outlined,
                key: ValueKey(_selected),
                color: _selected ? AppColors.primary : AppColors.grey400,
                size: 24,
              ),
            ),
          ),
          const SizedBox(height: 3),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 10,
              fontWeight: _selected ? FontWeight.w600 : FontWeight.w400,
              color: _selected ? AppColors.primary : AppColors.grey400,
            ),
            child: const Text('Cart'),
          ),
        ],
      ),
    );
  }
}
