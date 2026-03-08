abstract final class AppConstants {
  static const String appName    = 'SwiftCart';
  static const String appVersion = '1.0.0';

  static const String usersCollection      = 'users';
  static const String productsCollection   = 'products';
  static const String categoriesCollection = 'categories';
  static const String ordersCollection     = 'orders';
  static const String bannersCollection    = 'banners';
  static const String reviewsCollection    = 'reviews';

  static const String cartBox     = 'cart_box';
  static const String userBox     = 'user_box';
  static const String settingsBox = 'settings_box';

  static const String themeKey       = 'theme_mode';
  static const String localeKey      = 'locale';
  static const String onboardingKey  = 'onboarding_done';

  static const int defaultPageSize  = 20;
  static const int searchDebounceMs = 500;

  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  static const double paddingXS  = 4.0;
  static const double paddingSM  = 8.0;
  static const double paddingMD  = 16.0;
  static const double paddingLG  = 24.0;
  static const double paddingXL  = 32.0;
  static const double paddingXXL = 48.0;

  static const double radiusSM  = 8.0;
  static const double radiusMD  = 12.0;
  static const double radiusLG  = 16.0;
  static const double radiusXL  = 20.0;
  static const double radiusXXL = 28.0;
  static const double radiusFull = 100.0;

  static const double bottomNavHeight  = 64.0;
  static const double appBarHeight     = 56.0;
  static const double buttonHeightLG   = 54.0;
  static const double buttonHeightMD   = 46.0;
  static const double buttonHeightSM   = 38.0;
  static const double productCardWidth = 170.0;
  static const double bannerHeight     = 160.0;
  static const double categorySize     = 60.0;

  static const Duration durationFast   = Duration(milliseconds: 150);
  static const Duration durationNormal = Duration(milliseconds: 300);
  static const Duration durationSlow   = Duration(milliseconds: 500);
  static const Duration durationPage   = Duration(milliseconds: 350);

  static const double defaultMapZoom = 15.0;
  static const double defaultLat     = 24.7136;  
  static const double defaultLng     = 46.6753;

  static const String statusPreparing = 'preparing';
  static const String statusOnTheWay  = 'on_the_way';
  static const String statusDelivered = 'delivered';
  static const String statusCancelled = 'cancelled';

  static const String paymentCash   = 'cash';
  static const String paymentCard   = 'card';
  static const String paymentWallet = 'wallet';

  static const double deliveryFeeDefault  = 15.0;
  static const double freeDeliveryAbove   = 200.0;

  static const String profileImagesPath = 'users/profile_images';
  static const String productImagesPath = 'products/images';

  static const String localeEn = 'en';
  static const String localeAr = 'ar';


}