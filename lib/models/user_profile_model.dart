import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_model.freezed.dart';
part 'user_profile_model.g.dart';

@freezed
class UserProfile with _$UserProfile {
  factory UserProfile({
    required String userId,
    String? phoneNumber,
    DateTime? dateOfBirth,
    String? profilePictureUrl,
    String? bio,
    @Default([]) List<String> interests,
    String? location,
    DateTime? joinDate,
    @Default({}) Map<String, dynamic> additionalInfo,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}
