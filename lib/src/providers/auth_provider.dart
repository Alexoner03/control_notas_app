import 'dart:convert';

import 'package:control_notas_flutter/src/models/auth_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  
  AuthResponse auth;
  
  String _url = "control.saphi.io";
  final _headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json'
  };

  void reset(){
    auth = null;
  }

  Future<AuthResponse> login(String email, String password) async {
    final uri = Uri.http(_url, '/api/login');
    final body = json.encode({"email": email, "password": password});
    final resp = await http.post(uri,headers: _headers,body: body);
    final decodedData = json.decode(resp.body);
    auth = new AuthResponse.fromJson(decodedData);
    notifyListeners();
    return this.auth;
  }

}