import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../services/user_profile_service.dart';
import '../models/user_profile_model.dart';
import '../utils/provider.dart';

part 'user_profile_provider.g.dart';

@riverpod
class UserProfileNotifier extends _$UserProfileNotifier {
  late final UserProfileService _userProfileService =
      UserProfileService(db: ref.read(appwriteDatabaseProvider));

  @override
  Future<UserProfile?> build() async {
    return null; // Initially, we don't have user profile data
  }

  Future<void> createUserProfile(UserProfile profile) async {
    state = const AsyncValue.loading();
    final result = await _userProfileService.createUserProfile(profile);
    if (result.isSuccess) {
      state = AsyncValue.data(result.resultValue);
    } else {
      state = AsyncValue.error(result.errorMessage!, StackTrace.current);
    }
  }

  Future<void> fetchUserProfile(String userId) async {
    state = const AsyncValue.loading();
    final result = await _userProfileService.getUserProfile(userId);
    if (result.isSuccess) {
      state = AsyncValue.data(result.resultValue);
    } else {
      state = AsyncValue.error(result.errorMessage!, StackTrace.current);
    }
  }

  Future<void> updateUserProfile(UserProfile updatedProfile) async {
    state = const AsyncValue.loading();
    final result = await _userProfileService.updateUserProfile(updatedProfile);
    if (result.isSuccess) {
      state = AsyncValue.data(result.resultValue);
    } else {
      state = AsyncValue.error(result.errorMessage!, StackTrace.current);
    }
  }
}
