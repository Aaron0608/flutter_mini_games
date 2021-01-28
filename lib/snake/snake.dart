import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SnakePage extends StatefulWidget {     // Create New Page for Snake Game
  @override
  SnakePageState createState() => SnakePageState();
}

class SnakePageState extends State<SnakePage> {
  @override
  Widget build(BuildContext context) {        // Create New Page for Snake Game
    return Scaffold(
        backgroundColor: Colors.yellow,
        appBar: AppBar(
            title: Text("Snake")
        ),
        body: Center(
            child: FlatButton(
                child: Text("Hello World")
            )
        )
    );
  }
}

