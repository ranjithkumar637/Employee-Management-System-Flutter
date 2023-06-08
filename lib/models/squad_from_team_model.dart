class SquadFromTeamModel {
  bool? status;
  String? message;
  List<CaptainData>? captainData;
  List<ViceCaptainData>? viceCaptainData;
  List<AdminData>? adminData;
  List<TeamPlayerList>? teamPlayerList;

  SquadFromTeamModel(
      {status,
        message,
        captainData,
        viceCaptainData,
        adminData,
        teamPlayerList});

  SquadFromTeamModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['captain_list'] != null) {
      captainData = <CaptainData>[];
      json['captain_list'].forEach((v) {
        captainData!.add(CaptainData.fromJson(v));
      });
    }
    if (json['vice_captain_list'] != null) {
      viceCaptainData = <ViceCaptainData>[];
      json['vice_captain_list'].forEach((v) {
        viceCaptainData!.add(ViceCaptainData.fromJson(v));
      });
    }
    if (json['admin_list'] != null) {
      adminData = <AdminData>[];
      json['admin_list'].forEach((v) {
        adminData!.add(AdminData.fromJson(v));
      });
    }
    if (json['team_player_list'] != null) {
      teamPlayerList = <TeamPlayerList>[];
      json['team_player_list'].forEach((v) {
        teamPlayerList!.add(TeamPlayerList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (captainData != null) {
      data['captain_data'] = captainData!.map((v) => v.toJson()).toList();
    }
    if (viceCaptainData != null) {
      data['vice_captain_data'] =
          viceCaptainData!.map((v) => v.toJson()).toList();
    }
    if (adminData != null) {
      data['admin_data'] = adminData!.map((v) => v.toJson()).toList();
    }
    if (teamPlayerList != null) {
      data['team_player_list'] =
          teamPlayerList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CaptainData {
  int? captainId;
  String? captainName;
  String? capProfileImg;
  String? captainRole;

  CaptainData(
      {captainId, captainName, capProfileImg, captainRole});

  CaptainData.fromJson(Map<String, dynamic> json) {
    captainId = json['captain_id'];
    captainName = json['captain_name'];
    capProfileImg = json['cap_profile_img'];
    captainRole = json['captain_role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['captain_id'] = captainId;
    data['captain_name'] = captainName;
    data['cap_profile_img'] = capProfileImg;
    data['captain_role'] = captainRole;
    return data;
  }
}

class ViceCaptainData {
  int? teamPlayerTableId;
  int? teamId;
  int? viceCaptainId;
  String? viceCaptainName;
  String? viceProfileImg;
  String? role;

  ViceCaptainData(
      {teamPlayerTableId,
        teamId,viceCaptainId,
        viceCaptainName,
        viceProfileImg,
        role});

  ViceCaptainData.fromJson(Map<String, dynamic> json) {
    viceCaptainId = json['vice_captain_id'];
    teamPlayerTableId = json['team_player_table_id'];
    teamId = json['team_id'];
    viceCaptainName = json['vice_captain_name'];
    viceProfileImg = json['vice_profile_img'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vice_captain_id'] = viceCaptainId;
    data['team_player_table_id'] = teamPlayerTableId;
    data['team_id'] = teamId;
    data['vice_captain_name'] = viceCaptainName;
    data['vice_profile_img'] = viceProfileImg;
    data['role'] = role;
    return data;
  }
}

class AdminData {
  int? teamPlayerTableId;
  int? teamId;
  int? adminId;
  String? adminName;
  String? adminProfileImg;
  String? adminRole;

  AdminData(
      {teamPlayerTableId,
        teamId,adminId, adminName, adminProfileImg, adminRole});

  AdminData.fromJson(Map<String, dynamic> json) {
    adminId = json['admin_id'];
    teamPlayerTableId = json['team_player_table_id'];
    teamId = json['team_id'];
    adminName = json['admin_name'];
    adminProfileImg = json['admin_profile_img'];
    adminRole = json['admin_role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['admin_id'] = adminId;
    data['team_player_table_id'] = teamPlayerTableId;
    data['team_id'] = teamId;
    data['admin_name'] = adminName;
    data['admin_profile_img'] = adminProfileImg;
    data['admin_role'] = adminRole;
    return data;
  }
}

class TeamPlayerList {
  int? teamPlayerTableId;
  int? teamId;
  int? playerId;
  String? playerName;
  String? profileImg;
  String? role;
  String? playerRole;

  TeamPlayerList(
      {teamPlayerTableId,
        teamId,
        playerId,
        playerName,
        profileImg,
        role,
        playerRole});

  TeamPlayerList.fromJson(Map<String, dynamic> json) {
    teamPlayerTableId = json['team_player_table_id'];
    teamId = json['team_id'];
    playerId = json['player_id'];
    playerName = json['player_name'];
    profileImg = json['profile_img'];
    role = json['role'];
    playerRole = json['player_role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['team_player_table_id'] = teamPlayerTableId;
    data['team_id'] = teamId;
    data['player_id'] = playerId;
    data['player_name'] = playerName;
    data['profile_img'] = profileImg;
    data['role'] = role;
    data['player_role'] = playerRole;
    return data;
  }
}
