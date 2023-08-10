class LoginModel {
  bool? status;
  dynamic message;
  User? user;
  dynamic token;

  LoginModel({status, message, user, token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class User {
  dynamic id;
  dynamic name;
  dynamic email;
  dynamic emailVerifiedAt;
  dynamic dob;
  dynamic twoFactorConfirmedAt;
  dynamic mobileNo;
  dynamic alterMobileNo;
  dynamic captainDeviceToken;
  dynamic playerDeviceToken;
  dynamic organizerDeviceToken;
  dynamic viceCaptainDeviceToken;
  dynamic adminDeviceToken;
  dynamic profilePhoto;
  dynamic otp;
  dynamic active;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic profilePhotoUrl;

  User(
      {id,
        name,
        email,
        emailVerifiedAt,
        dob,
        twoFactorConfirmedAt,
        mobileNo,
        alterMobileNo,
        captainDeviceToken,
        playerDeviceToken,
        organizerDeviceToken,
        viceCaptainDeviceToken,
        adminDeviceToken,
        profilePhoto,
        otp,
        active,
        createdAt,
        updatedAt,
        profilePhotoUrl});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    dob = json['dob'];
    twoFactorConfirmedAt = json['two_factor_confirmed_at'];
    mobileNo = json['mobile_no'];
    alterMobileNo = json['alter_mobile_no'];
    captainDeviceToken = json['captain_device_token'];
    playerDeviceToken = json['player_device_token'];
    organizerDeviceToken = json['organizer_device_token'];
    viceCaptainDeviceToken = json['vice_captain_device_token'];
    adminDeviceToken = json['admin_device_token'];
    profilePhoto = json['profile_photo'];
    otp = json['otp'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profilePhotoUrl = json['profile_photo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['dob'] = dob;
    data['two_factor_confirmed_at'] = twoFactorConfirmedAt;
    data['mobile_no'] = mobileNo;
    data['alter_mobile_no'] = alterMobileNo;
    data['captain_device_token'] = captainDeviceToken;
    data['player_device_token'] = playerDeviceToken;
    data['organizer_device_token'] = organizerDeviceToken;
    data['vice_captain_device_token'] = viceCaptainDeviceToken;
    data['admin_device_token'] = adminDeviceToken;
    data['profile_photo'] = profilePhoto;
    data['otp'] = otp;
    data['active'] = active;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['profile_photo_url'] = profilePhotoUrl;
    return data;
  }
}
