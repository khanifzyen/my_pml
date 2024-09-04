import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import '../models/result.dart';

abstract class IAuthService {
  Future<Result<void>> createAccount(
      {required String email, required String password});
  Future<Result<models.User>> login(
      {required String email, required String password});
  Future<Result<models.User>> getCurrentUser();
  Future<Result<models.Session>> getCurrentSession();
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
  Future<Result<models.User>> login(
      {required String email, required String password}) async {
    try {
      await _account.createEmailPasswordSession(
          email: email, password: password);
      // Assuming we can get user details from the session
      final user = await _account.get();
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

  @override
  Future<Result<models.User>> getCurrentUser() async {
    try {
      // Retrieve the current user
      final user = await _account.get();
      return Result.success(user);
    } on AppwriteException catch (e) {
      return Result.failed(e.message.toString());
    }
  }

  @override
  Future<Result<models.Session>> getCurrentSession() async {
    try {
      // Retrieve the current session
      final session = await _account.getSession(sessionId: 'current');
      return Result.success(session);
    } on AppwriteException catch (e) {
      return Result.failed(e.message.toString());
    }
  }
}
