class StateBasedCityListModel {
  bool? status;
  String? message;
  City? city;

  StateBasedCityListModel({status, message, city});

  StateBasedCityListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    city = json['city'] != null ? City.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (city != null) {
      data['city'] = city!.toJson();
    }
    return data;
  }
}

class City {
  List<Cities>? cities;

  City({cities});

  City.fromJson(Map<String, dynamic> json) {
    if (json['cities'] != null) {
      cities = <Cities>[];
      json['cities'].forEach((v) {
        cities!.add(Cities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cities != null) {
      data['cities'] = cities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cities {
  String? cityName;
  int? id;

  Cities({cityName, id});

  Cities.fromJson(Map<String, dynamic> json) {
    cityName = json['city_name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city_name'] = cityName;
    data['id'] = id;
    return data;
  }
}
