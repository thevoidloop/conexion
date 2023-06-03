import 'dart:convert';

List<DataCombustibleMes> dataCombustibleMesFromJson(String str) =>
    List<DataCombustibleMes>.from(
        json.decode(str).map((x) => DataCombustibleMes.fromJson(x)));

String dataCombustibleMesToJson(List<DataCombustibleMes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DataCombustibleMes {
  int mes;
  double totalGastado;
  String name = '';

  DataCombustibleMes({
    required this.mes,
    required this.totalGastado,
  });

  factory DataCombustibleMes.fromJson(Map<String, dynamic> json) =>
      DataCombustibleMes(
        mes: json["Mes"],
        totalGastado: json["TotalGastado"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "Mes": mes,
        "TotalGastado": totalGastado,
      };

  String asignarMes(int mes) {
    switch (mes) {
      case 1:
        return 'Enero';
      case 2:
        return 'Febrero';
      case 3:
        return 'Marzo';
      case 4:
        return 'Abril';
      case 5:
        return 'Mayo';
      case 6:
        return 'Junio';
      case 7:
        return 'Julio';
      case 8:
        return 'Agosto';
      case 9:
        return 'Septiembre';
      case 10:
        return 'Octubre';
      case 11:
        return 'Noviembre';
      case 12:
        return 'Diciembre';
      default:
        return '';
    }
  }
}
