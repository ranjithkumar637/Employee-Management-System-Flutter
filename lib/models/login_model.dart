class LoginModel {
  bool? status;
  String? message;
  User? user;
  String? token;

  LoginModel({this.status, this.message, this.user, this.token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? dob;
  String? mobileNo;
  String? alterMobileNo;
  String? twoFactorConfirmedAt;
  String? profilePhoto;
  int? otp;
  int? active;
  String? createdAt;
  String? updatedAt;
  String? profilePhotoUrl;

  User(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.dob,
        this.mobileNo,
        this.alterMobileNo,
        this.twoFactorConfirmedAt,
        this.profilePhoto,
        this.otp,
        this.active,
        this.createdAt,
        this.updatedAt,
        this.profilePhotoUrl});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    dob = json['dob'];
    mobileNo = json['mobile_no'];
    alterMobileNo = json['alter_mobile_no'];
    twoFactorConfirmedAt = json['two_factor_confirmed_at'];
    profilePhoto = json['profile_photo'];
    otp = json['otp'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profilePhotoUrl = json['profile_photo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['dob'] = this.dob;
    data['mobile_no'] = this.mobileNo;
    data['alter_mobile_no'] = this.alterMobileNo;
    data['two_factor_confirmed_at'] = this.twoFactorConfirmedAt;
    data['profile_photo'] = this.profilePhoto;
    data['otp'] = this.otp;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['profile_photo_url'] = this.profilePhotoUrl;
    return data;
  }
}
