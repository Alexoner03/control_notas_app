import 'package:control_notas_flutter/src/providers/course_provider.dart';
import 'package:control_notas_flutter/src/shares_prefs/auth_prefs.dart';
import 'package:control_notas_flutter/src/utils/alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CalificatorWidget extends StatefulWidget {
  final int code;
  final int nota;
  final int course;
  CalificatorWidget({Key key, @required this.code, @required this.nota, @required this.course}) : super(key: key);

  @override
  _CalificatorWidgetState createState() => _CalificatorWidgetState(this.nota);
}

class _CalificatorWidgetState extends State<CalificatorWidget> {

  int _nota;
  bool _cargando = false;
  final prefs = new PreferenciasUsuario();
  _CalificatorWidgetState(this._nota);


  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseProvider>(context);
    return Row(
      children: [
        IconButton(icon: Icon(Icons.remove_circle), onPressed: (){
          setState(() {
            if(_nota > 0){
              _nota -= 1;
            }
          });
        }),
        Container(
          child: Text(_nota.toString()),
        ),
        IconButton(icon: Icon(Icons.add_circle), onPressed: (){
          setState(() {
            if(_nota < 20){
              _nota += 1;
            }
          });
        }),
        IconButton(icon: Icon(Icons.save), onPressed: _cargando ? null : () async {
          setState(() {
            _cargando = true;
          });
          final res = await courseProvider.setNota(widget.course, widget.code, _nota, prefs.token);
          setState(() {
            _cargando = false;
          });

          if(res){
            notifySimple(context, 'Correcto', 'la nota ha sido subida correctamente', 'ok');
            return res;
          }
          notifySimple(context, 'Error', 'Hubo un error, profe no me jale', 'ok');
          return res;
        }),
      ],
    );
  }
}