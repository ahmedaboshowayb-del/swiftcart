import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/category_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../../data/repositories/category_repository_impl.dart';
import '../../data/repositories/product_repository_impl.dart';

part 'categories_provider.freezed.dart';
part 'categories_provider.g.dart';

@riverpod
Future<List<CategoryEntity>> allCategories(AllCategoriesRef ref) async {
  final result = await ref.watch(categoryRepositoryProvider).getCategories();
  return result.fold(
    (f) => throw Exception(f.userMessage),
    (c) => c,
  );
}

@freezed
class ProductFilterState with _$ProductFilterState {
  const factory ProductFilterState({
    String?  selectedCategoryId,
    String?  selectedCategoryName,
    String?  searchQuery,
    double?  minPrice,
    double?  maxPrice,
    double?  minRating,
    @Default('newest') String sortBy,
    @Default([]) List<ProductEntity> products,
    @Default(false) bool isLoading,
    @Default(false) bool hasMore,
    @Default(1)     int  currentPage,
    String?  errorMessage,
  }) = _ProductFilterState;
}

@riverpod
class CategoryProductsNotifier extends _$CategoryProductsNotifier {
  @override
  ProductFilterState build() => const ProductFilterState();

  Future<void> selectCategory(CategoryEntity? cat) async {
    state = ProductFilterState(
      selectedCategoryId:   cat?.id,
      selectedCategoryName: cat?.name,
      sortBy: state.sortBy,
    );
    await _fetchProducts();
  }

  Future<void> search(String query) async {
    state = state.copyWith(
      searchQuery: query.isEmpty ? null : query,
      currentPage: 1,
      products: [],
    );
    await _fetchProducts();
  }

  Future<void> setSortBy(String sort) async {
    state = state.copyWith(sortBy: sort, currentPage: 1, products: []);
    await _fetchProducts();
  }

  Future<void> setMinRating(double? rating) async {
    state = state.copyWith(minRating: rating, currentPage: 1, products: []);
    await _fetchProducts();
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoading) return;
    state = state.copyWith(currentPage: state.currentPage + 1);
    await _fetchProducts(append: true);
  }

  Future<void> refresh() async {
    state = state.copyWith(currentPage: 1, products: []);
    await _fetchProducts();
  }

  Future<void> _fetchProducts({bool append = false}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await ref.read(productRepositoryProvider).getProducts(
          categoryId:  state.selectedCategoryId,
          searchQuery: state.searchQuery,
          minPrice:    state.minPrice,
          maxPrice:    state.maxPrice,
          minRating:   state.minRating,
          sortBy:      state.sortBy,
          page:        state.currentPage,
          limit:       20,
        );

    state = result.fold(
      (f) => state.copyWith(isLoading: false, errorMessage: f.userMessage),
      (products) => state.copyWith(
        isLoading: false,
        products: append ? [...state.products, ...products] : products,
        hasMore: products.length == 20,
      ),
    );
  }
}