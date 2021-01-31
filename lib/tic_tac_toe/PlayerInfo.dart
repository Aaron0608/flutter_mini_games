import 'package:flutter/cupertino.dart';
import 'package:tic_tac_toe/globals.dart';


Widget playerInfo() {
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
                        "Player 1:",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
              Container(
                padding: EdgeInsets.all(2.0),
                child: Column(children: [
                  Text(
                    "3",
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
                        "Player 2:",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
              Container(
                padding: EdgeInsets.all(2.0),
                child: Column(children: [
                  Text(
                    "0",
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