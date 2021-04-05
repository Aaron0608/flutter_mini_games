import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

import 'package:tic_tac_toe/snake/highScore.dart';

/// Using an enum so we can reference the Direction for Snake as
/// Direction.up instead of the string 'up'.
///
/// We do this because 'up' is just a string and does not mean anything without
/// reading the code it is used with, which is not good practice. Instead,
/// calling Direction.up tells us it relates to a direction, and someone could
/// look at this doc string here to understand direction relates to direction
/// of the snake.
///
/// It also helps prevent typos. You may misspell a direction when using a string.
/// Unlikely in this case, but Direction.hello does not exist, compared to 'hello'
/// as a string is acceptable and you may not know its wrong until the app breaks.
enum Direction {
  left,
  up,
  right,
  down,
}

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

  static final Direction initialDirection = Direction.up;
  static final List initialSnakePosition = [
    [(squaresPerRow / 2).floor(), (squaresPerCol / 2).floor()],
    //head
    [(squaresPerRow / 2).floor(), (squaresPerCol / 2).floor() + 1],
    //body - (first cell of body)
  ];

  int currentScore;
  int highScore;
  Direction direction;
  bool isPlaying;

  var snake;
  var food;

  @override
  void initState() {
    super.initState();

    currentScore = 0;
    highScore = 0;
    direction = initialDirection;
    isPlaying = false;
    snake = initialSnakePosition;
    food = [0, 2];

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

    setState(() {
      currentScore = 0;
      direction = initialDirection;
      snake = new List.from(initialSnakePosition);
      isPlaying = true;
    });

    createFood();

    Timer.periodic(duration, (Timer timer) {
      moveSnake();
      if (checkGameOver()) {
        timer.cancel();
        endGame();
      }
    });
  }

  /// Move the snake on the screen.
  ///
  /// Remember position (0, 0) is the top left. So moving upwards is reducing
  /// the y value, moving left is reducing the x value.
  void moveSnake() {

    // Create a copy of the snake list so we don't mutate is below.
    // 'snake' is a state variable so we should only update it using setState().
    var newSnake = new List.from(snake);

    switch (direction) {
      case Direction.up:
        if (newSnake.first[1] <= 0) {
          //make the snake go from top of grid to bottom
          newSnake.insert(0, [newSnake.first[0], squaresPerCol - 1]);
        } else {
          newSnake.insert(0,
              [newSnake.first[0], newSnake.first[1] - 1]); // keep the snake moving up
        }
        break;

      case Direction.down:
        if (newSnake.first[1] >= squaresPerCol - 1) {
          newSnake.insert(0, [newSnake.first[0], 0]);
        } else {
          newSnake.insert(0, [newSnake.first[0], newSnake.first[1] + 1]);
        }
        break;

      case Direction.left:
        if (newSnake.first[0] <= 0) {
          newSnake.insert(0, [squaresPerRow - 1, newSnake.first[1]]);
        } else {
          newSnake.insert(0, [newSnake.first[0] - 1, newSnake.first[1]]);
        }
        break;

      case Direction.right:
        if (newSnake.first[0] >= squaresPerRow - 1) {
          newSnake.insert(0, [0, newSnake.first[1]]);
        } else {
          newSnake.insert(0, [newSnake.first[0] + 1, newSnake.first[1]]);
        }
        break;
    }

    var score = currentScore;
    if (newSnake.first[0] != food[0] || newSnake.first[1] != food[1]) {
      newSnake.removeLast();
    } else {
      createFood();
      score = newSnake.length - 2;
    }
    setState(() {
      currentScore = score;
      snake = newSnake;
    });
  }

  void createFood() {
    setState(() {
      food = [Random().nextInt(squaresPerRow), Random().nextInt(squaresPerCol)];
    });
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

    setState(() {
      isPlaying = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(33, 40, 69, 1),
      //backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  var newDirection = direction;
                  if (direction != Direction.up && details.delta.dy > 0) {
                    newDirection = Direction.down;
                  } else if (direction != Direction.down &&
                      details.delta.dy < 0) {
                    newDirection = Direction.up;
                  }
                  setState(() {
                    direction = newDirection;
                  });
                },
                onHorizontalDragUpdate: (details) {
                  var newDirection = direction;
                  if (direction != Direction.left && details.delta.dx > 0) {
                    newDirection = Direction.right;
                  } else if (direction != Direction.right &&
                      details.delta.dx < 0) {
                    newDirection = Direction.left;
                  }
                  setState(() {
                    direction = newDirection;
                  });
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
