import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/tic_tac_toe/TicTacToe.dart';
import 'snake/snake.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  // Handle clicking the Tic Tac Toe button by navigating to the TicTacToe app
  void handleOnClickTicTacToe(context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => TicTacToe()));
  }

  // Handle clicking the Snake button by navigating to the SnakeGame app
  void handleOnClickSnakeGame(context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SnakeGame()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(33, 40, 69, 1),
        appBar: AppBar(
          title: Text('Game Hub'),
          actions: [
            Container(
                padding: EdgeInsets.all(10),
                child: FlatButton(
                  onPressed: null,
                  child: Text(
                    'About',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ))
          ],
        ),
        body:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Center(
              // TIC TAC TOE GAME BUTTON
              child: HomePageCard('Tic Tac Toe',
                  handleOnButtonClick: handleOnClickTicTacToe)),
          Center(
              // SNAKE GAME BUTTON
              child: HomePageCard(
            'Snake',
            handleOnButtonClick: handleOnClickSnakeGame,
          )),
        ]));
  }
}

class HomePageCard extends StatelessWidget {
  String name;
  Function(BuildContext context) handleOnButtonClick;

  HomePageCard(String name, {this.handleOnButtonClick}) {
    this.name = name;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(10),
        // shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Container(
            width: 300,
            height: 150,
            child: FlatButton(
              // padding: EdgeInsets.all(10.0),
              onPressed: this.handleOnButtonClick == null
                  ? null
                  : () {
                      this.handleOnButtonClick(context);
                    },
              child: Text(
                name,
                style: TextStyle(
                    fontSize: 50,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            )));
  }
}
