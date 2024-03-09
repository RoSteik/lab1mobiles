import 'package:my_project/lab2/logic/model/user.dart';
import 'package:my_project/lab2/logic/service/user_storage_service.dart';

class AuthService {
  final IUserStorageService _userStorageService = UserStorageService();

  Future<String?> register(String name, String email, String password) async {
    if (!email.contains('@') || name.isEmpty || password.length < 6) {
      return 'Invalid input';
    }
    final existingUser = await _userStorageService.getUser(email);
    if (existingUser != null) {
      return 'User already exists';
    }
    final newUser = User(name: name, email: email, password: password);
    await _userStorageService.saveUser(newUser);
    return null;
  }

  Future<User?> login(String email, String password) async {
    final user = await _userStorageService.getUser(email);
    if (user != null && user.password == password) {
      return user;
    }
    return null;
  }
}
