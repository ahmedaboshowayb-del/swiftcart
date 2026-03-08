import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';
import '../../core/routing/app_router.dart';
import '../../core/utils/extensions.dart';
import '../../core/widgets/error_view.dart';
import '../../core/widgets/product_card.dart';
import '../../core/widgets/shimmer_loading.dart';
import '../../domain/entities/category_entity.dart';
import '../cart/cart_provider.dart';
import 'home_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _scroll = ScrollController();

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    ref.invalidate(featuredProductsProvider);
    ref.invalidate(newArrivalsProvider);
    ref.invalidate(homeCategoriesProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          context.isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: _onRefresh,
        child: CustomScrollView(
          controller: _scroll,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: const [
            _HomeAppBar(),
            _SearchBar(),
            _BannerCarousel(),
            _CategoriesSection(),
            _FeaturedSection(),
            _NewArrivalsSection(),
            SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }
}


class _HomeAppBar extends ConsumerWidget {
  const _HomeAppBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverAppBar(
      floating: true,
      snap: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor:
          context.isDark ? AppColors.darkBackground : AppColors.lightBackground,
      automaticallyImplyLeading: false,
      titleSpacing: 16,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Deliver to',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
          Row(
            children: [
              const Icon(Icons.location_on_rounded,
                  color: AppColors.primary, size: 16),
              const SizedBox(width: 4),
              Text(
                'Riyadh, Saudi Arabia',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: context.isDark
                      ? AppColors.textDarkPrimary
                      : AppColors.textPrimary,
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 18,
                color: context.isDark
                    ? AppColors.textDarkPrimary
                    : AppColors.textPrimary,
              ),
            ],
          ),
        ],
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 8),
          child: IconButton(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  Icons.notifications_outlined,
                  color: context.isDark
                      ? AppColors.textDarkPrimary
                      : AppColors.textPrimary,
                ),
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}


class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: GestureDetector(
          onTap: () {},
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: context.isDark
                  ? AppColors.darkSurfaceVariant
                  : AppColors.lightSurfaceVariant,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: context.isDark
                    ? AppColors.darkBorder
                    : AppColors.lightBorder,
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.search_rounded,
                    color: AppColors.grey400, size: 20),
                const SizedBox(width: 10),
                Text(
                  'Search products, brands…',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: AppColors.grey400,
                  ),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.tune_rounded,
                      color: AppColors.primary, size: 16),
                ),
              ],
            ),
          )
              .animate()
              .fadeIn(duration: 400.ms)
              .slideY(begin: -0.1, end: 0),
        ),
      ),
    );
  }
}

class _BannerCarousel extends StatefulWidget {
  const _BannerCarousel();

