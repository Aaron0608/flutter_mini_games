import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tic_tac_toe/globals.dart';
import 'package:tic_tac_toe/tic_tac_toe/Cell.dart';
import 'package:tic_tac_toe/tic_tac_toe/PlayerInfo.dart';
import 'package:tic_tac_toe/tic_tac_toe/constants.dart';
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

  bool editPlayer1Name = false;
  bool editPlayer2Name = false;

  var playerMapping = {
    Player.PLAYER_1: "",
    Player.PLAYER_2: "",
  };

  int onUserPlayed(List<int> board) {
    var evaluation = Player.evaluateBoard(board);

    if (evaluation == Player.PLAYER_1) {
      setState(() {
        gameOver = true;
        winner = player_1;
        player1Score = player1Score + 1;
      });
    } else if (evaluation == Player.PLAYER_2) {
      setState(() {
        gameOver = true;
        winner = player_2;
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

  void handleShowPlayerNameChange(player, [newPlayerName = false]) {
    if (player == Player.PLAYER_1) {
      setState(() {
        editPlayer1Name = !editPlayer1Name;
        player_1 = newPlayerName != false ? newPlayerName : player_1;
      });
    } else if (player == Player.PLAYER_2) {
      setState(() {
        editPlayer2Name = !editPlayer2Name;
        player_2 = newPlayerName != false ? newPlayerName : player_2;
      });
    }
  }

  void endGame() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: Image(
                          width: 200,
                          height: 150,
                          image: AssetImage("assets/images/crown.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Center(
                            child: Text(
                          "Winner ${playerMapping[Player.flipPlayer(currentPlayer)]}",
                          style: TextStyle(fontSize: 24),
                        )))
                  ],
                ),
              ),
            ),
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

    playerMapping[Player.PLAYER_1] = player_1;
    playerMapping[Player.PLAYER_2] = player_2;

    onUserPlayed(board);

    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: Text("Tic Tac Toe"),
          centerTitle: true,
          backgroundColor: backgroundColor,
          elevation: 0,
        ),
        body: Container(
          decoration: showWidgetBorders ? widgetBorder() : null,
          child: Container(
              decoration: showWidgetBorders ? widgetBorder() : null,
              child: Column(children: [
                Expanded(
                  child: Container(
                      decoration: showWidgetBorders ? widgetBorder() : null,
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: GridView.count(
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisCount: 3,
                          children: List.generate(9, (idx) {
                            return Cell(
                                idx: idx,
                                onTap: gameOver ? null : _movePlayed,
                                playerSymbol: getSymbolForIdx(idx));
                          }))),
                ),
                Container(
                    decoration: showWidgetBorders ? widgetBorder() : null,
                    child: Center(
                        child: Text(
                            "Current Player: ${playerMapping[currentPlayer]}",
                            style: TextStyle(
                                fontSize: generalTextSize,
                                fontWeight: FontWeight.bold,
                                color: generalTextColor)))),
                Container(
                  decoration: showWidgetBorders ? widgetBorder() : null,
                  child: Row(
                    children: [
                      playerInfo(
                          player_1,
                          player_2,
                          player1Score,
                          player2Score,
                          editPlayer1Name,
                          editPlayer2Name,
                          handleShowPlayerNameChange),
                      Container(
                        margin: EdgeInsets.all(10.0),
                        child: FlatButton(
                          child: Icon(
                            Icons.refresh,
                            size: refreshButtonSize,
                            color: generalTextColor,
                          ),
                          onPressed: () {
                            restartGame();
                          },
                        ),
                      )
                    ],
                  ),
                )
              ])),
        ));
  }
}
