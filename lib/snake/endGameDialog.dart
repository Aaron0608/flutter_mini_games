import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EndGameDialog extends StatefulWidget {
  final String title;
  final int score, highScore;

  const EndGameDialog({Key key, this.title, this.score, this.highScore})
      : super(key: key);

  @override
  _EndGameDialogState createState() => _EndGameDialogState();
}

class _EndGameDialogState extends State<EndGameDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: contentBox(context),
      actions: <Widget>[
        FlatButton(
          child: Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  contentBox(context) {
    bool newHighScore = widget.score > widget.highScore;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Score: ${widget.score}',
          style: TextStyle(fontSize: 20),
        ),
        newHighScore
            ? Text(
                'Congrats, new High Score',
                style: TextStyle(fontSize: 20),
              )
            : Container()
      ],
    );
  }
}
