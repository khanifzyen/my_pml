import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';

part 'auth_provider.g.dart';

@riverpod
class Auth extends _$Auth {
  late final AuthService _authService = AuthService();

  @override
  Future<User?> build() async {
    // TODO: Check if user is already logged in and return User object
    return null;
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    final result = await _authService.login(email: email, password: password);
    if (result.isSuccess) {
      state = AsyncValue.data(result.resultValue);
    } else {
      state = AsyncValue.error(result.errorMessage!, StackTrace.current);
    }
  }

  Future<void> register(String email, String password, String text) async {
    state = const AsyncValue.loading();
    final result =
        await _authService.createAccount(email: email, password: password);
    if (result.isSuccess) {
      await login(email, password);
    } else {
      state = AsyncValue.error(result.errorMessage!, StackTrace.current);
    }
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    final result = await _authService.logout();
    if (result.isSuccess) {
      state = const AsyncValue.data(null);
    } else {
      state = AsyncValue.error(result.errorMessage!, StackTrace.current);
    }
  }
}
