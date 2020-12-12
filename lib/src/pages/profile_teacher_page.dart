import 'package:control_notas_flutter/src/providers/user_provider.dart';
import 'package:control_notas_flutter/src/widgets/menu_docente_widget.dart';
import 'package:flutter/material.dart';
import 'package:json_table/json_table.dart';
import 'package:provider/provider.dart';

class ProfileTeacher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido Docente'),
        backgroundColor: Color.fromRGBO(0, 65, 101, 1)
      ),
      drawer: MenuWidgetDocente(),
      body: _profile(context),
    );
  }

  Widget _profile(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
    final jsonData = [
      {
        "Nombres" : user.nombres,
        "Apellidos" : user.nombres,
        "Email" : user.email,
        "Codigo"  : user.codigo,
        "Role" : user.role,
        "Registrado" : "${user.createdAt.year.toString().padLeft(4, '0')}-${user.createdAt.month.toString().padLeft(2, '0')}-${user.createdAt.day.toString().padLeft(2, '0')}"
      }
    ];

    return Center(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/img/oak.jpg'),height: 200),
            SizedBox(height: 50,),
            Text('${user.nombres} este es su perfil:', style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
            SizedBox(height: 50,),
            JsonTable(jsonData, showColumnToggle: true)
          ],
        ),
      ),
    );

  }
}