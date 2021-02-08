import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/bloc_login/bloc/authentication_bloc.dart';
import 'package:tic_tac_toe/bloc_login/dao/user_dao.dart';
import 'package:tic_tac_toe/bloc_login/model/user_model.dart';

import 'package:flutter/cupertino.dart';

Future<List> getUser() async {
  final dao = UserDao();

  return await dao.myUsers();
  // await UserDao.myUsers();
}

class HomePage2 extends StatelessWidget {
  static const userName = "unknown";

  // static const a = getUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home | Home Hub'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left: 30.0), child: thingGame()),
            Padding(
              padding: EdgeInsets.fromLTRB(34.0, 20.0, 0.0, 0.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.width * 0.16,
                child: RaisedButton(
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  onPressed: () {
                    BlocProvider.of<AuthenticationBloc>(context)
                        .add(LoggedOut());
                  },
                  shape: StadiumBorder(
                    side: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class thingGame extends StatefulWidget {
  @override
  _thingState createState() => _thingState();
}

class _thingState extends State<thingGame> {
  String userName = null;

  void getName() async {
    var users = await getUser();

    debugPrint(users.first.username);

    setState(() {
      userName = users.first.username;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userName == null) {
      getName();
    }

    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.width * 0.16,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Expanded(
          child: Text(
            'Welcome $userName',
            style: TextStyle(
              fontSize: 24.0,
            ),
          ),
        )
      ]),
    );
  }
}
