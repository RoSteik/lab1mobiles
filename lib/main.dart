import 'package:flutter/material.dart';
import 'package:my_project/lab2/elements/app_routes.dart';
import 'package:my_project/lab2/logic/service/connectivity/connectivity_service.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConnectivityService()),
      ],
      child: MaterialApp(
        title: 'Fitness App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/login',
        routes: appRoutes,
      ),
    );
  }
}



// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Fitness App',
//       theme: ThemeData(primarySwatch: Colors.blue,),
//       initialRoute: '/login',
//       routes: appRoutes,
//     );
//   }
// }



