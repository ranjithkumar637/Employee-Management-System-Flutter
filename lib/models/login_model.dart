class LoginModel {
  bool? status;
  Data? data;
  String? message;

  LoginModel({status, data, message});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['data'] = data;
    data['message'] = message;
    return data;
  }
}

class Data {
  String? rememberToken;
  String? name;

  Data({rememberToken, name});

  Data.fromJson(Map<String, dynamic> json) {
    rememberToken = json['remember_token'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['remember_token'] = rememberToken;
    data['name'] = name;
    return data;
  }
}
