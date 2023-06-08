class TeamViewModel {
  bool? status;
  String? message;
  TeamDetails? teamDetails;

  TeamViewModel({status, message, teamDetails});

  TeamViewModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    teamDetails = json['team_details'] != null
        ? TeamDetails.fromJson(json['team_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (teamDetails != null) {
      data['team_details'] = teamDetails!.toJson();
    }
    return data;
  }
}

class TeamDetails {
  int? id;
  String? teamName;
  String? primaryContact;
  String? secondaryContact;
  String? logo;
  String? teamRefCode;
  String? captainName;
  String? captainPrimaryContact;
  String? captainSecondaryContact;
  String? viceCaptainName;
  String? viceCaptainPrimaryContact;
  String? viceCaptainSecondaryContact;
  String? adminName;
  String? adminPrimaryContact;
  String? adminSecondaryContact;
  String? qrCode;
  String? upiId;

  TeamDetails(
      {id,
        teamName,
        primaryContact,
        secondaryContact,
        logo,
        teamRefCode,
        captainName,
        captainPrimaryContact,
        captainSecondaryContact,
        viceCaptainName,
        viceCaptainPrimaryContact,
        viceCaptainSecondaryContact,
        adminName,
        adminPrimaryContact,
        adminSecondaryContact,
        qrCode,
        upiId});

  TeamDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teamName = json['team_name'];
    primaryContact = json['primary_contact'];
    secondaryContact = json['secondary_contact'];
    logo = json['logo'];
    teamRefCode = json['team_ref_code'];
    captainName = json['captain_name'];
    captainPrimaryContact = json['captain_primary_contact'];
    captainSecondaryContact = json['captain_secondary_contact'];
    viceCaptainName = json['vice_captain_name'];
    viceCaptainPrimaryContact = json['vice_captain_primary_contact'];
    viceCaptainSecondaryContact = json['vice_captain_secondary_contact'];
    adminName = json['admin_name'];
    adminPrimaryContact = json['admin_primary_contact'];
    adminSecondaryContact = json['admin_secondary_contact'];
    qrCode = json['qr_code'];
    upiId = json['upi_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['team_name'] = teamName;
    data['primary_contact'] = primaryContact;
    data['secondary_contact'] = secondaryContact;
    data['logo'] = logo;
    data['team_ref_code'] = teamRefCode;
    data['captain_name'] = captainName;
    data['captain_primary_contact'] = captainPrimaryContact;
    data['captain_secondary_contact'] = captainSecondaryContact;
    data['vice_captain_name'] = viceCaptainName;
    data['vice_captain_primary_contact'] = viceCaptainPrimaryContact;
    data['vice_captain_secondary_contact'] = viceCaptainSecondaryContact;
    data['admin_name'] = adminName;
    data['admin_primary_contact'] = adminPrimaryContact;
    data['admin_secondary_contact'] = adminSecondaryContact;
    data['qr_code'] = qrCode;
    data['upi_id'] = upiId;
    return data;
  }
}
