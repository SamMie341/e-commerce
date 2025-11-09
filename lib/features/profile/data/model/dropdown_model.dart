class UnitModel {
  final int id;
  final String name;
  final String code;

  UnitModel({
    required this.id,
    required this.name,
    required this.code,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) => UnitModel(
        id: json["id"],
        name: json["name"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
      };
}
