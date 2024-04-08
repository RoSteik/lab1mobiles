import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/lab2/elements/app_routes.dart';
import 'package:my_project/lab2/logic/service/auth/auth_service.dart';
import 'package:my_project/lab2/logic/service/tracker/fitness_data_service.dart';
import 'package:my_project/lab2/pages/splash_screen.dart';
import 'package:my_project/lab2/pages/utils/main/fitness_data_bloc.dart';
import 'package:my_project/lab2/pages/utils/user/user_bloc.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        Provider<FitnessDataService>(
          create: (_) => FitnessDataService(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<FitnessDataBloc>(
            create: (context) =>
                FitnessDataBloc(context.read<FitnessDataService>()),
          ),
          BlocProvider<UserBloc>(
            create: (context) => UserBloc(context.read<AuthService>()),
          ),
        ],
        child: MaterialApp(
          title: 'Fitness App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const SplashScreen(),
          routes: appRoutes,
        ),
      ),
    );
  }
}
