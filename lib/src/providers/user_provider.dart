import 'dart:convert';

import 'package:control_notas_flutter/src/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  
  User user;
  List<User> users;
  
  String _url = "control.saphi.io";
  
  final _headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json'
  };

  void reset(){
    user = null;
    users = null;
  }

  Future<User> getData(String token) async {
    final uri = Uri.http(_url, '/api/user');
    _headers["Authorization"] = 'Bearer $token';
    final resp = await http.get(uri,headers: _headers);
    final decodedData = json.decode(resp.body);
    if(decodedData["res"]){
      user = new User.fromJson(decodedData["data"]);
      notifyListeners();
    }
    return this.user;
  }

  Future<List<User>> getUsersByCourse(int id,String token) async {
    final uri = Uri.http(_url, '/api/courses/$id/detail');
    _headers["Authorization"] = 'Bearer $token';
    final resp = await http.get(uri,headers: _headers);
    final decodedData = json.decode(resp.body);
    if(resp.statusCode == 200){
      final _users = new Users.fromJsonCourseList(decodedData["students"]);
      users = _users.usuarios;
      notifyListeners();
    }
    return this.users;
  }
}