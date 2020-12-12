import 'package:control_notas_flutter/src/widgets/accordeon_widget.dart';
import 'package:control_notas_flutter/src/widgets/menu_docente_widget.dart';
import 'package:flutter/material.dart';

class CalificarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: Text('Calificar Alumnos'),
          backgroundColor: Color.fromRGBO(0, 65, 101, 1)),
      drawer: MenuWidgetDocente(),
      body: CalificationBody()
    );
  }
}
