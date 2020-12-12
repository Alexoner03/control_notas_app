import 'package:control_notas_flutter/src/widgets/lista_cursos_disponibles.dart';
import 'package:control_notas_flutter/src/widgets/menu_alumno_widget.dart';
import 'package:flutter/material.dart';

class DisponiblesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cursos Disponibles'),
        backgroundColor: Color.fromRGBO(0, 65, 101, 1)
      ),
      drawer: MenuWidgetAlumno(),
      body: CursosDisponiblesList(),
    );
  }
}