import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

part 'locale_provider.g.dart';

@riverpod
class LocaleNotifier extends _$LocaleNotifier {
  @override
  Locale build() {
    _loadSavedLocale();
    return const Locale('en');   
  }

  Future<void> _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code  = prefs.getString(AppConstants.localeKey) ?? AppConstants.localeEn;
    state = Locale(code);
  }

  Future<void> setLocale(String languageCode) async {
    state = Locale(languageCode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.localeKey, languageCode);
  }

  void switchToArabic()  => setLocale(AppConstants.localeAr);
  void switchToEnglish() => setLocale(AppConstants.localeEn);

  bool get isArabic => state.languageCode == AppConstants.localeAr;
}

@riverpod
Locale locale(LocaleRef ref) => ref.watch(localeNotifierProvider);