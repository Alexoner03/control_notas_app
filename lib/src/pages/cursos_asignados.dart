import 'dart:ui';

import 'package:control_notas_flutter/src/models/course_model.dart';
import 'package:control_notas_flutter/src/providers/course_provider.dart';
import 'package:control_notas_flutter/src/providers/user_provider.dart';
import 'package:control_notas_flutter/src/shares_prefs/auth_prefs.dart';
import 'package:control_notas_flutter/src/utils/detail_course.dart';
import 'package:control_notas_flutter/src/utils/list_students.dart';
import 'package:control_notas_flutter/src/widgets/menu_docente_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CursosAsignados extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context,listen: false);
    final courseProvider = Provider.of<CourseProvider>(context);
    final prefs = new PreferenciasUsuario();

    return Scaffold(
        appBar: AppBar(
            title: Text('Cursos Asignados'),
            backgroundColor: Color.fromRGBO(0, 65, 101, 1)),
        drawer: MenuWidgetDocente(),
        body: Container(
            child: FutureProvider(
                create: (_) => courseProvider.getCursos(
                    userProvider.user.idByRol, prefs.token),
                child: Consumer<List<Course>>(builder: (_, list, __) {
                  if (list == null) {
                    return Container(
                        height: 400.0,
                        child: Center(child: CircularProgressIndicator()));
                  }
                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (_, index) {
                      return Container(
                        height: 80,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(list[index].nombre,
                                style: TextStyle(fontSize: 25)),
                            Row(
                              children: [
                                IconButton(
                                    icon: Icon(Icons.people),
                                    onPressed: () {
                                      notifyCourseDetail(
                                          context, list[index], 'Cerrar');
                                    },
                                    color: Colors.blueGrey),
                                IconButton(
                                    icon: Icon(Icons.list_alt),
                                    onPressed: () async {
                                      final users = await userProvider.getUsersByCourse(list[index].id, prefs.token);
                                      notifyStudents(context, 'Cerrar',users);
                                    },
                                    color: Colors.blueGrey),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  );
                }))));
  }

}