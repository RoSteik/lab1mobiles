import 'package:my_project/lab2/logic/model/user.dart';
import 'package:my_project/lab2/logic/service/user_storage_service.dart';

abstract class IAuthService {
  Future<String?> register(String name, String email, String password);

  Future<User?> login(String email, String password);
}

class AuthService implements IAuthService {
  final IUserStorageService _userStorageService = UserStorageService();

  @override
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

  @override
  Future<User?> login(String email, String password) async {
    final user = await _userStorageService.getUser(email);
    if (user != null && user.password == password) {
      return user;
    }
    return null;
  }
}
