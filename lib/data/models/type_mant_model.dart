class TypeMan {
  final int idType;
  final String type;

  TypeMan({
    required this.idType,
    required this.type,
  });

  factory TypeMan.fromJson(Map<String, dynamic> json) {
    return TypeMan(
      idType: json['idTipoMan'],
      type: json['nombre'],
    );
  }
}
