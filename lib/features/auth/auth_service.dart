import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:sewaxpress/utils/apiclient.dart';

class AuthService {
  final _account = ApiClient.account;

  Future<User> getUser() async => await _account.get();

  Future<Session?> login(String email, String password) async {
    try {
      return await _account.createEmailPasswordSession(
        email: email,
        password: password,
      );
    } on AppwriteException {
      return null;
    }
  }

  Future<void> logout() async {
    await _account.deleteSessions();
  }

  Future<User> signup(String email, String password, String name) async {
    await _account.create(
      userId: ID.unique(),
      email: email,
      password: password,
      name: name,
    );

    await _account.createEmailPasswordSession(email: email, password: password);
    return await _account.get();
  }
}
