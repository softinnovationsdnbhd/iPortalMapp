import 'dart:convert';

class DashboardData {
  String? weight;
  String? hargasemasa;
  String? hargaBelian;
  String? message;
  List<Drate>? drate;

  DashboardData(
      {this.weight,
      this.hargasemasa,
      this.hargaBelian,
      this.message,
      this.drate});

  DashboardData.fromJson(Map<String, dynamic> json) {
    weight = json['weight'];
    hargasemasa = json['Hargasemasa'];
    hargaBelian = json['HargaBelian'];
    message = json['message'];
    if (json['drate'] != null) {
      drate = <Drate>[];
      jsonDecode(json['drate']).forEach((v) {
        drate!.add(new Drate.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['weight'] = this.weight;
    data['Hargasemasa'] = this.hargasemasa;
    data['HargaBelian'] = this.hargaBelian;
    data['message'] = this.message;
    if (this.drate != null) {
      data['drate'] = this.drate!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Drate {
  String? description;
  String? buyrate;
  String? sellrate;

  Drate({this.description, this.buyrate, this.sellrate});

  Drate.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    buyrate = json['buyrate'];
    sellrate = json['sellrate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['buyrate'] = this.buyrate;
    data['sellrate'] = this.sellrate;
    return data;
  }
}
