import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';
import '../../core/routing/app_router.dart';
import '../../core/theme/theme_provider.dart';
import '../../core/localization/locale_provider.dart';
import '../../core/utils/extensions.dart';
import '../../core/widgets/app_button.dart';
import 'profile_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(authUserProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: userAsync.when(
        data: (user) => user == null
            ? _UnauthenticatedView()
            : _AuthenticatedView(user: user),
        loading: () =>
            const Center(child: CircularProgressIndicator(color: AppColors.primary)),
        error: (e, _) => Center(child: Text(e.toString())),
      ),
    );
  }
}

class _AuthenticatedView extends ConsumerWidget {
  const _AuthenticatedView({required this.user});
  final dynamic user; // UserEntity

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale     = ref.watch(localeNotifierProvider);
    final isDark     = context.isDark;
    final isArabic   = locale.languageCode == 'ar';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _ProfileHeader(user: user)
              .animate()
              .fadeIn(duration: 400.ms)
              .slideY(begin: -0.05, end: 0),

          const SizedBox(height: 24),

          _SettingsGroup(
            title: 'Account',
            items: [
              _SettingItem(
                icon: Icons.person_outline_rounded,
                label: 'Edit Profile',
                onTap: () {},
              ),
              _SettingItem(
                icon: Icons.location_on_outlined,
                label: 'Saved Addresses',
                onTap: () {},
              ),
              _SettingItem(
                icon: Icons.receipt_long_outlined,
                label: 'My Orders',
                onTap: () => context.go(AppRoutes.orders),
              ),
            ],
          ).animate(delay: 100.ms).fadeIn(duration: 300.ms),

          const SizedBox(height: 16),

          _SettingsGroup(
            title: 'Preferences',
            items: [
              _SettingItem(
                icon: isDark
                    ? Icons.dark_mode_rounded
                    : Icons.light_mode_rounded,
                label: isDark ? 'Dark Mode' : 'Light Mode',
                trailing: Switch(
                  value: isDark,
                  onChanged: (_) => ref
                      .read(themeModeNotifierProvider.notifier)
                      .toggle(),
                  activeColor: AppColors.primary,
                ),
                onTap: () =>
                    ref.read(themeModeNotifierProvider.notifier).toggle(),
              ),

              _SettingItem(
                icon: Icons.language_rounded,
                label: isArabic ? 'العربية' : 'English',
                trailing: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    isArabic ? 'AR' : 'EN',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                onTap: () {
                  final notifier =
                      ref.read(localeNotifierProvider.notifier);
                  if (isArabic) {
                    notifier.switchToEnglish();
                  } else {
                    notifier.switchToArabic();
                  }
                },
              ),

              _SettingItem(
                icon: Icons.notifications_outlined,
                label: 'Notifications',
                onTap: () {},
              ),
            ],
          ).animate(delay: 200.ms).fadeIn(duration: 300.ms),

          const SizedBox(height: 16),

          _SettingsGroup(
            title: 'Support',
            items: [
              _SettingItem(
                icon: Icons.help_outline_rounded,
                label: 'Help & Support',
                onTap: () {},
              ),
              _SettingItem(
                icon: Icons.privacy_tip_outlined,
                label: 'Privacy Policy',
                onTap: () {},
              ),
              _SettingItem(
                icon: Icons.description_outlined,
                label: 'Terms & Conditions',
                onTap: () {},
              ),
            ],
          ).animate(delay: 300.ms).fadeIn(duration: 300.ms),

          const SizedBox(height: 24),

          _LogoutButton()
              .animate(delay: 400.ms)
              .fadeIn(duration: 300.ms),

          const SizedBox(height: 32),

          Text(
            'SwiftCart v1.0.0',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              color: AppColors.textTertiary,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.user});
  final dynamic user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color:
            context.isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: context.isDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryContainer,
            ),
            child: user.hasPhoto
                ? ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: user.photoUrl!,
                      fit: BoxFit.cover,
                    ),
                  )
                : Center(
                    child: Text(
                      user.firstName[0].toUpperCase(),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
          ),
          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.fullName,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: context.isDark
                        ? AppColors.textDarkPrimary
                        : AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user.email,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                if (user.hasPhone) ...[
                  const SizedBox(height: 4),
                  Text(
                    user.phoneNumber!,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),

          IconButton(
            icon: const Icon(Icons.edit_outlined, size: 20),
            color: AppColors.primary,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({required this.title, required this.items});
  final String title;
  final List<_SettingItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: context.isDark
                ? AppColors.darkSurface
                : AppColors.lightSurface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: context.isDark
                  ? AppColors.darkBorder
                  : AppColors.lightBorder,
            ),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(height: 1, indent: 52),
            itemBuilder: (_, i) => items[i],
          ),
        ),
      ],
    );
  }
}

class _SettingItem extends StatelessWidget {
  const _SettingItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.trailing,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.primaryContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.primary, size: 18),
      ),
      title: Text(
        label,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: context.isDark
              ? AppColors.textDarkPrimary
              : AppColors.textPrimary,
        ),
      ),
      trailing: trailing ??
          const Icon(Icons.arrow_forward_ios_rounded,
              size: 14, color: AppColors.grey400),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }
}

class _LogoutButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileNotifierProvider);

    ref.listen(profileNotifierProvider, (_, next) {
      if (next is AsyncData) context.go(AppRoutes.login);
    });

    return AppButton(
      label: 'Sign Out',
      onPressed: () => ref.read(profileNotifierProvider.notifier).signOut(),
      isLoading: state is AsyncLoading,
      variant: AppButtonVariant.outlined,
      icon: const Icon(Icons.logout_rounded),
    );
  }
}

class _UnauthenticatedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.person_off_outlined,
                size: 64, color: AppColors.grey400),
            const SizedBox(height: 16),
            const Text(
              'Not Signed In',
              style: TextStyle(fontFamily: 'Poppins',
                  fontSize: 22, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            const Text(
              'Please sign in to view your profile',
              style: TextStyle(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            AppButton(
              label: 'Sign In',
              onPressed: () => context.go(AppRoutes.login),
              fullWidth: false,
            ),
          ],
        ),
      ),
    );
  }
}