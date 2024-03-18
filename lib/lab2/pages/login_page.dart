import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_project/lab2/logic/service/auth/auth_service.dart';
import 'package:my_project/lab2/logic/service/connectivity/connectivity_service.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _checkAutoLogin();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _checkAutoLogin() async {
    final bool isLoggedIn = await _authService.autoLogin();
    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, '/profile');
    }
  }

  void _attemptLogin() async {
    final connectivityService =
        Provider.of<ConnectivityService>(context, listen: false);
    if (!connectivityService.hasConnection) {
      _showDialog(
          'No Internet Connection', 'Please check your internet connection.',);
      return;
    }

    final bool loggedIn = await _authService.login(
        _emailController.text, _passwordController.text,);
    if (loggedIn) {
      Fluttertoast.showToast(
        msg: 'Login Successful!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16,
      );
      Navigator.pushReplacementNamed(context, '/profile');
    } else {
      _showDialog('Login Failed', 'Invalid email or password.');
    }
  }

  void _showDialog(String title, String message) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _attemptLogin,
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/registration'),
              child: const Text('Don\'t have an account? Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}

// class _LoginPageState extends State<LoginPage> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//
//   final AuthService _authService = AuthService();
//
//   @override
//   void initState() {
//     super.initState();
//     _attemptLogin();
//   }
//
//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//
//
//   void _attemptLogin() async {
//     final connectivityService =
//         Provider.of<ConnectivityService>(context, listen: false);
//     if (!connectivityService.hasConnection) {
//       _showDialog(
//           'No Internet Connection', 'Please check your internet connection.',);
//       return;
//     }
//
//     final loggedIn = await _authService.login(
//         _emailController.text, _passwordController.text,);
//
//     if (loggedIn) {
//
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setBool('isLoggedIn', true);
//       await prefs.setString('lastLoggedInUser', _emailController.text);
//
//       Fluttertoast.showToast(
//           msg: 'Login Successful!',
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.BOTTOM,
//           backgroundColor: Colors.blue,
//           textColor: Colors.white,
//           fontSize: 16,);
//
//       if (mounted) {
//         Navigator.pushReplacementNamed(context, '/profile');
//       }
//     } else {
//       _showDialog('Login Failed', 'Invalid email or password.');
//     }
//
//   }
//
//   void _showDialog(String title, String message) {
//     showDialog<void>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(title),
//         content: Text(message),
//         actions: [
//           TextButton(
//             child: const Text('OK'),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _emailController,
//               decoration: const InputDecoration(labelText: 'Email'),
//             ),
//             const SizedBox(height: 10),
//             TextField(
//               controller: _passwordController,
//               obscureText: true,
//               decoration: const InputDecoration(labelText: 'Password'),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _attemptLogin,
//               child: const Text('Login'),
//             ),
//             TextButton(
//               onPressed: () => Navigator.pushNamed(context, '/registration'),
//               child: const Text('Don\'t have an account? Sign up'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

// void _attemptLogin() async {
//   final email = _emailController.text;
//   final password = _passwordController.text;
//
//   final loggedIn = await _authService.login(email, password);
//
//   if (mounted) {
//     if (loggedIn) {
//       Navigator.pushReplacementNamed(context, '/');
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Invalid email or password')),
//       );
//     }
//   }
// }

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     body: Padding(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           TextField(
//             controller: _emailController,
//             decoration: const InputDecoration(labelText: 'Email'),
//           ),
//           const SizedBox(height: 10),
//           TextField(
//             controller: _passwordController,
//             obscureText: true,
//             decoration: const InputDecoration(labelText: 'Password'),
//           ),
//           const SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: _attemptLogin,
//             child: const Text('Login'),
//           ),
//           TextButton(
//             onPressed: () => Navigator.pushNamed(context, '/registration'),
//             child: const Text('Don\'t have an account? Sign up'),
//           ),
//         ],
//       ),
//     ),
//   );
// }
//}
