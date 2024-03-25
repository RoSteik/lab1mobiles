import 'dart:convert';

import 'package:my_project/lab2/logic/model/user.dart';
 import 'package:shared_preferences/shared_preferences.dart';


abstract class IUserStorageService {
  Future<void> saveUser(User user);

  Future<User?> getUser(String email);
}

class UserStorageService implements IUserStorageService {

  SharedPreferences? _prefs;

  Future<SharedPreferences> get prefs async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  @override
  Future<void> saveUser(User user) async {
    final SharedPreferences prefs = await this.prefs;
    prefs.setString(user.email, jsonEncode(user.toJson()));

  }

  @override
  Future<User?> getUser(String email) async {
    final SharedPreferences prefs = await this.prefs;
    final userString = prefs.getString(email);


    if (userString != null) {
      final Map<String, dynamic> userMap =
          jsonDecode(userString) as Map<String, dynamic>;
      return User.fromJson(userMap);
    }
    return null;
  }
}
