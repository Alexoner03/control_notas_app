import 'package:control_notas_flutter/src/pages/calificar_page.dart';
import 'package:control_notas_flutter/src/pages/cursos_asignados.dart';
import 'package:control_notas_flutter/src/pages/disponibles_page.dart';
import 'package:control_notas_flutter/src/pages/home_page.dart';
import 'package:control_notas_flutter/src/pages/login_page.dart';
import 'package:control_notas_flutter/src/pages/matriculados_page.dart';
import 'package:control_notas_flutter/src/pages/profile_student_page.dart';
import 'package:control_notas_flutter/src/pages/profile_teacher_page.dart';
import 'package:control_notas_flutter/src/providers/auth_provider.dart';
import 'package:control_notas_flutter/src/providers/course_provider.dart';
import 'package:control_notas_flutter/src/providers/user_provider.dart';
import 'package:control_notas_flutter/src/shares_prefs/auth_prefs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}
 
 
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new AuthProvider()),
        ChangeNotifierProvider(create: (_) => new UserProvider()),
        ChangeNotifierProvider(create: (_) => new CourseProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CIBERTEC',
        initialRoute: 'login',
        routes: {
          'login' : (BuildContext context) => LoginPage(),
          'home' : (BuildContext context) => HomePage(),
          'asignados' : (BuildContext context) => CursosAsignados(),
          'calificar' : (BuildContext context) => CalificarPage(),
          'profileteacher' : (BuildContext context) => ProfileTeacher(),
          'disponibles' : (BuildContext context) => DisponiblesPage(),
          'matriculados' : (BuildContext context) => MatriculadosPage(),
          'profilestudent' : (BuildContext context) => ProfileStudent(),
        },
      ),
    );
  }
}