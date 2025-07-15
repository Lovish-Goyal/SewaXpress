import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:sewaxpress/features/auth/user_model/user_model.dart';
import 'package:sewaxpress/utils/apiclient.dart';

class AuthService {
  final _account = ApiClient.account;
  final _database = ApiClient.database;

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
    try {
      print('Logging out...');
      await _account.get();
      await _account.deleteSessions();
      print('Logout successful');
    } on AppwriteException catch (e) {
      print('Logout error: $e');
      if (e.code == 401) {
        print('Already logged out');
      } else {
        rethrow;
      }
    }
  }

  Future<UserModel> signup(String email, String password, String name) async {
    // register user
    await _account.create(
      userId: ID.unique(),
      email: email,
      password: password,
      name: name,
    );

    await _account.createEmailPasswordSession(email: email, password: password);

    final currentUser = await _account.get();

    await _database.createDocument(
      databaseId: '68760ad10009d886e4df',
      collectionId: '68760c3a000e046ecff7',
      documentId: currentUser.$id,
      data: {
        'id': currentUser.$id,
        'email': currentUser.email,
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      },
    );

    return UserModel(
      id: currentUser.$id,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  Future<UserModel> getuserData() async {
    final currentUser = await _account.get();

    final user = UserModel(
      id: currentUser.$id,
      email: currentUser.email,
      phoneNumber: currentUser.phone,
      username: currentUser.name,
      gender: 'Male',
      profileImage: null,
      address: null,
      dateofBirth: null,
      createdAt: DateTime.parse(currentUser.$createdAt),
      updatedAt: DateTime.parse(currentUser.$updatedAt),
    );
    return user;
  }

  Future<bool> checkUser() async {
    try {
      await _account.get();
      return true;
    } on AppwriteException catch (e) {
      if (e.code == 401) {
        return false;
      }
      rethrow;
    }
  }

  Future<void> updateProfile(UserModel user) async {
    try {
      final currentUser = await _account.get();
      await ApiClient.database.updateDocument(
        databaseId: '68760ad10009d886e4df',
        collectionId: '68760c3a000e046ecff7',
        documentId: currentUser.$id,
        data: {
          'name': currentUser.name,
          'email': currentUser.email,
          'userId': currentUser.$id,
          'updatedAt': DateTime.now().toIso8601String(),
        },
      );
    } catch (e) {
      return;
    }
    return;
  }
}
