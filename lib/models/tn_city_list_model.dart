class TNCityListModel {
  bool? status;
  String? message;
  List<TnCity>? tnCity;

  TNCityListModel({this.status, this.message, this.tnCity});

  TNCityListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['city'] != null) {
      tnCity = <TnCity>[];
      json['city'].forEach((v) {
        tnCity!.add(new TnCity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.tnCity != null) {
      data['city'] = this.tnCity!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TnCity {
  String? cityName;
  int? id;

  TnCity({this.cityName, this.id});

  TnCity.fromJson(Map<String, dynamic> json) {
    cityName = json['city_name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city_name'] = this.cityName;
    data['id'] = this.id;
    return data;
  }
}
