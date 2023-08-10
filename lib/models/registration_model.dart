class RegistrationModel {
  bool? status;
  dynamic message;
  dynamic token;
  User? user;

  RegistrationModel({status, message, token, user});

  RegistrationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  dynamic name;
  dynamic email;
  dynamic mobileNo;
  dynamic otp;
  dynamic organizerDeviceToken;
  dynamic updatedAt;
  dynamic createdAt;
  dynamic id;
  dynamic profilePhotoUrl;
  List<Roles>? roles;

  User(
      {name,
        email,
        mobileNo,
        otp,
        organizerDeviceToken,
        updatedAt,
        createdAt,
        id,
        profilePhotoUrl,
        roles});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    mobileNo = json['mobile_no'];
    otp = json['otp'];
    organizerDeviceToken = json['organizer_device_token'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    profilePhotoUrl = json['profile_photo_url'];
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(new Roles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['email'] = email;
    data['mobile_no'] = mobileNo;
    data['otp'] = otp;
    data['organizer_device_token'] = organizerDeviceToken;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['profile_photo_url'] = profilePhotoUrl;
    if (roles != null) {
      data['roles'] = roles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Roles {
  dynamic id;
  dynamic name;
  dynamic guardName;
  dynamic createdAt;
  dynamic updatedAt;
  Pivot? pivot;

  Roles(
      {id,
        name,
        guardName,
        createdAt,
        updatedAt,
        pivot});

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    guardName = json['guard_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['guard_name'] = guardName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  dynamic modelId;
  dynamic roleId;
  dynamic modelType;

  Pivot({modelId, roleId, modelType});

  Pivot.fromJson(Map<String, dynamic> json) {
    modelId = json['model_id'];
    roleId = json['role_id'];
    modelType = json['model_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['model_id'] = modelId;
    data['role_id'] = roleId;
    data['model_type'] = modelType;
    return data;
  }
}
