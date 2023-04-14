import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sql_conn/sql_conn.dart';

import '../../ui/screens/home_screen.dart';


class DatabaseManagerProvider extends ChangeNotifier{

  bool _connection = false;
  String _ip = '10.10.11.6';
  String _port = '1433';
  String _databasename = 'proyect';
  String _username= 'admin';
  String _password= '123456789';


  String get ip => _ip;
  String get port => _port;
  String get databasename => _databasename;
  String get username => _username;
  String get password => _password;
  bool get connection => _connection;
  
  
  set ip (String val) => _ip;
  set port (String val) => _port;
  set databasename (String val) => _databasename;
  set username (String val) => _username;
  set password (String val) => _password; 
  set connection(bool val) => _connection=val;


  Future<void> connect() async {
    debugPrint("Connecting...");
    try {
      await SqlConn.connect(
        ip: _ip,
        port: _port,
        databaseName: _databasename,
        username: _username,
        password: _password
      );
      connection = true;
      notifyListeners();
      debugPrint("Connected!");
    } catch (e) {
      await Future.delayed(const Duration(milliseconds: 100), (){});
      connection = false;
      notifyListeners();
      debugPrint(e.toString());
    } 
  }

  Future<void> read(String query) async {
    var res = await SqlConn.readData(query);
    debugPrint(res.toString());
  }

  Future<void> validarUsario(String email, String password, BuildContext context) async {

    var res = await SqlConn.readData('DECLARE @Valid BIT; EXEC ValidarUsuario @correo  = \'$email\', @pass = \'$password\', @Resultado = @Valid OUTPUT; SELECT @Valid AS Result;');

    String jsonString = res.toString();
    List<dynamic> parsedList = jsonDecode(jsonString);

    int result = parsedList[0]['Result']; // Accede al valor de la clave "Result"

    if (result==1){
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }else {
      debugPrint('Usuario Invalido');
    }
  }

  Future<void> write(String query) async {
    var res = await SqlConn.writeData(query);
    debugPrint(res.toString());
  }
}
