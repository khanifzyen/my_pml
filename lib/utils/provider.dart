import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:appwrite/appwrite.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

part 'provider.g.dart';

@riverpod
Client appwriteClient(AppwriteClientRef ref) {
  return Client()
    ..setEndpoint(dotenv.env['APPWRITE_ENDPOINT']!)
    ..setProject(dotenv.env['APPWRITE_PROJECT_ID']!);
}

@riverpod
Account appwriteAccount(AppwriteAccountRef ref) {
  final client = ref.watch(appwriteClientProvider);
  return Account(client);
}

@riverpod
Databases appwriteDatabase(AppwriteDatabaseRef ref) {
  final client = ref.watch(appwriteClientProvider);
  return Databases(client);
}

@riverpod
Storage appwriteStorage(AppwriteStorageRef ref) {
  final client = ref.watch(appwriteClientProvider);
  return Storage(client);
}

@riverpod
Realtime appwriteRealtime(AppwriteRealtimeRef ref) {
  final client = ref.watch(appwriteClientProvider);
  return Realtime(client);
}
