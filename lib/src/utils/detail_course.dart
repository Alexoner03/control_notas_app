import 'package:control_notas_flutter/src/models/course_model.dart';
import 'package:flutter/material.dart';

Future<void> notifyCourseDetail(BuildContext context,Course curso,String confirmText) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(curso.nombre,style: TextStyle(fontSize: 30)),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Fecha de Inicio : ${curso.inicio.year.toString().padLeft(4, '0')}-${curso.inicio.month.toString().padLeft(2, '0')}-${curso.inicio.day.toString().padLeft(2, '0')}',style: TextStyle(fontSize: 20),),
              Text('Fecha de Fin : ${curso.fin.year.toString().padLeft(4, '0')}-${curso.fin.month.toString().padLeft(2, '0')}-${curso.fin.day.toString().padLeft(2, '0')}',style: TextStyle(fontSize: 20),),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(confirmText,style: TextStyle(fontSize: 20)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}