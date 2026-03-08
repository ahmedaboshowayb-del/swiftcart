import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension ContextX on BuildContext {
  ThemeData   get theme       => Theme.of(this);
  TextTheme   get textTheme   => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  Size   get screenSize   => MediaQuery.sizeOf(this);
  double get screenWidth  => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;

  bool get isDark  => Theme.of(this).brightness == Brightness.dark;
  bool get isLight => !isDark;

  bool get isRTL => Directionality.of(this) == TextDirection.RTL;

  void showSnackBar(
    String message, {
    bool isError = false,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(this)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor:
              isError ? Theme.of(this).colorScheme.error : null,
          duration: duration,
        ),
      );
  }

  void showSuccessSnackBar(String message) =>
      showSnackBar(message, isError: false);

  void showErrorSnackBar(String message) =>
      showSnackBar(message, isError: true);
}

extension StringX on String {
  String get capitalizeFirst =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';

  String get titleCase => split(' ')
      .map((w) => w.isEmpty
          ? w
          : '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}')
      .join(' ');

  bool get isValidEmail =>
      RegExp(r'^[\w\-.]+@([\w\-]+\.)+[\w\-]{2,4}$').hasMatch(this);

  bool get isValidPhone =>
      RegExp(r'^\+?[0-9]{8,15}$').hasMatch(replaceAll(RegExp(r'[\s\-().]'), ''));
}

extension DoubleX on double {
  String get asCurrency =>
      NumberFormat.currency(symbol: 'SAR ', decimalDigits: 2).format(this);

  String get asCompactCurrency =>
      'SAR ${NumberFormat('#,##0.##').format(this)}';

  String get asPercent => '${toStringAsFixed(0)}%';
}

extension DateTimeX on DateTime {
  String get formattedDate     => DateFormat('MMM d, yyyy').format(this);
  String get formattedDateTime => DateFormat('MMM d, yyyy • hh:mm a').format(this);
  String get formattedTime     => DateFormat('hh:mm a').format(this);

  String get timeAgo {
    final diff = DateTime.now().difference(this);
    if (diff.inDays > 365)    return '${(diff.inDays / 365).floor()}y ago';
    if (diff.inDays > 30)     return '${(diff.inDays / 30).floor()}mo ago';
    if (diff.inDays > 0)      return '${diff.inDays}d ago';
    if (diff.inHours > 0)     return '${diff.inHours}h ago';
    if (diff.inMinutes > 0)   return '${diff.inMinutes}m ago';
    return 'Just now';
  }

  bool get isToday {
    final now = DateTime.now();
    return day == now.day && month == now.month && year == now.year;
  }
}

extension ListX<T> on List<T> {
  List<T> get unique => toSet().toList();

  T? get firstOrNull => isEmpty ? null : first;

  List<List<T>> chunked(int size) {
    final chunks = <List<T>>[];
    for (var i = 0; i < length; i += size) {
      chunks.add(sublist(i, i + size > length ? length : i + size));
    }
    return chunks;
  }
}