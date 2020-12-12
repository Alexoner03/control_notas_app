import 'package:control_notas_flutter/src/widgets/menu_alumno_widget.dart';
import 'package:flutter/material.dart';

class HomeAlumno extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido Alumno'),
        backgroundColor: Color.fromRGBO(0, 65, 101, 1)
      ),
      drawer: MenuWidgetAlumno(),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Center(
          child: Text('Por favor Seleccione una opción del menú', style : TextStyle(fontSize: 30),textAlign: TextAlign.center,),
        ),
      ),
    );
  }
}