import 'package:conexion/data/models/models.dart';
import 'package:flutter/material.dart';

class ServicesProviders extends ChangeNotifier {
  String _valueVehicle = "Seleccione una opcion";
  late List<Vehicle> _vehicle;
}
