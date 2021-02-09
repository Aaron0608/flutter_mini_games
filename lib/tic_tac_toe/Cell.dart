import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class Cell extends StatelessWidget {
  final int idx;
  final Function(int idx) onTap;
  final String playerSymbol;

  Cell({this.idx, this.onTap, this.playerSymbol});

  void _handleTap() {
    onTap(idx);
  }

  final BorderSide _borderSide =
      BorderSide(color: gridColor, width: gridWidth, style: BorderStyle.solid);

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
    if (playerSymbol == "X")
      color = player1XColor;
    else
      color = player2OColor;

    return GestureDetector(
      onTap: onTap != null ? _handleTap : null,
      child: Container(
        margin: blah,
        decoration: BoxDecoration(border: _determineBorder()),
        child: Center(
            child: Text(playerSymbol,
                style: TextStyle(
                  fontSize: playerSymbolSize,
                  color: color,
                  fontWeight: FontWeight.bold,
                ))),
      ),
    );
  }
}
