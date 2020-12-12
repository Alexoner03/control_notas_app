import 'package:control_notas_flutter/src/models/user_model.dart';
import 'package:flutter/material.dart';

Future<void> notifyStudents(
    BuildContext context, String confirmText, List<User> users) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
          actions: <Widget>[
            TextButton(
              child: Text(confirmText, style: TextStyle(fontSize: 20)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          contentPadding: EdgeInsets.only(left: 25, right: 25),
          title: Center(child: Text("Matriculados")),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: Container(
            height: 200,
            width: 300,
            child: users.length == 0
                ? Text(
                    'No hay Alumnos Matriculados',
                    textAlign: TextAlign.center,
                  )
                : SingleChildScrollView(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: users.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(title: Text(
                            '${users[index].nombres} ${users[index].apellidos}'));
                      },
                    ),
                  ),
          ));
    },
  );
}
