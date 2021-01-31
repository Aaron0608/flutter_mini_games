import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tic_tac_toe/globals.dart';
import 'package:tic_tac_toe/tic_tac_toe/Cell.dart';
import 'package:tic_tac_toe/tic_tac_toe/PlayerInfo.dart';
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

  int player1Score = 0;
  int player2Score = 0;

  String player_1 = "Player 1";
  String player_2 = "Player 2";

  var playerMapping = {
    Player.PLAYER_1: "",
    Player.PLAYER_2: "",
  };

  int onUserPlayed(List<int> board) {
    var evaluation = Player.evaluateBoard(board);

    if (evaluation == Player.PLAYER_1) {
      setState(() {
        gameOver = true;
        winner = "Player 1";
        player1Score = player1Score + 1;

      });
    } else if (evaluation == Player.PLAYER_2) {
      setState(() {
        gameOver = true;
        winner = "Player 2";
        player2Score = player2Score + 1;
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

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (gameOver) {
        endGame();
      }
    });

     playerMapping [Player.PLAYER_1] = player_1;
     playerMapping [Player.PLAYER_2] = player_2;


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
                    Expanded(
                      child: Container(
                          decoration: showWidgetBorders ? widgetBorder() : null,
                          child: GridView.count(
                              crossAxisCount: 3,
                              children: List.generate(9, (idx) {
                                return Cell(
                                    idx: idx,
                                    onTap: _movePlayed,
                                    playerSymbol: getSymbolForIdx(idx));
                              }))),
                    ),
                    Container(
                        decoration: showWidgetBorders ? widgetBorder() : null,
                        child: Center(
                            child: Text("Current Player: ${playerMapping[currentPlayer]}",
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold)))),
                    Container(
                      decoration: showWidgetBorders ? widgetBorder() : null,
                      child: Row(
                        children: [
                          playerInfo(player_1, player_2, player1Score, player2Score, true, false),
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
                    )
                  ])),
            )));
  }
}
