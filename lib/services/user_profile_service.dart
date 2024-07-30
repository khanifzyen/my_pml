import 'package:appwrite/appwrite.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/result.dart';
import '../models/user_profile_model.dart';

class UserProfileService {
  late final Databases _databases;

  UserProfileService() {
    final client = Client()
      ..setEndpoint(dotenv.env['APPWRITE_ENDPOINT']!)
      ..setProject(dotenv.env['APPWRITE_PROJECT_ID']!);
    _databases = Databases(client);
  }

  Future<Result<UserProfile>> createUserProfile(UserProfile profile) async {
    try {
      final document = await _databases.createDocument(
        databaseId: dotenv.env['APPWRITE_DATABASE_ID']!,
        collectionId: dotenv.env['APPWRITE_USER_PROFILE_COLLECTION_ID']!,
        documentId: profile.userId,
        data: profile.toJson(),
      );
      return Result.success(UserProfile.fromJson(document.data));
    } catch (e) {
      return Result.failed(e.toString());
    }
  }

  Future<Result<UserProfile>> getUserProfile(String userId) async {
    try {
      final document = await _databases.getDocument(
        databaseId: dotenv.env['APPWRITE_DATABASE_ID']!,
        collectionId: dotenv.env['APPWRITE_USER_PROFILE_COLLECTION_ID']!,
        documentId: userId,
      );
      return Result.success(UserProfile.fromJson(document.data));
    } catch (e) {
      return Result.failed(e.toString());
    }
  }

  Future<Result<UserProfile>> updateUserProfile(UserProfile profile) async {
    try {
      final document = await _databases.updateDocument(
        databaseId: dotenv.env['APPWRITE_DATABASE_ID']!,
        collectionId: dotenv.env['APPWRITE_USER_PROFILE_COLLECTION_ID']!,
        documentId: profile.userId,
        data: profile.toJson(),
      );
      return Result.success(UserProfile.fromJson(document.data));
    } catch (e) {
      return Result.failed(e.toString());
    }
  }
}