  @override
  State<_BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<_BannerCarousel> {
  final _controller = PageController(viewportFraction: 0.92);
  int _page = 0;

  static const _banners = [
    _BannerData(
      title: 'Flash Sale Today!',
      subtitle: 'Up to 50% off on electronics',
      emoji: '⚡',
      colors: [Color(0xFFFF6B35), Color(0xFFFF8C5A)],
    ),
    _BannerData(
      title: 'Free Delivery',
      subtitle: 'On all orders above SAR 200',
      emoji: '🚚',
      colors: [Color(0xFF1A1A2E), Color(0xFF2D2D4E)],
    ),
    _BannerData(
      title: 'New Arrivals',
      subtitle: 'Explore the latest collections',
      emoji: '✨',
      colors: [Color(0xFF00A878), Color(0xFF00C896)],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _scheduleAutoScroll();
  }

  void _scheduleAutoScroll() {
    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      final next = (_page + 1) % _banners.length;
      _controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
      _scheduleAutoScroll();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          const SizedBox(height: 16),
          SizedBox(
            height: 160,
            child: PageView.builder(
              controller: _controller,
              onPageChanged: (i) => setState(() => _page = i),
              itemCount: _banners.length,
              itemBuilder: (_, i) => _BannerCard(data: _banners[i]),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _banners.length,
              (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: i == _page ? 20 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color:
                      i == _page ? AppColors.primary : AppColors.grey300,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BannerData {
  const _BannerData({
    required this.title,
    required this.subtitle,
    required this.emoji,
    required this.colors,
  });
  final String title;
  final String subtitle;
  final String emoji;
  final List<Color> colors;
}



class _BannerCard extends StatelessWidget {
  const _BannerCard({required this.data});
  final _BannerData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: data.colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -8,
            bottom: -8,
            child: Text(
              data.emoji,
              style: const TextStyle(fontSize: 75),  
            ),
          ),

          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 14, 90, 10), 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'LIMITED TIME',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 9,          
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),  
                  Text(
                    data.title,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 19,           
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.2,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),   

                  Text(
                    data.subtitle,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,            
                      color: Colors.white70,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10), 

                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 5), 
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Shop Now →',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11,        
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _CategoriesSection extends ConsumerWidget {
  const _CategoriesSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(homeCategoriesProvider);

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(
            title: 'Categories',
            onSeeAll: () => context.go(AppRoutes.categories),
          ),
          async.when(
            data: (categories) => SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: categories.take(8).length,
                separatorBuilder: (_, __) => const SizedBox(width: 14),
                itemBuilder: (_, i) =>
                    _CategoryChip(category: categories[i], index: i),
              ),
            ),
            loading: () => SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 6,
                separatorBuilder: (_, __) => const SizedBox(width: 14),
                itemBuilder: (_, __) => Column(children: [
                  ShimmerBox(width: 60, height: 60, radius: 16),
                  const SizedBox(height: 6),
                  ShimmerBox(width: 50, height: 10, radius: 4),
                ]),
              ),
            ),
            error: (e, _) => ErrorView(
              message: 'Could not load categories',
              compact: true,
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({required this.category, required this.index});
  final CategoryEntity category;
  final int index;

  static const _bgColors = [
    Color(0xFFFFEDE6),
    Color(0xFFE8F1FF),
    Color(0xFFE6FBF6),
    Color(0xFFFFF8E6),
    Color(0xFFF3E8FF),
    Color(0xFFFFE8F0),
    Color(0xFFE8FFF3),
    Color(0xFFFFF3E8),
  ];

  @override
  Widget build(BuildContext context) {
    final bg = _bgColors[index % _bgColors.length];

    return GestureDetector(
      onTap: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                category.icon.isNotEmpty ? category.icon : '🛍️',
                style: const TextStyle(fontSize: 28),
              ),
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: 64,
            child: Text(
              category.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: context.isDark
                    ? AppColors.textDarkPrimary
                    : AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    )
        .animate(delay: (index * 60).ms)
        .fadeIn(duration: 300.ms)
        .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1));
  }
}


class _FeaturedSection extends ConsumerWidget {
  const _FeaturedSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(featuredProductsProvider);

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeader(title: 'Featured Products'),
          async.when(
            data: (products) => SizedBox(
              height: 258,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: products.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (_, i) => ProductCard(
                  product: products[i],
                  onAddToCart: () => ref
                      .read(cartNotifierProvider.notifier)
                      .addToCart(products[i]),
                ),
              ),
            ),
            loading: () => const ProductRowShimmer(),
            error: (e, _) =>
                ErrorView(message: 'Could not load products', compact: true),
          ),
        ],
      ),
    );
  }
}


class _NewArrivalsSection extends ConsumerWidget {
  const _NewArrivalsSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(newArrivalsProvider);

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeader(title: 'New Arrivals'),
          async.when(
            data: (products) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.72,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: products.take(6).length,
                itemBuilder: (_, i) => ProductCard(
                  product: products[i],
                  onAddToCart: () => ref
                      .read(cartNotifierProvider.notifier)
                      .addToCart(products[i]),
                ),
              ),
            ),
            loading: () => const ProductRowShimmer(count: 4),
            error: (e, _) =>
                ErrorView(message: 'Could not load products', compact: true),
          ),
        ],
      ),
    );
  }
}


class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, this.onSeeAll});
  final String title;
  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 22, 16, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: context.isDark
                  ? AppColors.textDarkPrimary
                  : AppColors.textPrimary,
            ),
          ),
          if (onSeeAll != null)
            GestureDetector(
              onTap: onSeeAll,
              child: const Text(
                'See All →',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}