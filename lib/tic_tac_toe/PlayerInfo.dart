import 'package:flutter/cupertino.dart';
import 'package:tic_tac_toe/globals.dart';


Widget playerInfo(player1Name, player2Name, player1Score, player2Score) {
  return Container(
      decoration: showWidgetBorders ? widgetBorder() : null,
      margin: EdgeInsets.all(32.0),
      child: Column(
        children: [
          Row(
            children: [
              Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          "Score",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ))
            ],
          ),
          Row(
            children: [
              Container(
                  padding: EdgeInsets.all(2.0),
                  child: Column(
                    children: [
                      Text(
                        '$player1Name: ',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
              Container(
                padding: EdgeInsets.all(2.0),
                child: Column(children: [
                  Text(
                    player1Score.toString(),
                    style:
                    TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ]),
              )
            ],
          ),
          Row(
            children: [
              Container(
                  padding: EdgeInsets.all(2.0),
                  child: Column(
                    children: [
                      Text(
                        '$player2Name: ',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
              Container(
                padding: EdgeInsets.all(2.0),
                child: Column(children: [
                  Text(
                    player2Score.toString(),
                    style:
                    TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ]),
              )
            ],
          ),
        ],
      ));
}