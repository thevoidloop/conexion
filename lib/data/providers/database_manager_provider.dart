import 'dart:convert';
import 'package:conexion/app/routes/routes.dart';
import 'package:conexion/data/models/option_model.dart';
import 'package:flutter/material.dart';
import 'package:sql_conn/sql_conn.dart';


class DatabaseManagerProvider extends ChangeNotifier{

  bool connection = false;
  late int _id;
  final String _ip = '10.10.11.6';
  final String _port = '1433';
  final String _databasename = 'proyect';
  final String _username= 'admin';
  final String _password= '123456789';
  late List<Option> _options;

  List<Option> get options => _options;
  
  
  set ip (String val) => _ip;
  set port (String val) => _port;
  set databasename (String val) => _databasename;
  set username (String val) => _username;
  set password (String val) => _password;


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

    var res = await SqlConn.readData('SELECT dbo.ValidateUserGetId(\'$email\', \'$password\') AS Result;');

    String jsonString = res.toString();
    List<dynamic> parsedList = jsonDecode(jsonString);

    int result = parsedList[0]['Result']; // Accede al valor de la clave "Result"

    if (result!=0){
      _id = result;
      await getOptionsByUserId();
      Navigator.pushReplacementNamed(context, AppRoutes.home);
      debugPrint(_id.toString());
    }else {
      debugPrint('Usuario Invalido');
    }
  }

  Future<void> write(String query) async {
    var res = await SqlConn.writeData(query);
    debugPrint(res.toString());
  }

  Future<void> getOptionsByUserId() async {
    var res = await SqlConn.readData('SELECT * FROM dbo.GetUserOptions($_id);');
    List<dynamic> jsonResponse = json.decode(res.toString());
    _options = jsonResponse.map((map) => Option.fromJson(map)).toList();
    debugPrint(res.toString());
  }



}
