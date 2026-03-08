import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/user_entity.dart';
import '../../data/repositories/auth_repository_impl.dart';

part 'profile_provider.g.dart';

@riverpod
Stream<UserEntity?> authUser(AuthUserRef ref) =>
    ref.watch(authRepositoryProvider).authStateChanges;

@riverpod
class ProfileNotifier extends _$ProfileNotifier {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<void> signOut() async {
    state = const AsyncLoading();
    final result = await ref.read(authRepositoryProvider).signOut();
    state = result.fold(
      (f) => AsyncError(f.userMessage, StackTrace.current),
      (_) => const AsyncData(null),
    );
  }
}