import 'package:appwrite/appwrite.dart';
import '../models/result.dart';
import '../models/user_model.dart';

abstract class IAuthService {
  Future<Result<void>> createAccount(
      {required String email, required String password});
  Future<Result<User>> login({required String email, required String password});
  Future<Result<void>> logout();
}

class AuthService implements IAuthService {
  final Account _account;

  AuthService({required Account account}) : _account = account;

  @override
  Future<Result<void>> createAccount(
      {required String email, required String password, String? name}) async {
    try {
      await _account.create(
          userId: 'unique()', email: email, password: password, name: name);
      return const Result.success(null);
    } on AppwriteException catch (e) {
      return Result.failed(e.message.toString());
    }
  }

  @override
  Future<Result<User>> login(
      {required String email, required String password}) async {
    try {
      final session = await _account.createEmailPasswordSession(
          email: email, password: password);
      // Assuming we can get user details from the session
      final user = User(id: session.$id, email: email);
      return Result.success(user);
    } on AppwriteException catch (e) {
      return Result.failed(e.message.toString());
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      await _account.deleteSession(sessionId: 'current');
      return const Result.success(null);
    } on AppwriteException catch (e) {
      return Result.failed(e.message.toString());
    }
  }
}
