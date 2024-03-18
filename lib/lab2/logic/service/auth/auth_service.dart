import 'dart:convert';

// import 'package:my_project/lab2/logic/model/user.dart';
import 'package:my_project/lab2/logic/service/auth/user_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IAuthService {
  Future<String?> register(String name, String email, String password);

  Future<bool> autoLogin();

  Future<bool> login(String email, String password);

  Future<void> logout();
}

class AuthService implements IAuthService {
  final IUserStorageService _userStorageService = UserStorageService();

  @override
  Future<String?> register(String name, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final existingUser = prefs.getString(email);
    if (existingUser != null) {
      return 'User already exists';
    }
    final userMap =
        jsonEncode({'name': name, 'email': email, 'password': password});
    await prefs.setString(email, userMap);
    await prefs.setString('lastLoggedInUser', email);
    return null;
  }

  @override
  Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString(email);
    if (userString == null) {
      return false;
    }
    final userMap = jsonDecode(userString);
    if (userMap['password'] == password) {
      await prefs.setString(
          'lastLoggedInUser', email,);
      return true;
    }
    return false;
  }

  @override
  Future<bool> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final lastLoggedInUser = prefs.getString('lastLoggedInUser');
    if (lastLoggedInUser == null) {
      return false;
    }
    return true;
  }

  @override
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('lastLoggedInUser');
    await prefs.setBool('isLoggedIn', false);
  }

// @override
// Future<String?> register(String name, String email, String password) async {
//   if (!email.contains('@') || name.isEmpty || password.length < 6) {
//     return 'Invalid input';
//   }
//   final existingUser = await _userStorageService.getUser(email);
//   if (existingUser != null) {
//     return 'User already exists';
//   }
//   final newUser = User(name: name, email: email, password: password);
//   await _userStorageService.saveUser(newUser);
//   return null;
// }
//
// @override
// Future<bool> login(String email, String password) async {
//   final prefs = await SharedPreferences.getInstance();
//   final userString = prefs.getString(email);
//   if (userString != null) {
//     final userMap = jsonDecode(userString) as Map<String, dynamic>;
//     if (password == userMap['password']) {
//       await prefs.setString('lastLoggedInUser', email);
//       await prefs.setBool('isLoggedIn', true);
//       return true;
//     }
//   }
//   return false;
// }
//
// @override
// Future<bool> autoLogin() async {
//   final prefs = await SharedPreferences.getInstance();
//   final lastLoggedInUserEmail = prefs.getString('lastLoggedInUser');
//   if (lastLoggedInUserEmail != null) {
//     final userString = prefs.getString(lastLoggedInUserEmail);
//     return userString != null;
//   }
//   return false;
// }
//
// @override
// Future<void> logout() async {
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.remove('lastLoggedInUser');
//   await prefs.setBool('isLoggedIn', false);
//}
}
