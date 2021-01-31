
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'winning.dart';

class GamePage extends StatefulWidget {
  @override
  GamePageState createState() => GamePageState();
}

class GamePageState extends State<GamePage> {
  bool cross = true;

  //List cellStates = ['', '', '', '', '', '', '', '', ''];

  List<int> board = List.generate(9, (index) => Player.EMPTY_SPACE);
  int currentPlayer = Player.PLAYER_1;

  bool gameOver = false;

  int onUserPlayed(List<int> board) {
    var evaluation = Player.evaluateBoard(board);

    if (evaluation == Player.PLAYER_1) {
      setState(() {
        gameOver = true;
      });
    } else if (evaluation == Player.PLAYER_2) {
      setState(() {
        gameOver = true;
      });
    } else if (evaluation == Player.DRAW) {
      setState(() {
        gameOver = true;
      });
    } else {
      // game is not over yet
    }

    return evaluation;

  }

  void _movePlayed(int idx) {
    if (!Player.isMoveLegal(board, idx)) {
      return;
    }

    setState(() {
      board[idx] = currentPlayer;
      currentPlayer = Player.flipPlayer(currentPlayer);
    });
  }

  String getSymbolForIdx(int idx) {
    return Player.SYMBOLS[board[idx]];
  }

  void restartGame() {
    setState(() {
      board = List.generate(9, (index) => Player.EMPTY_SPACE);
      gameOver = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var text = "In Play";

    var state = onUserPlayed(board);

    if (state == Player.PLAYER_1) {
      text = "Player 1 won";
    } else if (state == Player.PLAYER_2) {
      text = "Player 2 won";
    } else if (state == Player.DRAW) {
      text = "Draw";
    } else {
      // game is not over yet
    }

    if (gameOver) {

    }



    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Text("Tic Tac Toe"),
        ),

        body:
        Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage("assets/images/home_page_background_5.jpg"),
    fit: BoxFit.cover,
    )
    ),
    child:

        Column(
            children: [
              Expanded(
                  child: GridView.count(
                      crossAxisCount: 3,
                      children: List.generate(9, (idx) {
                        return Cell(
                            idx: idx,
                            onTap: gameOver ? null : _movePlayed,
                            playerSymbol: getSymbolForIdx(idx));
                      }))),
              Center(
                  child: Container(
                      margin: EdgeInsets.all(32.0),
                      child: RaisedButton(
                        padding: EdgeInsets.all(10.0),
                        disabledColor: Colors.yellow,
                        disabledTextColor: Colors.black,
                        child: Text(
                          text,
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                  )
              ),
              Center(
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    child: FlatButton(
                      child: Icon(Icons.refresh, size: 70),
                      onPressed: () {
                        restartGame();
                      },
                    ),
                  )
              )

            ]
        )));

  }
}

class Cell extends StatelessWidget {
  final int idx;
  final Function(int idx) onTap;
  final String playerSymbol;

  Cell({this.idx, this.onTap, this.playerSymbol});

  void _handleTap() {
    onTap(idx);
  }

  final BorderSide _borderSide =
  BorderSide(color: Colors.grey[50], width: 2.0, style: BorderStyle.solid);

  Border _determineBorder() {
    Border determineBorder = Border.all();

    switch (idx) {
      case 0:
        determineBorder = Border(bottom: _borderSide, right: _borderSide);
        break;
      case 1:
        determineBorder =
            Border(left: _borderSide, bottom: _borderSide, right: _borderSide);
        break;
      case 2:
        determineBorder = Border(bottom: _borderSide, left: _borderSide);
        break;
      case 3:
        determineBorder =
            Border(bottom: _borderSide, right: _borderSide, top: _borderSide);
        break;
      case 4:
        determineBorder = Border(
            bottom: _borderSide,
            left: _borderSide,
            top: _borderSide,
            right: _borderSide);
        break;
      case 5:
        determineBorder =
            Border(bottom: _borderSide, left: _borderSide, top: _borderSide);
        break;
      case 6:
        determineBorder = Border(right: _borderSide, top: _borderSide);
        break;
      case 7:
        determineBorder =
            Border(right: _borderSide, top: _borderSide, left: _borderSide);
        break;
      case 8:
        determineBorder = Border(top: _borderSide, left: _borderSide);
        break;
    }

    return determineBorder;
  }

  @override
  Widget build(BuildContext context) {
    var color;
    if(playerSymbol == "X") color = Colors.blue;
    else color = Colors.pink;

    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        margin: const EdgeInsets.all(0.0),
        decoration: BoxDecoration(border: _determineBorder()),
        child:
        Center(
            child: Text(playerSymbol, style: TextStyle(fontSize: 50, color: color))),
      ),
    );
  }
}