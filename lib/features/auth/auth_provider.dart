import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_service.dart';
import 'package:appwrite/models.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final userProvider = FutureProvider<User?>((ref) async {
  final authService = ref.read(authServiceProvider);
  try {
    return await authService.getUser();
  } catch (_) {
    return null;
  }
});
