import 'dart:convert';

import 'package:control_notas_flutter/src/models/course_model.dart';
import 'package:control_notas_flutter/src/providers/course_provider.dart';
import 'package:control_notas_flutter/src/providers/user_provider.dart';
import 'package:control_notas_flutter/src/shares_prefs/auth_prefs.dart';
import 'package:control_notas_flutter/src/widgets/menu_alumno_widget.dart';
import 'package:flutter/material.dart';
import 'package:json_table/json_table.dart';
import 'package:provider/provider.dart';

class MatriculadosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Cursos Disponibles'),
          backgroundColor: Color.fromRGBO(0, 65, 101, 1)),
      drawer: MenuWidgetAlumno(),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text('Lista de Cursos'),
            SizedBox(height: 20,),
            _tableCursos(context)
          ],
        ),
      ),
    );
  }

  Widget _tableCursos(BuildContext context) {
    final courseProvider = Provider.of<CourseProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final prefs = PreferenciasUsuario();

    return FutureProvider(
        create: (_) => courseProvider.getCursosMatriculados(
            userProvider.user.idByRol, prefs.token),
        child: Consumer<List<Course>>(builder: (_, list, __) {
          if (list == null) {
            return Container(
                height: 80, child: Center(child: CircularProgressIndicator()));
          }
          return _crearListaCursos(list);
        }));
  }

  Widget _crearListaCursos(List<Course> list) {

    if(list.length == 0 ){
      return Center(
        child: Text("Usted no tiene cursos Matriculados",style: TextStyle(fontSize: 25),),
      );
    }

    int sumaNotas = 0;

    final _list = list.map((item){
      sumaNotas += item.nota;
      return item.toJson();
    }).toList();

    

    return Column(
      children: [
        JsonTable(_list),
        SizedBox(height: 20),
        Text('Su Promedio de notas es de : ${(sumaNotas / list.length)}')
      ],
    );
  }
}
