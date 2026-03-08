import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async =>
      AppLocalizations(locale);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

class AppLocalizations {
  AppLocalizations(this.locale);
  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    final instance =
        Localizations.of<AppLocalizations>(context, AppLocalizations);
    assert(
      instance != null,
      'AppLocalizations not found. Did you add it to localizationsDelegates?',
    );
    return instance!;
  }

  static const delegate = AppLocalizationsDelegate();

  static const Map<String, Map<String, String>> _strings = {
    'en': {
      'appName':          'SwiftCart',
      'ok':               'OK',
      'cancel':           'Cancel',
      'save':             'Save',
      'delete':           'Delete',
      'edit':             'Edit',
      'retry':            'Retry',
      'loading':          'Loading…',
      'noData':           'No data found',
      'error':            'Something went wrong',
      'noInternet':       'No internet connection',
      'search':           'Search products, brands…',
      'filter':           'Filter',
      'seeAll':           'See All',
      'done':             'Done',

      'home':             'Home',
      'categories':       'Categories',
      'cart':             'Cart',
      'orders':           'Orders',
      'profile':          'Profile',

      'login':            'Login',
      'register':         'Register',
      'logout':           'Logout',
      'email':            'Email',
      'password':         'Password',
      'confirmPassword':  'Confirm Password',
      'fullName':         'Full Name',
      'phoneNumber':      'Phone Number',
      'forgotPassword':   'Forgot Password?',
      'noAccount':        "Don't have an account? ",
      'haveAccount':      'Already have an account? ',
      'signInWithGoogle': 'Continue with Google',
      'signInWithPhone':  'Continue with Phone',
      'verify':           'Verify',
      'resendCode':       'Resend Code',

      'deliverTo':        'Deliver to',
      'featuredProducts': 'Featured Products',
      'newArrivals':      'New Arrivals',
      'specialOffers':    'Special Offers',

      'addToCart':        'Add to Cart',
      'buyNow':           'Buy Now',
      'productDetails':   'Product Details',
      'reviews':          'Reviews',
      'inStock':          'In Stock',
      'outOfStock':       'Out of Stock',
      'quantity':         'Quantity',
      'relatedProducts':  'You May Also Like',
      'brand':            'Brand',

      'myCart':           'My Cart',
      'emptyCart':        'Your cart is empty',
      'subtotal':         'Subtotal',
      'deliveryFee':      'Delivery Fee',
      'total':            'Total',
      'checkout':         'Checkout',
      'promoCode':        'Promo Code',
      'apply':            'Apply',

      'myOrders':         'My Orders',
      'orderDetails':     'Order Details',
      'placeOrder':       'Place Order',
      'orderPlaced':      'Order Placed!',
      'trackOrder':       'Track Order',
      'statusPreparing':  'Preparing',
      'statusOnTheWay':   'On the Way',
      'statusDelivered':  'Delivered',
      'statusCancelled':  'Cancelled',

      'deliveryAddress':  'Delivery Address',
      'addAddress':       'Add Address',
      'chooseOnMap':      'Choose on Map',
      'paymentMethod':    'Payment Method',
      'orderSummary':     'Order Summary',
      'cashOnDelivery':   'Cash on Delivery',
      'creditCard':       'Credit / Debit Card',
      'digitalWallet':    'Digital Wallet',

      'settings':         'Settings',
      'language':         'Language',
      'darkMode':         'Dark Mode',
      'lightMode':        'Light Mode',
      'notifications':    'Notifications',
      'helpSupport':      'Help & Support',
      'privacyPolicy':    'Privacy Policy',
      'termsConditions':  'Terms & Conditions',
      'english':          'English',
      'arabic':           'Arabic',

      'fieldRequired':     'This field is required',
      'invalidEmail':      'Please enter a valid email',
      'passwordTooShort':  'Password must be at least 8 characters',
      'passwordsNotMatch': 'Passwords do not match',
      'invalidPhone':      'Please enter a valid phone number',
    },
    'ar': {
      'appName':          'سويفت كارت',
      'ok':               'موافق',
      'cancel':           'إلغاء',
      'save':             'حفظ',
      'delete':           'حذف',
      'edit':             'تعديل',
      'retry':            'إعادة المحاولة',
      'loading':          'جاري التحميل…',
      'noData':           'لا توجد بيانات',
      'error':            'حدث خطأ ما',
      'noInternet':       'لا يوجد اتصال بالإنترنت',
      'search':           'ابحث عن منتجات، ماركات…',
      'filter':           'تصفية',
      'seeAll':           'عرض الكل',
      'done':             'تم',

      'home':             'الرئيسية',
      'categories':       'الفئات',
      'cart':             'السلة',
      'orders':           'الطلبات',
      'profile':          'الملف الشخصي',

      'login':            'تسجيل الدخول',
      'register':         'إنشاء حساب',
      'logout':           'تسجيل الخروج',
      'email':            'البريد الإلكتروني',
      'password':         'كلمة المرور',
      'confirmPassword':  'تأكيد كلمة المرور',
      'fullName':         'الاسم الكامل',
      'phoneNumber':      'رقم الهاتف',
      'forgotPassword':   'نسيت كلمة المرور؟',
      'noAccount':        'ليس لديك حساب؟ ',
      'haveAccount':      'لديك حساب بالفعل؟ ',
      'signInWithGoogle': 'المتابعة مع Google',
      'signInWithPhone':  'المتابعة مع الهاتف',
      'verify':           'تحقق',
      'resendCode':       'إعادة إرسال الرمز',

      'deliverTo':        'التوصيل إلى',
      'featuredProducts': 'المنتجات المميزة',
      'newArrivals':      'وصل حديثاً',
      'specialOffers':    'عروض خاصة',

      'addToCart':        'أضف إلى السلة',
      'buyNow':           'اشتري الآن',
      'productDetails':   'تفاصيل المنتج',
      'reviews':          'التقييمات',
      'inStock':          'متوفر',
      'outOfStock':       'غير متوفر',
      'quantity':         'الكمية',
      'relatedProducts':  'قد يعجبك أيضاً',
      'brand':            'الماركة',

      'myCart':           'سلتي',
      'emptyCart':        'سلتك فارغة',
      'subtotal':         'المجموع الفرعي',
      'deliveryFee':      'رسوم التوصيل',
      'total':            'الإجمالي',
      'checkout':         'إتمام الشراء',
      'promoCode':        'رمز الخصم',
      'apply':            'تطبيق',

      'myOrders':         'طلباتي',
      'orderDetails':     'تفاصيل الطلب',
      'placeOrder':       'تأكيد الطلب',
      'orderPlaced':      'تم تأكيد الطلب!',
      'trackOrder':       'تتبع الطلب',
      'statusPreparing':  'قيد التحضير',
      'statusOnTheWay':   'في الطريق',
      'statusDelivered':  'تم التسليم',
      'statusCancelled':  'ملغي',

      'deliveryAddress':  'عنوان التوصيل',
      'addAddress':       'إضافة عنوان',
      'chooseOnMap':      'اختر على الخريطة',
      'paymentMethod':    'طريقة الدفع',
      'orderSummary':     'ملخص الطلب',
      'cashOnDelivery':   'الدفع عند الاستلام',
      'creditCard':       'بطاقة ائتمان / خصم',
      'digitalWallet':    'المحفظة الرقمية',

      'settings':         'الإعدادات',
      'language':         'اللغة',
      'darkMode':         'الوضع الداكن',
      'lightMode':        'الوضع الفاتح',
      'notifications':    'الإشعارات',
      'helpSupport':      'المساعدة والدعم',
      'privacyPolicy':    'سياسة الخصوصية',
      'termsConditions':  'الشروط والأحكام',
      'english':          'English',
      'arabic':           'العربية',

      'fieldRequired':     'هذا الحقل مطلوب',
      'invalidEmail':      'يرجى إدخال بريد إلكتروني صحيح',
      'passwordTooShort':  'كلمة المرور يجب أن تكون 8 أحرف على الأقل',
      'passwordsNotMatch': 'كلمتا المرور غير متطابقتين',
      'invalidPhone':      'يرجى إدخال رقم هاتف صحيح',
    },
  };

  String _t(String key) {
    final lang = locale.languageCode;
    return _strings[lang]?[key] ?? _strings['en']?[key] ?? key;
  }

  String get appName          => _t('appName');
  String get ok               => _t('ok');
  String get cancel           => _t('cancel');
  String get save             => _t('save');
  String get delete           => _t('delete');
  String get edit             => _t('edit');
  String get retry            => _t('retry');
  String get loading          => _t('loading');
  String get noData           => _t('noData');
  String get error            => _t('error');
  String get noInternet       => _t('noInternet');
  String get search           => _t('search');
  String get filter           => _t('filter');
  String get seeAll           => _t('seeAll');
  String get done             => _t('done');

  String get home             => _t('home');
  String get categories       => _t('categories');
  String get cart             => _t('cart');
  String get orders           => _t('orders');
  String get profile          => _t('profile');

  String get login            => _t('login');
  String get register         => _t('register');
  String get logout           => _t('logout');
  String get email            => _t('email');
  String get password         => _t('password');
  String get confirmPassword  => _t('confirmPassword');
  String get fullName         => _t('fullName');
  String get phoneNumber      => _t('phoneNumber');
  String get forgotPassword   => _t('forgotPassword');
  String get noAccount        => _t('noAccount');
  String get haveAccount      => _t('haveAccount');
  String get signInWithGoogle => _t('signInWithGoogle');
  String get signInWithPhone  => _t('signInWithPhone');
  String get verify           => _t('verify');
  String get resendCode       => _t('resendCode');

  String get deliverTo        => _t('deliverTo');
  String get featuredProducts => _t('featuredProducts');
  String get newArrivals      => _t('newArrivals');
  String get specialOffers    => _t('specialOffers');

  String get addToCart        => _t('addToCart');
  String get buyNow           => _t('buyNow');
  String get productDetails   => _t('productDetails');
  String get reviewsLabel     => _t('reviews');
  String get inStock          => _t('inStock');
  String get outOfStock       => _t('outOfStock');
  String get quantity         => _t('quantity');
  String get relatedProducts  => _t('relatedProducts');
  String get brand            => _t('brand');

  String get myCart           => _t('myCart');
  String get emptyCart        => _t('emptyCart');
  String get subtotal         => _t('subtotal');
  String get deliveryFee      => _t('deliveryFee');
  String get total            => _t('total');
  String get checkout         => _t('checkout');
  String get promoCode        => _t('promoCode');
  String get apply            => _t('apply');

  String get myOrders         => _t('myOrders');
  String get orderDetails     => _t('orderDetails');
  String get placeOrder       => _t('placeOrder');
  String get orderPlaced      => _t('orderPlaced');
  String get trackOrder       => _t('trackOrder');
  String get statusPreparing  => _t('statusPreparing');
  String get statusOnTheWay   => _t('statusOnTheWay');
  String get statusDelivered  => _t('statusDelivered');
  String get statusCancelled  => _t('statusCancelled');

  String get deliveryAddress  => _t('deliveryAddress');
  String get addAddress       => _t('addAddress');
  String get chooseOnMap      => _t('chooseOnMap');
  String get paymentMethod    => _t('paymentMethod');
  String get orderSummary     => _t('orderSummary');
  String get cashOnDelivery   => _t('cashOnDelivery');
  String get creditCard       => _t('creditCard');
  String get digitalWallet    => _t('digitalWallet');

  String get settings         => _t('settings');
  String get language         => _t('language');
  String get darkMode         => _t('darkMode');
  String get lightMode        => _t('lightMode');
  String get notifications    => _t('notifications');
  String get helpSupport      => _t('helpSupport');
  String get privacyPolicy    => _t('privacyPolicy');
  String get termsConditions  => _t('termsConditions');
  String get english          => _t('english');
  String get arabic           => _t('arabic');

  String get fieldRequired    => _t('fieldRequired');
  String get invalidEmail     => _t('invalidEmail');
  String get passwordTooShort => _t('passwordTooShort');
  String get passwordsNotMatch => _t('passwordsNotMatch');
  String get invalidPhone     => _t('invalidPhone');
}


const localizationsDelegates = [
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];

const supportedLocales = [Locale('en'), Locale('ar')];