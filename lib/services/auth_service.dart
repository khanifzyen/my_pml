import 'package:appwrite/appwrite.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/result.dart';
import '../models/user_model.dart';

class AuthService {
  Client client = Client();
  late final Account account;

  AuthService() {
    client
        .setEndpoint(dotenv.env['APPWRITE_ENDPOINT']!)
        .setProject(dotenv.env['APPWRITE_PROJECT_ID']!);
    account = Account(client);
  }

  Future<Result<void>> createAccount(
      {required String email, required String password}) async {
    try {
      await account.create(
          userId: 'unique()', email: email, password: password);
      return const Result.success(null);
    } catch (e) {
      return Result.failed(e.toString());
    }
  }

  Future<Result<User>> login(
      {required String email, required String password}) async {
    try {
      final session = await account.createEmailPasswordSession(
          email: email, password: password);
      // Assuming we can get user details from the session
      final user = User(id: session.$id, email: email);
      return Result.success(user);
    } catch (e) {
      return Result.failed(e.toString());
    }
  }

  Future<Result<void>> logout() async {
    try {
      await account.deleteSession(sessionId: 'current');
      return const Result.success(null);
    } catch (e) {
      return Result.failed(e.toString());
    }
  }
}
