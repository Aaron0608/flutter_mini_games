import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/tic_tac_toe/TicTacToe.dart';
import 'bloc_login/LoginPageHome.dart';
import 'bloc_login/bloc/authentication_bloc.dart';
import 'bloc_login/repository/user_repository.dart';
import 'snake/snake.dart';

void main() {
  runApp(MyApp());
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    precacheImage(
        AssetImage("assets/images/home_page_background_3.jpg"), context);
    precacheImage(
        AssetImage("assets/images/home_page_background_5.jpg"), context);
    precacheImage(
        AssetImage("assets/images/home_page_background_7.jpg"), context);
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  final userRepository = UserRepository();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.yellow,
        appBar: AppBar(title: Text('Game Hub'
        )),
        body:
        Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/home_page_background_3.jpg"),
                  fit: BoxFit.cover,
                )
            ),
            child:
            ListView(children: [
              Center( // TIC TAC TOE GAME BUTTON
                  child: Container(
                      margin: EdgeInsets.all(20.0),

                      child: RaisedButton(
                        padding: EdgeInsets.all(30.0),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                              builder: (context) => TicTacToe()));
                        },
                        child: Text(
                            "Tic Tac Toe",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)
                        ),
                      ))),
              Center( // SNAKE GAME BUTTON
                  child: Container(
                      margin: EdgeInsets.all(20.0),

                      child: RaisedButton(
                        padding: EdgeInsets.all(30.0),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                              builder: (context) => SnakeGame()));
                        },
                        child: Text(
                            "Snake",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)
                        ),
                      ))),
              Center( // SNAKE GAME BUTTON
                  child: Container(
                      margin: EdgeInsets.all(20.0),

                      child: RaisedButton(
                        padding: EdgeInsets.all(30.0),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) =>
                              (BlocProvider<AuthenticationBloc>(
                                create: (context) {
                                  return AuthenticationBloc(
                                      userRepository: userRepository)
                                    ..add(AppStarted());
                                },
                                child: LoginPageHome(
                                    userRepository: userRepository),
                              ))));
                        },
                        child: Text(
                            "Login Page",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)
                        ),
                      ))),
              Center( // ABOUT GAME BUTTON
                  child: Container(
                      margin: EdgeInsets.only(bottom: 10.0),

                      child: RaisedButton(
                        padding: EdgeInsets.all(10.0),
                        color: Colors.grey,
                        onPressed: () {
                          //Navigator.of(context)
                          //.push(MaterialPageRoute(builder: (context) => SnakePage()));
                        },
                        child: Text(
                          "About",
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                      )))
            ])));
  }
}

