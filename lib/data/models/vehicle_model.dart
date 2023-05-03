import 'dart:convert';

class Vehicle {
  final int idVehicle;
  final String marca;
  final int modelo;
  final String placa;

  Vehicle({
    required this.idVehicle,
    required this.marca,
    required this.modelo,
    required this.placa,
  });

  // Método para convertir de un mapa a un objeto Vehicle
  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      idVehicle: map['idVehicle'],
      marca: map['marca'],
      modelo: map['modelo'],
      placa: map['placa'],
    );
  }

  // Método para convertir de un objeto Vehicle a un mapa
  Map<String, dynamic> toMap() {
    return {
      'idVehicle': idVehicle,
      'marca': marca,
      'modelo': modelo,
      'placa': placa,
    };
  }

  // Método para convertir una cadena JSON en un objeto Vehicle
  factory Vehicle.fromJson(String jsonString) {
    Map<String, dynamic> jsonData = jsonDecode(jsonString);
    return Vehicle.fromMap(jsonData);
  }

  // Método para convertir un objeto Vehicle en una cadena JSON
  String toJson() {
    Map<String, dynamic> jsonData = toMap();
    return jsonEncode(jsonData);
  }
}
