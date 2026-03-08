// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locale_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$localeHash() => r'734cd5452a0cfdf31f99d140f2b99c2e518a2ab2';

/// See also [locale].
@ProviderFor(locale)
final localeProvider = AutoDisposeProvider<Locale>.internal(
  locale,
  name: r'localeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$localeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LocaleRef = AutoDisposeProviderRef<Locale>;
String _$localeNotifierHash() => r'06c25a89b06295d2ab652361907e2c4eada5e58e';

/// See also [LocaleNotifier].
@ProviderFor(LocaleNotifier)
final localeNotifierProvider =
    AutoDisposeNotifierProvider<LocaleNotifier, Locale>.internal(
  LocaleNotifier.new,
  name: r'localeNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$localeNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LocaleNotifier = AutoDisposeNotifier<Locale>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
