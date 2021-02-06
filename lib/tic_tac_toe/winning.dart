import 'package:flutter/cupertino.dart';

class Player {
  static const int PLAYER_1 = 1;
  static const int PLAYER_2 = -1;
  static const int NO_WINNERS_YET = 0;
  static const int DRAW = 2;

  static const int EMPTY_SPACE = 0;
  static const SYMBOLS = {EMPTY_SPACE: "", PLAYER_1: "X", PLAYER_2: "O"};

  static const WIN_CONDITIONALS_LIST = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  static bool isBoardFull(List<int> board) {
    for (var cell in board) {
      if (cell == EMPTY_SPACE) {
        return false;
      }
    }
    return true;
  }

  static bool isMoveLegal(List<int> board, int move) {
    if (move < 0 || move > board.length || board[move] != EMPTY_SPACE) {
      return false;
    }

    return true;
  }

  static int evaluateBoard(List<int> board) {
    for (var list in WIN_CONDITIONALS_LIST) {
      if (board[list[0]] != EMPTY_SPACE &&
          board[list[0]] == board[list[1]] &&
          board[list[0]] == board[list[2]]) {
        //var res = board[list[0]];
        //debugPrint('winner: $res');
        return board[list[0]];
      }
    }

    if (isBoardFull(board)) {
      //debugPrint('board is full: $board');
      return DRAW;
    }
    debugPrint('no winners');
    return NO_WINNERS_YET;
  }

  static int flipPlayer(int currentPlayer) {
    return -1 * currentPlayer;
  }
}
