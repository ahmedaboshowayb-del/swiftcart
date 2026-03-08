// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userOrdersHash() => r'92fc7f6641a1dda0412fb05b34e607da802ab226';

/// See also [userOrders].
@ProviderFor(userOrders)
final userOrdersProvider =
    AutoDisposeFutureProvider<List<OrderEntity>>.internal(
  userOrders,
  name: r'userOrdersProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userOrdersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserOrdersRef = AutoDisposeFutureProviderRef<List<OrderEntity>>;
String _$orderDetailHash() => r'a0ad93776144f5b59af763d3785b1eb180b172c7';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [orderDetail].
@ProviderFor(orderDetail)
const orderDetailProvider = OrderDetailFamily();

/// See also [orderDetail].
class OrderDetailFamily extends Family<AsyncValue<OrderEntity>> {
  /// See also [orderDetail].
  const OrderDetailFamily();

  /// See also [orderDetail].
  OrderDetailProvider call(
    String orderId,
  ) {
    return OrderDetailProvider(
      orderId,
    );
  }

  @override
  OrderDetailProvider getProviderOverride(
    covariant OrderDetailProvider provider,
  ) {
    return call(
      provider.orderId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'orderDetailProvider';
}

/// See also [orderDetail].
class OrderDetailProvider extends AutoDisposeFutureProvider<OrderEntity> {
  /// See also [orderDetail].
  OrderDetailProvider(
    String orderId,
  ) : this._internal(
          (ref) => orderDetail(
            ref as OrderDetailRef,
            orderId,
          ),
          from: orderDetailProvider,
          name: r'orderDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$orderDetailHash,
          dependencies: OrderDetailFamily._dependencies,
          allTransitiveDependencies:
              OrderDetailFamily._allTransitiveDependencies,
          orderId: orderId,
        );

  OrderDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.orderId,
  }) : super.internal();

  final String orderId;

  @override
  Override overrideWith(
    FutureOr<OrderEntity> Function(OrderDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OrderDetailProvider._internal(
        (ref) => create(ref as OrderDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        orderId: orderId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<OrderEntity> createElement() {
    return _OrderDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OrderDetailProvider && other.orderId == orderId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, orderId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin OrderDetailRef on AutoDisposeFutureProviderRef<OrderEntity> {
  /// The parameter `orderId` of this provider.
  String get orderId;
}

class _OrderDetailProviderElement
    extends AutoDisposeFutureProviderElement<OrderEntity> with OrderDetailRef {
  _OrderDetailProviderElement(super.provider);

  @override
  String get orderId => (origin as OrderDetailProvider).orderId;
}

String _$orderStatusHash() => r'58869c40a863eda5e1f0198702d853aa79a00af1';

/// See also [orderStatus].
@ProviderFor(orderStatus)
const orderStatusProvider = OrderStatusFamily();

/// See also [orderStatus].
class OrderStatusFamily extends Family<AsyncValue<OrderEntity>> {
  /// See also [orderStatus].
  const OrderStatusFamily();

  /// See also [orderStatus].
  OrderStatusProvider call(
    String orderId,
  ) {
    return OrderStatusProvider(
      orderId,
    );
  }

  @override
  OrderStatusProvider getProviderOverride(
    covariant OrderStatusProvider provider,
  ) {
    return call(
      provider.orderId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'orderStatusProvider';
}

/// See also [orderStatus].
class OrderStatusProvider extends AutoDisposeStreamProvider<OrderEntity> {
  /// See also [orderStatus].
  OrderStatusProvider(
    String orderId,
  ) : this._internal(
          (ref) => orderStatus(
            ref as OrderStatusRef,
            orderId,
          ),
          from: orderStatusProvider,
          name: r'orderStatusProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$orderStatusHash,
          dependencies: OrderStatusFamily._dependencies,
          allTransitiveDependencies:
              OrderStatusFamily._allTransitiveDependencies,
          orderId: orderId,
        );

  OrderStatusProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.orderId,
  }) : super.internal();

  final String orderId;

  @override
  Override overrideWith(
    Stream<OrderEntity> Function(OrderStatusRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OrderStatusProvider._internal(
        (ref) => create(ref as OrderStatusRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        orderId: orderId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<OrderEntity> createElement() {
    return _OrderStatusProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OrderStatusProvider && other.orderId == orderId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, orderId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin OrderStatusRef on AutoDisposeStreamProviderRef<OrderEntity> {
  /// The parameter `orderId` of this provider.
  String get orderId;
}

class _OrderStatusProviderElement
    extends AutoDisposeStreamProviderElement<OrderEntity> with OrderStatusRef {
  _OrderStatusProviderElement(super.provider);

  @override
  String get orderId => (origin as OrderStatusProvider).orderId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
