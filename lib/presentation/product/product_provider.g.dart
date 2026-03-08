// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productDetailHash() => r'0ff296209233cd755cb87114b24920df7fa716e6';

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

/// See also [productDetail].
@ProviderFor(productDetail)
const productDetailProvider = ProductDetailFamily();

/// See also [productDetail].
class ProductDetailFamily extends Family<AsyncValue<ProductEntity>> {
  /// See also [productDetail].
  const ProductDetailFamily();

  /// See also [productDetail].
  ProductDetailProvider call(
    String id,
  ) {
    return ProductDetailProvider(
      id,
    );
  }

  @override
  ProductDetailProvider getProviderOverride(
    covariant ProductDetailProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'productDetailProvider';
}

/// See also [productDetail].
class ProductDetailProvider extends AutoDisposeFutureProvider<ProductEntity> {
  /// See also [productDetail].
  ProductDetailProvider(
    String id,
  ) : this._internal(
          (ref) => productDetail(
            ref as ProductDetailRef,
            id,
          ),
          from: productDetailProvider,
          name: r'productDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productDetailHash,
          dependencies: ProductDetailFamily._dependencies,
          allTransitiveDependencies:
              ProductDetailFamily._allTransitiveDependencies,
          id: id,
        );

  ProductDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<ProductEntity> Function(ProductDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProductDetailProvider._internal(
        (ref) => create(ref as ProductDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ProductEntity> createElement() {
    return _ProductDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductDetailProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ProductDetailRef on AutoDisposeFutureProviderRef<ProductEntity> {
  /// The parameter `id` of this provider.
  String get id;
}

class _ProductDetailProviderElement
    extends AutoDisposeFutureProviderElement<ProductEntity>
    with ProductDetailRef {
  _ProductDetailProviderElement(super.provider);

  @override
  String get id => (origin as ProductDetailProvider).id;
}

String _$similarProductsHash() => r'b902a6087cd6a95972ec9466c38164d6fa119202';

/// See also [similarProducts].
@ProviderFor(similarProducts)
const similarProductsProvider = SimilarProductsFamily();

/// See also [similarProducts].
class SimilarProductsFamily extends Family<AsyncValue<List<ProductEntity>>> {
  /// See also [similarProducts].
  const SimilarProductsFamily();

  /// See also [similarProducts].
  SimilarProductsProvider call(
    String id,
    String categoryId,
  ) {
    return SimilarProductsProvider(
      id,
      categoryId,
    );
  }

  @override
  SimilarProductsProvider getProviderOverride(
    covariant SimilarProductsProvider provider,
  ) {
    return call(
      provider.id,
      provider.categoryId,
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
  String? get name => r'similarProductsProvider';
}

/// See also [similarProducts].
class SimilarProductsProvider
    extends AutoDisposeFutureProvider<List<ProductEntity>> {
  /// See also [similarProducts].
  SimilarProductsProvider(
    String id,
    String categoryId,
  ) : this._internal(
          (ref) => similarProducts(
            ref as SimilarProductsRef,
            id,
            categoryId,
          ),
          from: similarProductsProvider,
          name: r'similarProductsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$similarProductsHash,
          dependencies: SimilarProductsFamily._dependencies,
          allTransitiveDependencies:
              SimilarProductsFamily._allTransitiveDependencies,
          id: id,
          categoryId: categoryId,
        );

  SimilarProductsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
    required this.categoryId,
  }) : super.internal();

  final String id;
  final String categoryId;

  @override
  Override overrideWith(
    FutureOr<List<ProductEntity>> Function(SimilarProductsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SimilarProductsProvider._internal(
        (ref) => create(ref as SimilarProductsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
        categoryId: categoryId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ProductEntity>> createElement() {
    return _SimilarProductsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SimilarProductsProvider &&
        other.id == id &&
        other.categoryId == categoryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, categoryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SimilarProductsRef on AutoDisposeFutureProviderRef<List<ProductEntity>> {
  /// The parameter `id` of this provider.
  String get id;

  /// The parameter `categoryId` of this provider.
  String get categoryId;
}

class _SimilarProductsProviderElement
    extends AutoDisposeFutureProviderElement<List<ProductEntity>>
    with SimilarProductsRef {
  _SimilarProductsProviderElement(super.provider);

  @override
  String get id => (origin as SimilarProductsProvider).id;
  @override
  String get categoryId => (origin as SimilarProductsProvider).categoryId;
}

String _$productImageIndexHash() => r'd1fd5d1b5768481ecd1b972ac945b5e59a414ea7';

/// See also [ProductImageIndex].
@ProviderFor(ProductImageIndex)
final productImageIndexProvider =
    AutoDisposeNotifierProvider<ProductImageIndex, int>.internal(
  ProductImageIndex.new,
  name: r'productImageIndexProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$productImageIndexHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ProductImageIndex = AutoDisposeNotifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
