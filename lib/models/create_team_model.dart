class CreateTeamModel {
  bool? status;
  String? accessToken;
  Data? data;
  String? message;
  User? user;

  CreateTeamModel(
      {status, accessToken, data, message, user});

  CreateTeamModel.fromJson(Map<String, dynamic> json) {
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
  String? teamName;
  String? primaryContact;
  String? logo;
  String? captainName;
  String? captainPrimaryContact;
  String? captainLocation;
  String? viceCaptainName;
  String? viceCaptainPrimaryContact;
  String? viceCaptainLocation;
  String? adminName;
  String? adminPrimaryContact;
  String? qrCode;
  String? upiId;
  String? teamRefCode;
  dynamic captainId;
  String? updatedAt;
  String? createdAt;
  int? id;

  User(
      {teamName,
        primaryContact,
        logo,
        captainName,
        captainPrimaryContact,
        captainLocation,
        viceCaptainName,
        viceCaptainPrimaryContact,
        viceCaptainLocation,
        adminName,
        adminPrimaryContact,
        qrCode,
        upiId,
        teamRefCode,
        captainId,
        updatedAt,
        createdAt,
        id});

  User.fromJson(Map<String, dynamic> json) {
    teamName = json['team_name'];
    primaryContact = json['primary_contact'];
    logo = json['logo'];
    captainName = json['captain_name'];
    captainPrimaryContact = json['captain_primary_contact'];
    captainLocation = json['captain_location'];
    viceCaptainName = json['vice_captain_name'];
    viceCaptainPrimaryContact = json['vice_captain_primary_contact'];
    viceCaptainLocation = json['vice_captain_location'];
    adminName = json['admin_name'];
    adminPrimaryContact = json['admin_primary_contact'];
    qrCode = json['qr_code'];
    upiId = json['upi_id'];
    teamRefCode = json['team_ref_code'];
    captainId = json['captain_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['team_name'] = teamName;
    data['primary_contact'] = primaryContact;
    data['logo'] = logo;
    data['captain_name'] = captainName;
    data['captain_primary_contact'] = captainPrimaryContact;
    data['captain_location'] = captainLocation;
    data['vice_captain_name'] = viceCaptainName;
    data['vice_captain_primary_contact'] = viceCaptainPrimaryContact;
    data['vice_captain_location'] = viceCaptainLocation;
    data['admin_name'] = adminName;
    data['admin_primary_contact'] = adminPrimaryContact;
    data['qr_code'] = qrCode;
    data['upi_id'] = upiId;
    data['team_ref_code'] = teamRefCode;
    data['captain_id'] = captainId;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
