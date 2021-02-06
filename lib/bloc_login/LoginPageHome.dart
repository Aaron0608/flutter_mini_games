import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:tic_tac_toe/bloc_login/bloc/authentication_bloc.dart';
import 'package:tic_tac_toe/bloc_login/home/home_page.dart';
import 'package:tic_tac_toe/bloc_login/splash/splash.dart';
import 'package:tic_tac_toe/bloc_login/login/login_page.dart';
import 'package:tic_tac_toe/bloc_login/common/common.dart';
import 'package:tic_tac_toe/bloc_login/repository/user_repository.dart';
import 'package:tic_tac_toe/bloc_login/splash/splash_page.dart';
import 'package:tic_tac_toe/bloc_login/home/home.dart';

import '../main.dart';
import 'bloc/authentication_bloc.dart';
import 'common/loading_indicator.dart';
import 'login/login_page.dart';



// void LoginPage() {
//   BlocSupervisor.delegate = SimpleBlocDelegate();
//   final userRepository = UserRepository();
//
//   runApp(BlocProvider<AuthenticationBloc>(
//     create: (context) {
//       return AuthenticationBloc(userRepository: userRepository)
//         ..add(AppStarted());
//     },
//     child: LoginPageHome(userRepository: userRepository),
//   ));
// }

class LoginPageHome extends StatelessWidget {
  final UserRepository userRepository;

  LoginPageHome({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        brightness: Brightness.dark,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationUninitialized) {
            return SplashPage();
          }
          if (state is AuthenticationAuthenticated) {
            return HomePage2();
          }
          if (state is AuthenticationUnauthenticated) {
            return LoginPage(
              userRepository: userRepository,
            );
          }
          if (state is AuthenticationLoading) {
            return LoadingIndicator();
          }
        },
      ),
    );
  }
}
