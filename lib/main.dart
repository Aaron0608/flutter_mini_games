import 'dart:convert';

import 'package:flutter/material.dart';
import 'file:///D:/16_SOFTWARE_PROJECTS/FLUTTER_PROJECTS/tic_tac_toe/lib/tic_tac_toe/winning.dart';
import 'file:///D:/16_SOFTWARE_PROJECTS/FLUTTER_PROJECTS/tic_tac_toe/lib/snake/snake.dart';
import 'package:tic_tac_toe/tic_tac_toe/tic_tac_toe.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow,
        appBar: AppBar(title: Text('Game Hub'
            )),
        body: ListView(children: [
          Center(                                                   // TIC TAC TOE GAME BUTTON
              child: Container(
                margin: EdgeInsets.all(20.0),

                  child: RaisedButton(
                    padding: EdgeInsets.all(30.0),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => GamePage()));
            },
            child: Text(
              "Tic Tac Toe",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
            ),
          ))),
          Center(                                                     // SNAKE GAME BUTTON
              child: Container(
                  margin: EdgeInsets.all(20.0),

                  child: RaisedButton(
                    padding: EdgeInsets.all(30.0),
                    color: Colors.white,
                    onPressed: () {
                      //Navigator.of(context)
                          //.push(MaterialPageRoute(builder: (context) => SnakePage()));
                    },
                    child: Text(
                        "Snake",
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
                    ),
                  ))),
          Center(                                                     // ABOUT GAME BUTTON
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
        ]));
  }
}

