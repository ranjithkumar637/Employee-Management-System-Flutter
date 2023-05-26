class CityListModel {
  bool? status;
  String? message;
  List<CityList>? city;

  CityListModel({status, message, city});

  CityListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['city'] != null) {
      city = <CityList>[];
      json['city'].forEach((v) {
        city!.add(CityList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (city != null) {
      data['city'] = city!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CityList {
  int? id;
  String? cityName;

  CityList({id, cityName});

  CityList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cityName = json['city_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['city_name'] = cityName;
    return data;
  }
}
