import 'package:control_notas_flutter/src/providers/user_provider.dart';
import 'package:control_notas_flutter/src/utils/close_sesion.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuWidgetAlumno extends StatelessWidget {

  final _color = Color.fromRGBO(0, 65, 101, 1);

  @override
  Widget build(BuildContext context) {

    final userProvider = Provider.of<UserProvider>(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Container(
              padding: EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/img/mobu.jpg'),
                    maxRadius: 30,
                  ),
                  Text(userProvider.user.nombres + ' ' + userProvider.user.apellidos, style: TextStyle(fontSize: 20,color: Colors.white)),
                  Text('@'+userProvider.user.codigo, style: TextStyle(fontSize: 18,color: Colors.white)),
                ]
              ),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/menu-img.jpg'),
                fit: BoxFit.cover
              )
            ),
          ),

          ListTile(
            leading: Icon(Icons.library_books, color: _color),
            title : Text('Cursos Disponibles'),
            onTap: (){
              Navigator.pushReplacementNamed(context, 'disponibles');
            },
          ),
          ListTile(
            leading: Icon(Icons.list, color: _color),
            title : Text('Cursos Matriculados'),
            onTap: (){
              Navigator.pushReplacementNamed(context, 'matriculados');
            },
          ),
          ListTile(
            leading: Icon(Icons.person, color: _color),
            title : Text('Ver Perfil'),
            onTap: (){
              Navigator.pushReplacementNamed(context, 'profilestudent');
            },
          ),
          ListTile(
            leading: Icon(Icons.close, color: _color),
            title : Text('Cerrar Sesión'),
            onTap: (){
              closeSesion(context);
            },
          ),

        ],
      ),
    );
  }
}