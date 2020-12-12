import 'package:control_notas_flutter/src/models/course_model.dart';
import 'package:control_notas_flutter/src/models/user_model.dart';
import 'package:control_notas_flutter/src/providers/course_provider.dart';
import 'package:control_notas_flutter/src/providers/user_provider.dart';
import 'package:control_notas_flutter/src/shares_prefs/auth_prefs.dart';
import 'package:control_notas_flutter/src/widgets/calificador_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalificationBody extends StatefulWidget {
  CalificationBody({Key key}) : super(key: key);

  @override
  _CalificationBodyState createState() => _CalificationBodyState();
}

class _CalificationBodyState extends State<CalificationBody> {

  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final courseProvider = Provider.of<CourseProvider>(context);

    return FutureProvider(
        create: (_) =>
            courseProvider.getCursos(userProvider.user.idByRol, prefs.token),
        child: Consumer<List<Course>>(builder: (_, list, __) {
          if (list == null) {
            return Container(
                child: Center(child: CircularProgressIndicator()));
          }
          return _createExpasionList(list);
        }));
  }

  Widget _createExpasionList(List<Course> cursos) {
    return ListView.builder(
      itemCount: cursos.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ExpansionTile(
            title: Text(cursos[index].nombre,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
            children: [
              Container(
                child: _estudiantes(context,cursos[index]),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _estudiantes(BuildContext context, Course curso) {

    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return FutureProvider(
        create: (_) =>
            userProvider.getUsersByCourse(curso.id, prefs.token),
        child: Consumer<List<User>>(builder: (_, list, __) {
          if (list == null) {
            return Container(
                height: 80,
                child: Center(child: CircularProgressIndicator()));
          }
          return _crearListaEstudiantes(list,curso.id);
        }));
  }

  Widget _crearListaEstudiantes(List<User> users, int cursoId) {
    return Container(
      height: 400,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(users[index].nombres+' '+ users[index].apellidos, style: TextStyle(fontSize: 15)),
                  height: 35,
                ),
                CalificatorWidget(code : users[index].idByRol, nota: users[index].nota, course: cursoId,)
              ],
            );
        },
      ),
    );
  }
}
