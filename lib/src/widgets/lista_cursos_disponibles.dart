import 'package:control_notas_flutter/src/models/course_model.dart';
import 'package:control_notas_flutter/src/providers/course_provider.dart';
import 'package:control_notas_flutter/src/providers/user_provider.dart';
import 'package:control_notas_flutter/src/shares_prefs/auth_prefs.dart';
import 'package:control_notas_flutter/src/utils/alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CursosDisponiblesList extends StatefulWidget {
  CursosDisponiblesList({Key key}) : super(key: key);

  @override
  _CursosDisponiblesListState createState() => _CursosDisponiblesListState();
}

class _CursosDisponiblesListState extends State<CursosDisponiblesList> {
  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final courseProvider = Provider.of<CourseProvider>(context);

    return FutureProvider(
        create: (_) => courseProvider.getCursosDisponibles(
            userProvider.user.idByRol, prefs.token),
        child: Consumer<List<Course>>(builder: (_, list, __) {
          if (list == null) {
            return Container(child: Center(child: CircularProgressIndicator()));
          } else if (list.length == 0) {
            return Center(
                child: Text("Usted ya esta matriculado en todos los cursos"));
          }
          return _createList(list);
        }));
  }

  Widget _createList(List<Course> cursos) {
    return ListView.builder(
        itemCount: cursos.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: EdgeInsets.all(20),
              child: ListTile(
                  title: Text(
                      '${cursos[index].nombre} | Fec. Ini : ${cursos[index].inicio.year.toString().padLeft(4, '0')}-${cursos[index].inicio.month.toString().padLeft(2, '0')}-${cursos[index].inicio.day.toString().padLeft(2, '0')}'),
                  trailing: _button(cursos[index].id, context)
              ));
        });
  }

  Widget _button(int id, BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final courseProvider = Provider.of<CourseProvider>(context, listen: false);
    bool _cargando = false;

    return RaisedButton.icon(
      onPressed: _cargando ? null : () async {
        setState(() => _cargando = true);
        final response = await courseProvider.matricularse(id, userProvider.user.idByRol, prefs.token);
        setState(() => _cargando = false);

        if(response["res"]){
          await notifySimple(context, "Correcto", response["msg"], 'OK');
          Navigator.pushReplacementNamed(context, 'matriculados');
        }else{
          await notifySimple(context, "Error", response["msg"], 'OK');
        }
      }, 
      icon: Icon(Icons.app_registration, 
      color: Colors.white), 
      label: Text('Registrar'),
      color: Colors.teal
    );

  }
}
