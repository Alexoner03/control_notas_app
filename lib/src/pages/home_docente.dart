import 'package:control_notas_flutter/src/widgets/menu_docente_widget.dart';
import 'package:flutter/material.dart';

class HomeDocente extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido Docente'),
        backgroundColor: Color.fromRGBO(0, 65, 101, 1)
      ),
      drawer: MenuWidgetDocente(),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Center(
          child: Text('Por favor Seleccione una opción del menú', style : TextStyle(fontSize: 30),textAlign: TextAlign.center,),
        ),
      ),
    );
  }
}