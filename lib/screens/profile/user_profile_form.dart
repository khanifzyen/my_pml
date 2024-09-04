import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/user_profile_model.dart';
import '../../providers/user_profile_provider.dart';

class UserProfileForm extends ConsumerStatefulWidget {
  @override
  _UserProfileFormState createState() => _UserProfileFormState();
}

class _UserProfileFormState extends ConsumerState<UserProfileForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _phoneNumberController;
  late TextEditingController _bioController;
  late TextEditingController _locationController;

  @override
  void initState() {
    super.initState();
    _phoneNumberController = TextEditingController();
    _bioController = TextEditingController();
    _locationController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _bioController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProfile = ref.watch(userProfileNotifierProvider);

    return userProfile.when(
      data: (profile) {
        if (profile != null) {
          _phoneNumberController.text = profile.phoneNumber ?? '';
          _bioController.text = profile.bio ?? '';
          _locationController.text = profile.location ?? '';

          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                TextFormField(
                  controller: _phoneNumberController,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  keyboardType: TextInputType.phone,
                ),
                TextFormField(
                  controller: _bioController,
                  decoration: const InputDecoration(labelText: 'Bio'),
                  maxLines: 3,
                ),
                TextFormField(
                  controller: _locationController,
                  decoration: const InputDecoration(labelText: 'Location'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      final updatedProfile = profile.copyWith(
                        phoneNumber: _phoneNumberController.text,
                        bio: _bioController.text,
                        location: _locationController.text,
                      );
                      ref
                          .read(userProfileNotifierProvider.notifier)
                          .updateUserProfile(updatedProfile);
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text('No profile data available.'));
        }
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Error: $error')),
    );
  }
}
