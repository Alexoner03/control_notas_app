import 'package:control_notas_flutter/src/providers/auth_provider.dart';
import 'package:control_notas_flutter/src/providers/course_provider.dart';
import 'package:control_notas_flutter/src/providers/user_provider.dart';
import 'package:control_notas_flutter/src/shares_prefs/auth_prefs.dart';
import 'package:flutter/material.dart' show Navigator,BuildContext;
import 'package:provider/provider.dart';
void closeSesion(BuildContext context){
    final prefs = new PreferenciasUsuario();
    prefs.token = "";

    final userProvider = Provider.of<UserProvider>(context,listen: false);
    final courseProvider = Provider.of<CourseProvider>(context,listen: false);
    final authProvider = Provider.of<AuthProvider>(context,listen: false);

    userProvider.reset();
    courseProvider.reset();
    authProvider.reset();


    Navigator.pushReplacementNamed(context, 'login');
}