import 'dart:convert';

List<Combustible> combustibleFromJson(String str) => List<Combustible>.from(
    json.decode(str).map((x) => Combustible.fromJson(x)));

String combustibleToJson(List<Combustible> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Combustible {
  int idCombustible;
  String nombre;

  Combustible({
    required this.idCombustible,
    required this.nombre,
  });

  factory Combustible.fromJson(Map<String, dynamic> json) => Combustible(
        idCombustible: json["idCombustible"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "idCombustible": idCombustible,
        "nombre": nombre,
      };
}
