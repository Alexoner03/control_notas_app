import 'dart:convert';

import 'package:control_notas_flutter/src/models/course_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CourseProvider extends ChangeNotifier {

  Courses cursos;
  
  String _url = "control.saphi.io";
  final _headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json'
  };

  void reset(){
    cursos = null;
  }

  Future<List<Course>> getCursos(int id,String token) async {
    final uri = Uri.http(_url, '/api/courses/$id/list-teacher');
    _headers["Authorization"] = 'Bearer $token';
    final resp = await http.get(uri,headers: _headers);
    final decodedData = json.decode(resp.body);
    if(decodedData["res"]){
      
      cursos = new Courses.fromJsonList(decodedData["data"]);
      notifyListeners();
    }
    return cursos.cursos;
  }

  Future<bool> setNota(int idcurso, int idestudiante, int nota, String token) async {
    final uri = Uri.http(_url, '/api/courses/calificate');
    _headers["Authorization"] = 'Bearer $token';
    final encoded = json.encode({
      "nota" : nota,
      "cursoid" : idcurso,
      "studentid" : idestudiante
    });
    final resp = await http.patch(uri,headers: _headers, body : encoded );
    final decodedData = json.decode(resp.body);
    return decodedData["res"];
  }

  Future<List<Course>> getCursosMatriculados(int idStudent, String token) async {
    final uri = Uri.http(_url, '/api/students/$idStudent/courses');
    _headers["Authorization"] = 'Bearer $token';
    final resp = await http.get(uri,headers: _headers);
    final decodedData = json.decode(resp.body);
    if(decodedData["res"]){
      cursos = new Courses.fromJsonListStudent(decodedData["data"][0]["courses"]);
      notifyListeners();
    }
    return cursos.cursos;
  }

  Future<List<Course>> getCursosDisponibles(int idStudent, String token) async {
    final uri = Uri.http(_url, '/api/students/$idStudent/courses-availables');
    _headers["Authorization"] = 'Bearer $token';
    final resp = await http.get(uri,headers: _headers);
    final decodedData = json.decode(resp.body);
    if(decodedData["res"]){
      cursos = new Courses.fromJsonList(decodedData["data"]);
      notifyListeners();
    }
    return cursos.cursos;
  }

  Future<Map<String,dynamic>> matricularse(int idcurso, int idestudiante, String token) async {
    final uri = Uri.http(_url, '/api/students/enroll');
    _headers["Authorization"] = 'Bearer $token';
    final encoded = json.encode({
      "student_id" : idestudiante,
      "course_id" : idcurso
    });
    final resp = await http.post(uri,headers: _headers, body : encoded );
    final decodedData = json.decode(resp.body);
    final result = {
      "res" : decodedData["res"],
      "msg" : decodedData["message"]
    };

    return result;
  }
}