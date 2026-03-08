// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allCategoriesHash() => r'61836d8e9fbffa838d9b7ed60aa9288aa9b461e2';

/// See also [allCategories].
@ProviderFor(allCategories)
final allCategoriesProvider =
    AutoDisposeFutureProvider<List<CategoryEntity>>.internal(
  allCategories,
  name: r'allCategoriesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$allCategoriesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AllCategoriesRef = AutoDisposeFutureProviderRef<List<CategoryEntity>>;
String _$categoryProductsNotifierHash() =>
    r'e92eb3b5580b38d4dd2da750e208c76a62c40c5b';

/// See also [CategoryProductsNotifier].
@ProviderFor(CategoryProductsNotifier)
final categoryProductsNotifierProvider = AutoDisposeNotifierProvider<
    CategoryProductsNotifier, ProductFilterState>.internal(
  CategoryProductsNotifier.new,
  name: r'categoryProductsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$categoryProductsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CategoryProductsNotifier = AutoDisposeNotifier<ProductFilterState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
