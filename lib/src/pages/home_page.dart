
import 'package:control_notas_flutter/src/pages/home_alumno.dart';
import 'package:control_notas_flutter/src/pages/home_docente.dart';
import 'package:control_notas_flutter/src/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    if(userProvider.user.roleId == 2){
      return HomeDocente();
    }

    return HomeAlumno();

  }
}