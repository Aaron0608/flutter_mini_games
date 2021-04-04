import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

import 'package:tic_tac_toe/snake/highScore.dart';

class SnakeGame extends StatefulWidget {
  @override
  _SnakeGameState createState() => _SnakeGameState();
}

/// WARNING: The grid does not size to the squaresPerRow and squaresPerCol
/// values specified at the beginning of this class. Instead the grid is hardcoded
/// to look somewhat alright and then the number of columns was adjusted to match.
///  So don't go messing with these values until the grid issue is fixed.
class _SnakeGameState extends State<SnakeGame> {
  static final int squaresPerRow = 20;
  static final int squaresPerCol = 26;
  static final fontStyle = TextStyle(color: Colors.white, fontSize: 20);

  static final initialDirection = 'up';
  static final List initialSnakePosition = [
    [(squaresPerRow / 2).floor(), (squaresPerCol / 2).floor()],
    //head
    [(squaresPerRow / 2).floor(), (squaresPerCol / 2).floor() + 1],
    //body - (first cell of body)
  ];

  int currentScore = 0;
  int highScore = 0;
  String direction = initialDirection;
  bool isPlaying = false;

  var snake = initialSnakePosition;
  var food = [0, 2];

  @override
  void initState() {
    super.initState();
    // When we first open Snake, we should load the high score.
    _getHighScore();
  }

  /// Retrieves the high score saved locally, and updates the 'highScore'
  /// state variable.
  _getHighScore() async {
    int newHighScore = await getHighScore();
    setState(() {
      highScore = newHighScore;
    });
  }

  _updateHighScore(int newHighScore) async {
    await updateHighScore(newHighScore);
    _getHighScore();
  }

  _resetHighScore() async {
    await resetHighScore();
    _getHighScore();
  }

  void startGame() {
    const duration = Duration(milliseconds: 200);

    currentScore = 0;
    direction = initialDirection;
    snake = new List.from(initialSnakePosition);

    createFood();

    isPlaying = true;
    Timer.periodic(duration, (Timer timer) {
      moveSnake();
      if (checkGameOver()) {
        timer.cancel();
        endGame();
      }
    });
  }

  void moveSnake() {
    setState(() {
      switch (direction) {
        case 'up':
          if (snake.first[1] <= 0) {
            //make the snake go from top of grid to bottom
            snake.insert(0, [snake.first[0], squaresPerCol - 1]);
          } else {
            snake.insert(0, [
              snake.first[0],
              snake.first[1] - 1
            ]); // keep the snake moving up
          }
          break;

        case 'down':
          if (snake.first[1] >= squaresPerCol - 1) {
            snake.insert(0, [snake.first[0], 0]);
          } else {
            snake.insert(0, [snake.first[0], snake.first[1] + 1]);
          }
          break;

        case 'left':
          if (snake.first[0] <= 0) {
            snake.insert(0, [squaresPerRow - 1, snake.first[1]]);
          } else {
            snake.insert(0, [snake.first[0] - 1, snake.first[1]]);
          }
          break;

        case 'right':
          if (snake.first[0] >= squaresPerRow - 1) {
            snake.insert(0, [0, snake.first[1]]);
          } else {
            snake.insert(0, [snake.first[0] + 1, snake.first[1]]);
          }
          break;
      }

      if (snake.first[0] != food[0] || snake.first[1] != food[1]) {
        snake.removeLast();
      } else {
        createFood();
        currentScore = snake.length - 2;
      }
    });
  }

  void createFood() {
    food = [Random().nextInt(squaresPerRow), Random().nextInt(squaresPerCol)];
  }

  bool checkGameOver() {
    if (!isPlaying) {
      return true;
    }

    // Check if snake head has hit body
    for (var i = 1; i < snake.length; ++i) {
      if (snake[i][0] == snake.first[0] && snake[i][1] == snake.first[1]) {
        return true;
      }
    }

    return false;
  }

  void endGame() {
    isPlaying = false;

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Game Over'),
            content: Text(
              'Score: $currentScore',
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
    if (currentScore > highScore) {
      _updateHighScore(currentScore);
    }
  }

  Widget build(BuildContext context) {
    // _getHighScore();

    return Scaffold(
      backgroundColor: Color.fromRGBO(33, 40, 69, 1),
      //backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  if (direction != 'up' && details.delta.dy > 0) {
                    direction = 'down';
                  } else if (direction != 'down' && details.delta.dy < 0) {
                    direction = 'up';
                  }
                },
                onHorizontalDragUpdate: (details) {
                  if (direction != 'left' && details.delta.dx > 0) {
                    direction = 'right';
                  } else if (direction != 'right' && details.delta.dx < 0) {
                    direction = 'left';
                  }
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(30, 60, 30, 0),
                  child: SizedBox.expand(
                      child: Container(
                    child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 20,
                        ),
                        // itemCount: squaresPerRow * squaresPerCol,
                        itemCount: 520,
                        itemBuilder: (BuildContext context, int index) {
                          var color;
                          var x = index % squaresPerRow;
                          var y = (index / squaresPerRow).floor();

                          bool isSnakeBody = false;
                          for (var pos in snake) {
                            if (pos[0] == x && pos[1] == y) {
                              isSnakeBody = true;
                              break;
                            }
                          }

                          if (snake.first[0] == x && snake.first[1] == y) {
                            color = Colors.green[700];
                          } else if (isSnakeBody) {
                            color = Colors.green[400];
                          } else if (food[0] == x && food[1] == y) {
                            color = Colors.red;
                          } else {
                            color = Color.fromRGBO(33, 40, 69, 1);
                          }

                          return Container(
                            margin: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          );
                        }),
                  )),
                )),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    'Score: $currentScore',
                    style: fontStyle,
                  ),
                  Text(
                    'HS: $highScore',
                    style: fontStyle,
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                      color: isPlaying ? Colors.red : Colors.blue,
                      child: Text(
                        isPlaying ? 'End' : 'Start',
                        style: fontStyle,
                      ),
                      onPressed: () {
                        if (isPlaying) {
                          isPlaying = false;
                        } else {
                          startGame();
                        }
                      }),
                  FlatButton(
                      color: Colors.orange,
                      child: Text(
                        "Reset High Score",
                        style: fontStyle,
                      ),
                      onPressed: () {
                        _resetHighScore();
                      }),
                ],
              )),
        ],
      ),
    );
  }
}
