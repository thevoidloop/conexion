import 'dart:convert';
import 'package:conexion/app/routes/routes.dart';
import 'package:conexion/data/models/combustible_model.dart';
import 'package:conexion/data/models/option_model.dart';
import 'package:conexion/data/models/vehicle_model.dart';
import 'package:flutter/material.dart';
import 'package:sql_conn/sql_conn.dart';

class DatabaseManagerProvider extends ChangeNotifier {
  bool connection = false;
  late int _id;
  String _ip = '192.168.0.5';
  final String _port = '1433';
  final String _databasename = 'proyect';
  final String _username = 'admin';
  final String _password = '123456789';
  String _valueVehicle = "Seleccione una opcion";
  String _valueCombustible = "Seleccione una opcion";
  late List<Option> _options;
  late List<Vehicle> _vehicle;
  late List<Combustible> _combustible;

  String get valueCombustible => _valueCombustible;
  List<Combustible> get combustible => _combustible;
  List<Option> get options => _options;
  List<Vehicle> get vehicle => _vehicle;
  String get ip => _ip;
  String get valueVehicle => _valueVehicle;

  set valueCombustible(String value) => _valueCombustible = value;
  set ip(String val) => _ip = val;
  set valueVehicle(String val) => _valueVehicle = val;
  set combustible(List<Combustible> value) => _combustible = value;

  Future<void> connect() async {
    debugPrint("Connecting...");
    try {
      await SqlConn.connect(
          ip: _ip,
          port: _port,
          databaseName: _databasename,
          username: _username,
          password: _password);
      connection = true;
      notifyListeners();
      debugPrint("Connected!");
    } catch (e) {
      await Future.delayed(const Duration(milliseconds: 100), () {});
      connection = false;
      notifyListeners();
      debugPrint(e.toString());
    }
  }

  Future<void> read(String query) async {
    var res = await SqlConn.readData(query);
    debugPrint(res.toString());
  }

  Future<void> validarUsario(
      String email, String password, BuildContext context) async {
    var res = await SqlConn.readData(
        'SELECT dbo.ValidateUserGetId(\'$email\', \'$password\') AS Result;');

    String jsonString = res.toString();
    List<dynamic> parsedList = jsonDecode(jsonString);

    int result =
        parsedList[0]['Result']; // Accede al valor de la clave "Result"

    if (result != 0) {
      _id = result;
      await getOptionsByUserId();
      await getVehicle();
      await getCombustible();
      await agregarInicioSesion(_id);
      Navigator.pushReplacementNamed(context, AppRoutes.home);
      debugPrint(_id.toString());
    } else {
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

  Future<void> getVehicle() async {
    var res = await SqlConn.readData('SELECT * FROM tbVehicle');
    List<dynamic> vehiclesMapList = json.decode(res.toString());
    _vehicle = vehiclesMapList.map((map) => Vehicle.fromMap(map)).toList();
  }

  Future<void> agregarInicioSesion(int idUser) async {
    var res =
        await SqlConn.writeData('EXEC AgregarInicioSesion @Usuario = $idUser;');
    debugPrint(res.toString());
  }

  Future<void> getCombustible() async {
    var res = await SqlConn.readData('SELECT * FROM tbCombustible');
    _combustible = combustibleFromJson(res);

    debugPrint(_combustible[0].nombre);
  }

  Future<void> ingresarRegistroCombustible(
    String vale,
    String fecha,
    String galones,
    String kmVehiculo,
    String totalVale,
  ) async {
    String query = '''DECLARE @insertStatus NVARCHAR(250);
      EXEC AgregarRegistroCombustible
          @idUsuario = $_id,
          @idVehiculo = $_valueVehicle,
          @idCombustible = $_valueCombustible,
          @numeroVale = $vale,
          @fecha = '$fecha',
          @cantidadGalones = $galones, 
          @kmVehiculo = $kmVehiculo,
          @totalVale = $totalVale, 
          @status = @insertStatus OUTPUT;
      SELECT @insertStatus AS Status;''';
    var res = await SqlConn.writeData(query);
    debugPrint(res.toString());
  }
}
