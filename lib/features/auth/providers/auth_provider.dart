import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_service.dart';
import 'package:appwrite/models.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final userProvider = FutureProvider<User?>((ref) async {
  final authService = ref.read(authServiceProvider);
  try {
    final user = await authService.getUser();
    return user;
  } on AppwriteException catch (e) {
    if (e.code == 401) {
      return null;
    }
    rethrow;
  } catch (_) {
    return null;
  }
});
