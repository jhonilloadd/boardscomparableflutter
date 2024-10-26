import 'dart:ffi';

class Board {
  Int? id;
  String? name;
  String? model;
  String? brand;

  Board({this.id, this.name, this.model, this.brand});

  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "model": model, "brand": brand};

  fromJson(Map<String, dynamic> json) {
    return Board(
        id: json["id"],
        name: json["name"],
        model: json["model"],
        brand: json["brand"]);
  }
}
