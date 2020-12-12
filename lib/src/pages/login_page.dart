import 'dart:io';

import 'package:control_notas_flutter/src/providers/auth_provider.dart';
import 'package:control_notas_flutter/src/providers/user_provider.dart';
import 'package:control_notas_flutter/src/shares_prefs/auth_prefs.dart';
import 'package:control_notas_flutter/src/utils/alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _color = Color.fromRGBO(0, 65, 101, 1);

  bool _emailval = false;
  bool _passvale = false;
  bool _disableLogin = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor:
            (Platform.isAndroid) ? Colors.transparent : Colors.white));

    final _screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: _color,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _crearTitle(),
          _crearBoxForm(_screenSize.width * 0.8, context)
        ],
      ),
    );
  }

  Widget _crearTitle() {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: Text('CIBERTEC',
          style: TextStyle(
            color: Colors.white,
            fontSize: 50,
            fontWeight: FontWeight.w900,
          )),
    );
  }

  Widget _crearBoxForm(double width,BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
              width: width,
              height: 470,
              decoration: BoxDecoration(color: Colors.white),
              child: _crearForm(context))),
    );
  }

  Widget _crearForm(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(40),
      child: Column(
        children: [
          Text('Ingrese su Correo y contraseña...',
              style: TextStyle(fontSize: 15)),
          SizedBox(height: 40),
          _crearInputEmail(),
          SizedBox(height: 40),
          _crearInputPassword(),
          SizedBox(height: 50),
          _crearLoginButton(context)
        ],
      ),
    );
  }

  Widget _crearInputEmail() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      controller: _email,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Email',
          errorText: _emailval ? 'Ingrese un email correcto' : null,
          prefixIcon: Icon(Icons.email)),
      onChanged: (value) {
        setState(() {
          _emailval = false;
        });
      },
    );
  }

  Widget _crearInputPassword() {
    return TextField(
      obscureText: true,
      controller: _password,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Password',
          prefixIcon: Icon(Icons.lock),
          errorText: _passvale ? 'Ingrese contraseña de 8 caracteres' : null),
      onChanged: (value) {
        setState(() {
          _passvale = false;
        });
      },
    );
  }

  Widget _crearLoginButton(BuildContext context) {
    return RaisedButton(
      color: _color,
      textColor: Colors.white,
      disabledTextColor: Colors.black,
      
      padding: EdgeInsets.all(15),
      onPressed: _disableLogin ? null : () {
        _validate(context);
      },
      child: Text(
        _disableLogin ? "Iniciando" : "Iniciar Sesión",
        style: TextStyle(fontSize: 30.0),
      ),
    );
  }

  void _validate(BuildContext context) async {
    setState(() => _disableLogin = true);
    
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    
    final emailregexp = RegExp(
        "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$");
    
    bool mailvalidate =
        _email.text.isNotEmpty && emailregexp.hasMatch(_email.text);
    bool passvalidate = _password.text.length >= 8;

    setState(() {
      mailvalidate ? _emailval = false : _emailval = true;
      passvalidate ? _passvale = false : _passvale = true;
    });

    if (mailvalidate && passvalidate) {
      await authProvider.login(_email.text, _password.text);
      if(authProvider.auth.res){
        final prefs = new PreferenciasUsuario();
        prefs.token = authProvider.auth.token;
        final user = await userProvider.getData(prefs.token);
        if(user == null){
          notifySimple(context, 'Error', 'Error Obteniendo los datos' , 'OK');
          setState(() => _disableLogin = false);
        }
        else{
          Navigator.pushReplacementNamed(context, 'home');
        }
      }else{
        notifySimple(context, 'Error', authProvider.auth.message , 'OK');
        setState(() => _disableLogin = false);
      }
    }
  }
}
