import 'package:appwrite/models.dart' as models;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../models/user_profile_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/user_profile_provider.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final userProfileState = ref.watch(userProfileNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authProvider.notifier).logout();
              context.go('/login');
            },
          ),
        ],
      ),
      body: authState.when(
        data: (user) => user != null
            ? _buildDashboardContent(context, user, userProfileState)
            : const Center(child: Text('Not logged in')),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildDashboardContent(BuildContext context, models.User user,
      AsyncValue<UserProfile?> userProfileState) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Welcome, ${user.name}!',
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 24),
          const Text('Your Profile:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          userProfileState.when(
            data: (profile) => profile != null
                ? _buildProfileInfo(profile)
                : const Text('Profile not set up yet'),
            loading: () => const CircularProgressIndicator(),
            error: (error, _) => Text('Failed to load profile: $error'),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => context.push('/profile'),
            child: const Text('Edit Profile'),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfo(UserProfile profile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Phone: ${profile.phoneNumber ?? 'Not set'}'),
        Text('Location: ${profile.location ?? 'Not set'}'),
        Text('Bio: ${profile.bio ?? 'Not set'}'),
        Text(
            'Interests: ${profile.interests.isEmpty ? 'None' : profile.interests.join(', ')}'),
      ],
    );
  }
}
