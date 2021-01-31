import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tic_tac_toe/globals.dart';
import 'package:tic_tac_toe/tic_tac_toe/Cell.dart';
import 'package:tic_tac_toe/tic_tac_toe/winning.dart';

class TicTacToe extends StatefulWidget {
  @override
  TicTacToeState createState() => TicTacToeState();
}

class TicTacToeState extends State<TicTacToe> {
  List<int> board = List.generate(9, (index) => Player.EMPTY_SPACE);
  int currentPlayer = Player.PLAYER_1;

  bool gameOver = false;
  String winner;

  int onUserPlayed(List<int> board) {
    var evaluation = Player.evaluateBoard(board);

    if (evaluation == Player.PLAYER_1) {
      setState(() {
        gameOver = true;
        winner = "Player 1";
      });
    } else if (evaluation == Player.PLAYER_2) {
      setState(() {
        gameOver = true;
        winner = "Player 2";
      });
    } else if (evaluation == Player.DRAW) {
      setState(() {
        gameOver = true;
        winner = "Draw";
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

  void endGame() {
    if (gameOver) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Game Over'),
              content: Text(
                'Winner $winner',
                style: TextStyle(fontSize: 20),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }
  }

  Widget PlayerInfo() {
    return Container(
        decoration: showWidgetBorders ? widgetBorder() : null,
        margin: EdgeInsets.all(32.0),
        child: Column(
          children: [
            Text(
              "Player 1: X",
              style: TextStyle(fontSize: 20, backgroundColor: Colors.amber),
            ),
            Text(
              "Player 2: O",
              style: TextStyle(fontSize: 20, backgroundColor: Colors.amber),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      endGame();
    });

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

    if (gameOver) {}

    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Text("Tic Tac Toe"),
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/images/home_page_background_5.jpg"),
              fit: BoxFit.cover,
            )),
            child: Container(
              decoration: showWidgetBorders ? widgetBorder() : null,
              child: Container(
                  decoration: showWidgetBorders ? widgetBorder() : null,
                  child: Column(children: [
                    Container(
                        child: Expanded(
                            child: Container(
                              decoration: showWidgetBorders ? widgetBorder() : null,
                                child: GridView.count(
                                    crossAxisCount: 3,
                                    children: List.generate(9, (idx) {
                                      return Cell(
                                          idx: idx,
                                          onTap: _movePlayed,
                                          playerSymbol: getSymbolForIdx(idx));
                                    }))))),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        PlayerInfo(),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: FlatButton(
                            child: Icon(Icons.refresh, size: 70),
                            onPressed: () {
                              restartGame();
                            },
                          ),
                        )
                      ],
                    ),
                  ])),
            )));
  }
}
