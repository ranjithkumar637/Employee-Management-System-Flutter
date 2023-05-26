class TeamListModel {
  bool? status;
  String? message;
  List<TeamList>? teamList;

  TeamListModel({status, message, teamList});

  TeamListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['team_list'] != null) {
      teamList = <TeamList>[];
      json['team_list'].forEach((v) {
        teamList!.add(TeamList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (teamList != null) {
      data['team_list'] = teamList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TeamList {
  int? id;
  String? teamName;
  String? logo;
  String? teamRefCode;
  String? qrCode;

  TeamList({id, teamName, logo, teamRefCode, qrCode});

  TeamList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teamName = json['team_name'];
    logo = json['logo'];
    teamRefCode = json['team_ref_code'];
    qrCode = json['qr_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['team_name'] = teamName;
    data['logo'] = logo;
    data['team_ref_code'] = teamRefCode;
    data['qr_code'] = qrCode;
    return data;
  }
}
