import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/extensions.dart';
import '../../core/widgets/error_view.dart';
import '../../core/widgets/product_card.dart';
import '../../core/widgets/shimmer_loading.dart';
import '../../domain/entities/category_entity.dart';
import '../cart/cart_provider.dart';
import 'categories_provider.dart';

class CategoriesScreen extends ConsumerStatefulWidget {
  const CategoriesScreen({super.key});

  @override
  ConsumerState<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends ConsumerState<CategoriesScreen> {
  final _searchCtrl  = TextEditingController();
  final _scrollCtrl  = ScrollController();
  String _sortBy     = 'newest';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(categoryProductsNotifierProvider.notifier).refresh();
    });

    _scrollCtrl.addListener(() {
      if (_scrollCtrl.position.pixels >=
          _scrollCtrl.position.maxScrollExtent - 200) {
        ref.read(categoryProductsNotifierProvider.notifier).loadMore();
      }
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(allCategoriesProvider);
    final filterState     = ref.watch(categoryProductsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: _SearchBar(
            controller: _searchCtrl,
            onChanged: (q) => ref
                .read(categoryProductsNotifierProvider.notifier)
                .search(q),
          ),
        ),
      ),
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () =>
            ref.read(categoryProductsNotifierProvider.notifier).refresh(),
        child: CustomScrollView(
          controller: _scrollCtrl,
          slivers: [
            SliverToBoxAdapter(
              child: categoriesAsync.when(
                data: (cats) => _CategoryChips(
                  categories: cats,
                  selectedId: filterState.selectedCategoryId,
                  onSelect: (cat) => ref
                      .read(categoryProductsNotifierProvider.notifier)
                      .selectCategory(cat),
                ),
                loading: () => const SizedBox(
                  height: 50,
                  child: Center(
                      child: CircularProgressIndicator(
                          color: AppColors.primary, strokeWidth: 2)),
                ),
                error: (_, __) => const SizedBox.shrink(),
              ),
            ),

            SliverToBoxAdapter(
              child: _SortBar(
                selected: _sortBy,
                onChanged: (s) {
                  setState(() => _sortBy = s);
                  ref
                      .read(categoryProductsNotifierProvider.notifier)
                      .setSortBy(s);
                },
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      filterState.selectedCategoryName ?? 'All Products',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: context.isDark
                            ? AppColors.textDarkPrimary
                            : AppColors.textPrimary,
                      ),
                    ),
                    if (!filterState.isLoading)
                      Text(
                        '${filterState.products.length} items',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                  ],
                ),
              ),
            ),

            if (filterState.errorMessage != null)
              SliverToBoxAdapter(
                child: ErrorView(
                  message: filterState.errorMessage!,
                  onRetry: () => ref
                      .read(categoryProductsNotifierProvider.notifier)
                      .refresh(),
                ),
              ),

            if (filterState.isLoading && filterState.products.isEmpty)
              SliverToBoxAdapter(child: _buildSkeletonGrid()),

            if (filterState.products.isEmpty &&
                !filterState.isLoading &&
                filterState.errorMessage == null)
              SliverToBoxAdapter(
                child: EmptyView(
                  title: 'No Products Found',
                  subtitle: 'Try adjusting your filters or search term',
                  action: () {
                    _searchCtrl.clear();
                    ref
                        .read(categoryProductsNotifierProvider.notifier)
                        .selectCategory(null);
                  },
                  actionLabel: 'Clear Filters',
                ),
              ),

            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (_, i) => ProductCard(
                    product: filterState.products[i],
                    onAddToCart: () => ref
                        .read(cartNotifierProvider.notifier)
                        .addToCart(filterState.products[i]),
                  ),
                  childCount: filterState.products.length,
                ),
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.72,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
              ),
            ),

            if (filterState.isLoading && filterState.products.isNotEmpty)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Center(
                    child: CircularProgressIndicator(
                        color: AppColors.primary, strokeWidth: 2),
                  ),
                ),
              ),

            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  Widget _buildSkeletonGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.72,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: 6,
        itemBuilder: (_, __) => const ProductCardShimmer(),
      ),
    );
  }
}


class _SearchBar extends StatelessWidget {
  const _SearchBar({required this.controller, required this.onChanged});
  final TextEditingController controller;
  final ValueChanged<String>  onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Search products…',
          prefixIcon: const Icon(Icons.search_rounded, color: AppColors.grey400),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear_rounded, size: 18),
                  onPressed: () {
                    controller.clear();
                    onChanged('');
                  },
                )
              : null,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        ),
      ),
    );
  }
}


class _CategoryChips extends StatelessWidget {
  const _CategoryChips({
    required this.categories,
    required this.selectedId,
    required this.onSelect,
  });
  final List<CategoryEntity> categories;
  final String?              selectedId;
  final ValueChanged<CategoryEntity?> onSelect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _Chip(
            label: 'All',
            icon: '🛍️',
            isSelected: selectedId == null,
            onTap: () => onSelect(null),
          ),
          const SizedBox(width: 8),
          ...categories.asMap().entries.map((e) {
            final cat = e.value;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: _Chip(
                label: cat.name,
                icon: cat.icon,
                isSelected: selectedId == cat.id,
                onTap: () => onSelect(cat),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });
  final String label, icon;
  final bool   isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary
              : (context.isDark
                  ? AppColors.darkSurfaceVariant
                  : AppColors.lightSurfaceVariant),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : (context.isDark ? AppColors.darkBorder : AppColors.lightBorder),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(icon, style: const TextStyle(fontSize: 14)),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected
                    ? Colors.white
                    : (context.isDark
                        ? AppColors.textDarkPrimary
                        : AppColors.textPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class _SortBar extends StatelessWidget {
  const _SortBar({required this.selected, required this.onChanged});
  final String selected;
  final ValueChanged<String> onChanged;

  static const _options = {
    'newest':     'Newest',
    'price_asc':  'Price ↑',
    'price_desc': 'Price ↓',
    'rating':     'Rating',
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Row(
        children: [
          const Icon(Icons.sort_rounded,
              color: AppColors.grey400, size: 18),
          const SizedBox(width: 8),
          const Text(
            'Sort:',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _options.entries.map((e) {
                  final isSelected = selected == e.key;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () => onChanged(e.key),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryContainer
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : (context.isDark
                                    ? AppColors.darkBorder
                                    : AppColors.lightBorder),
                          ),
                        ),
                        child: Text(
                          e.value,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w400,
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}