// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cartItemsHash() => r'7f7a0ae72afb52c3fd54fa09e5cc643c7b7644a7';

/// See also [cartItems].
@ProviderFor(cartItems)
final cartItemsProvider =
    AutoDisposeStreamProvider<List<CartItemEntity>>.internal(
  cartItems,
  name: r'cartItemsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$cartItemsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CartItemsRef = AutoDisposeStreamProviderRef<List<CartItemEntity>>;
String _$cartItemCountHash() => r'5ffaf4e4f3132b2907548009cec4ffda618ac51c';

/// See also [cartItemCount].
@ProviderFor(cartItemCount)
final cartItemCountProvider = AutoDisposeProvider<int>.internal(
  cartItemCount,
  name: r'cartItemCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cartItemCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CartItemCountRef = AutoDisposeProviderRef<int>;
String _$cartSubtotalHash() => r'318bf611ff4bcfbf84307dadb8f7adeb68d39813';

/// See also [cartSubtotal].
@ProviderFor(cartSubtotal)
final cartSubtotalProvider = AutoDisposeProvider<double>.internal(
  cartSubtotal,
  name: r'cartSubtotalProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$cartSubtotalHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CartSubtotalRef = AutoDisposeProviderRef<double>;
String _$deliveryFeeHash() => r'f528cb26cb7b8751f208827351999c40e9f532ea';

/// See also [deliveryFee].
@ProviderFor(deliveryFee)
final deliveryFeeProvider = AutoDisposeProvider<double>.internal(
  deliveryFee,
  name: r'deliveryFeeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$deliveryFeeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DeliveryFeeRef = AutoDisposeProviderRef<double>;
String _$cartTotalHash() => r'41c7a91bc04be6b5702da7230efa861d1812c2f8';

/// See also [cartTotal].
@ProviderFor(cartTotal)
final cartTotalProvider = AutoDisposeProvider<double>.internal(
  cartTotal,
  name: r'cartTotalProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$cartTotalHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CartTotalRef = AutoDisposeProviderRef<double>;
String _$cartNotifierHash() => r'af4a0ca9e9eca8e7b6f4d5d016d298c64ce9559d';

/// See also [CartNotifier].
@ProviderFor(CartNotifier)
final cartNotifierProvider =
    AutoDisposeNotifierProvider<CartNotifier, AsyncValue<void>>.internal(
  CartNotifier.new,
  name: r'cartNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$cartNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CartNotifier = AutoDisposeNotifier<AsyncValue<void>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
