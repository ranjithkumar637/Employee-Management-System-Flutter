class RegistrationModel {
  bool? status;
  String? accessToken;
  Data? data;
  String? message;
  User? user;

  RegistrationModel(
      {status, accessToken, data, message, user});

  RegistrationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    accessToken = json['access_token'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['access_token'] = accessToken;
    data['data'] = data;
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class Data {
  String? name;

  Data({name});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}

class User {
  String? name;
  String? email;
  String? mobile;
  String? companyName;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? profilePhotoUrl;

  User(
      {name,
        email,
        mobile,
        companyName,
        updatedAt,
        createdAt,
        id,
        profilePhotoUrl});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    companyName = json['company_name'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    profilePhotoUrl = json['profile_photo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['company_name'] = companyName;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['profile_photo_url'] = profilePhotoUrl;
    return data;
  }
}
