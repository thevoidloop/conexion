import 'dart:convert';

List<DataPieModel> dataPieModelFromJson(String str) => List<DataPieModel>.from(
    json.decode(str).map((x) => DataPieModel.fromJson(x)));

String dataPieModelToJson(List<DataPieModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DataPieModel {
  String type;
  int data;

  DataPieModel({
    required this.type,
    required this.data,
  });

  factory DataPieModel.fromJson(Map<String, dynamic> json) => DataPieModel(
        type: json["TipoMantenimiento"],
        data: json["CantidadMantenimientos"],
      );

  Map<String, dynamic> toJson() => {
        "TipoMantenimiento": type,
        "CantidadMantenimientos": data,
      };
}
