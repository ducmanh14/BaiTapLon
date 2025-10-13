import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:food_app/screens/auth/blocs/sing_in_bloc/sign_in_bloc.dart';
import 'package:food_app/screens/home/blocs/get_food_bloc/get_food_bloc.dart';
import 'package:food_repository/food_repository.dart';

import 'screens/auth/views/welcome_screen.dart';
import 'screens/home/views/home_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Food',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
          colorScheme: ColorScheme.light(primary: Color(0xFF1565C0), tertiary: Color(0xFF64B5F6), secondary: Color(0xFFFFC107), background: Color(0xFFF5F9FF), onBackground: Color(0xFF0D1B2A), onPrimary: Colors.white,)),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: ((context, state) {
        if (state.status == AuthenticationStatus.authenticated) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => SignInBloc(context.read<AuthenticationBloc>().userRepository),
              ),
              BlocProvider(
                create: (context) => GetFoodBloc(
                    FirebaseFoodRepo()
                )..add(GetFood()),
              ),
            ],
            child: const HomeScreen(),
          );
        } else {
          return const WelcomeScreen();
        }
          }),
      ));
  }
}
