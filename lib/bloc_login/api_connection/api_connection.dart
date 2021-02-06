import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tic_tac_toe/bloc_login/model/api_model.dart';


final _base = "http://192.168.0.227:8000";
final _tokenEndpoint = "/api/token/";
final _tokenUrl = _base + _tokenEndpoint;

Future<Token> getToken(UserLogin userLogin) async {
  print(_tokenUrl);
  final http.Response response = await http.post(
    _tokenUrl,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(userLogin.toDatabaseJson()),
  );
  if(response.statusCode == 200) {
    return Token.fromJson(json.decode(response.body));
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}