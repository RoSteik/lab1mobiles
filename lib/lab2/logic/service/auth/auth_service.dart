import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:my_project/lab2/logic/model/user.dart';
import 'package:my_project/lab2/logic/service/auth/user_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final UserStorageService _userStorageService = UserStorageService();

  final String _baseUrl = 'http://10.0.2.2:8080/api/users';

  Future<String?> register(String name, String email, String password) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return 'No internet connection. '
          'Please connect to the internet to sign up.';
    }

    final response = await http.post(
      Uri.parse('$_baseUrl/create'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final newUser = User(name: name, email: email, password: password);
      await _userStorageService.saveUser(newUser);
      return null;
    } else {
      return 'Failed to register user';
    }
  }


  Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString(email);
    if (userString != null) {
      final userMap = jsonDecode(userString) as Map<String, dynamic>;
      if (password == userMap['password']) {
        await prefs.setString('lastLoggedInUser', email);
        return true;
      }
    }
    return false;
  }



  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('lastLoggedInUser');
  }
}
