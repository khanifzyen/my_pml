import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/user_profile_provider.dart';
import '../../models/user_profile_model.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfileAsyncValue = ref.watch(userProfileNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('User Profile')),
      body: userProfileAsyncValue.when(
        data: (profile) => profile != null
            ? _buildProfileView(context, profile, ref)
            : const Center(child: Text('No profile data')),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildProfileView(
      BuildContext context, UserProfile profile, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: profile.profilePictureUrl != null
              ? NetworkImage(profile.profilePictureUrl!)
              : null,
          child: profile.profilePictureUrl == null
              ? const Icon(Icons.person, size: 50)
              : null,
        ),
        const SizedBox(height: 16),
        Text(profile.userId, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 16),
        _buildInfoTile('Phone', profile.phoneNumber),
        _buildInfoTile(
            'Date of Birth', profile.dateOfBirth?.toString().split(' ')[0]),
        _buildInfoTile('Location', profile.location),
        _buildInfoTile('Bio', profile.bio),
        _buildInfoTile('Interests', profile.interests.join(', ')),
        _buildInfoTile('Join Date', profile.joinDate?.toString().split(' ')[0]),
        ElevatedButton(
          onPressed: () {
            // TODO: Navigate to edit profile screen
          },
          child: const Text('Edit Profile'),
        ),
      ],
    );
  }

  Widget _buildInfoTile(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 100,
              child: Text(title,
                  style: const TextStyle(fontWeight: FontWeight.bold))),
          Expanded(child: Text(value ?? 'Not provided')),
        ],
      ),
    );
  }
}
