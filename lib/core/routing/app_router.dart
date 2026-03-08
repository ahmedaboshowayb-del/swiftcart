import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../presentation/splash/splash_screen.dart';
import '../../presentation/auth/login/login_screen.dart';
import '../../presentation/auth/register/register_screen.dart';
import '../../presentation/auth/otp/otp_screen.dart';
import '../../presentation/home/home_screen.dart';
import '../../presentation/categories/categories_screen.dart';
import '../../presentation/product/product_detail_screen.dart';
import '../../presentation/cart/cart_screen.dart';
import '../../presentation/cart/checkout_screen.dart';
import '../../presentation/orders/orders_screen.dart';
import '../../presentation/orders/order_detail_screen.dart';
import '../../presentation/orders/order_success_screen.dart';
import '../../presentation/maps/map_picker_screen.dart';
import '../../presentation/profile/profile_screen.dart';
import '../widgets/scaffold_with_nav_bar.dart';

part 'app_router.g.dart';

abstract final class AppRoutes {
  static const String splash        = '/';
  static const String login         = '/login';
  static const String register      = '/register';
  static const String otp           = '/otp';
  static const String home          = '/home';
  static const String categories    = '/categories';
  static const String cart          = '/cart';
  static const String orders        = '/orders';
  static const String profile       = '/profile';
  static const String productDetail = '/product/:id';
  static const String checkout      = '/checkout';
  static const String orderDetail   = '/order/:id';
  static const String orderSuccess  = '/order-success';
  static const String mapPicker     = '/map-picker';




  static String productPath(String id) => '/product/$id';
  static String orderPath(String id)   => '/order/$id';
    static String orderDetailPath(String orderId) => '/orders/$orderId';

}

@riverpod
GoRouter appRouter(AppRouterRef ref) {

  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,

    redirect: (context, state) {
      return null;
    },

    routes: [
      GoRoute(
        path: AppRoutes.splash,
        pageBuilder: (_, state) => _fade(state, const SplashScreen()),
      ),

      GoRoute(
        path: AppRoutes.login,
        pageBuilder: (_, state) => _fade(state, const LoginScreen()),
      ),
      GoRoute(
        path: AppRoutes.register,
        pageBuilder: (_, state) => _slide(state, const RegisterScreen()),
      ),
      GoRoute(
        path: AppRoutes.otp,
        pageBuilder: (_, state) => _slide(
          state,
          OtpScreen(
            phoneNumber:    state.uri.queryParameters['phone'] ?? '',
            verificationId: state.uri.queryParameters['vid']   ?? '',
          ),
        ),
      ),
GoRoute(
  path: '/orders',
  builder: (_, __) => const OrdersScreen(),
  routes: [
    GoRoute(
      path: ':orderId',                    
      builder: (context, state) {
        final orderId = state.pathParameters['orderId']!;
        return OrderDetailScreen(orderId: orderId);
      },
    ),
  ],
),
      StatefulShellRoute.indexedStack(
        builder: (_, __, shell) => ScaffoldWithNavBar(navigationShell: shell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(path: AppRoutes.home,       builder: (_, __) => const HomeScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: AppRoutes.categories, builder: (_, __) => const CategoriesScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: AppRoutes.cart,       builder: (_, __) => const CartScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: AppRoutes.orders,     builder: (_, __) => const OrdersScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: AppRoutes.profile,    builder: (_, __) => const ProfileScreen()),
          ]),
        ],
      ),

      GoRoute(
        path: AppRoutes.productDetail,
        pageBuilder: (_, state) => _slide(
          state,
          ProductDetailScreen(productId: state.pathParameters['id']!),
        ),
      ),

      GoRoute(
        path: AppRoutes.checkout,
        pageBuilder: (_, state) => _slide(state, const CheckoutScreen()),
      ),
      GoRoute(
        path: AppRoutes.orderSuccess,
        pageBuilder: (_, state) => _fade(state, const OrderSuccessScreen()),
      ),
      GoRoute(
        path: AppRoutes.orderDetail,
        pageBuilder: (_, state) => _slide(
          state,
          OrderDetailScreen(orderId: state.pathParameters['id']!),
        ),
      ),

      GoRoute(
        path: AppRoutes.mapPicker,
        pageBuilder: (_, state) => _slide(state, const MapPickerScreen()),
      ),
    ],

    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Page not found: ${state.error}')),
    ),
  );
}

CustomTransitionPage<void> _slide(GoRouterState state, Widget child) =>
    CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 350),
      transitionsBuilder: (context, animation, _, child) => SlideTransition(
        position: Tween(begin: const Offset(1, 0), end: Offset.zero)
            .chain(CurveTween(curve: Curves.easeOutCubic))
            .animate(animation),
        child: child,
      ),
    );

CustomTransitionPage<void> _fade(GoRouterState state, Widget child) =>
    CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, _, child) =>
          FadeTransition(opacity: animation, child: child),
    );