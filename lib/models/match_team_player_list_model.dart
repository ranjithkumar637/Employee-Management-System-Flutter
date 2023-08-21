class MatchTeamPlayerListModel {
  bool? status;
  dynamic message;
  dynamic matchTeamPlayersCount;
  TeamData? teamData;
  MatchData? matchData;
  List<MatchTeamPlayerList>? matchTeamPlayerList;

  MatchTeamPlayerListModel(
      {status,
        message,
        teamData,
        matchTeamPlayersCount,
        matchData,
        matchTeamPlayerList});

  MatchTeamPlayerListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    teamData = json['team_data'] != null
        ? new TeamData.fromJson(json['team_data'])
        : null;
    matchTeamPlayersCount = json['matchTeamPlayersCount'];
    matchData = json['match_data'] != null
        ? MatchData.fromJson(json['match_data'])
        : null;
    if (json['player_list'] != null) {
      matchTeamPlayerList = <MatchTeamPlayerList>[];
      json['player_list'].forEach((v) {
        matchTeamPlayerList!.add(new MatchTeamPlayerList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.teamData != null) {
      data['team_data'] = this.teamData!.toJson();
    }
    data['matchTeamPlayersCount'] = matchTeamPlayersCount;
    if (matchData != null) {
      data['match_data'] = matchData!.toJson();
    }
    if (matchTeamPlayerList != null) {
      data['match_team_player_list'] =
          matchTeamPlayerList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TeamData {
  String? upiId;
  String? qrCode;

  TeamData({this.upiId, this.qrCode});

  TeamData.fromJson(Map<String, dynamic> json) {
    upiId = json['upi_id'];
    qrCode = json['qr_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['upi_id'] = this.upiId;
    data['qr_code'] = this.qrCode;
    return data;
  }
}

class MatchData {
  dynamic teamAFreeze;
  dynamic teamBFreeze;

  MatchData({teamAFreeze, teamBFreeze});

  MatchData.fromJson(Map<String, dynamic> json) {
    teamAFreeze = json['team_a_freeze'];
    teamBFreeze = json['team_b_freeze'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['team_a_freeze'] = teamAFreeze;
    data['team_b_freeze'] = teamBFreeze;
    return data;
  }
}

class MatchTeamPlayerList {
  dynamic id;
  dynamic playerId;
  dynamic role;
  dynamic playerStatus;
  dynamic availability;
  dynamic paidStatus;
  dynamic name;
  dynamic profilePhoto;
  dynamic battingRole;
  dynamic bowlingRole;
  dynamic wicketKeeper;
  dynamic allRounder;
  dynamic battingStyle;
  dynamic battingOrder;
  dynamic bowlingAction;
  dynamic bowlingStyle;
  dynamic bowlingProficiency;
  dynamic allRounderType;

  MatchTeamPlayerList(
      {id,
        playerId,
        role,
        playerStatus,
        availability,
        paidStatus,
        name,
        profilePhoto,
        battingRole,
        bowlingRole,
        wicketKeeper,
        allRounder,
        battingStyle,
        battingOrder,
        bowlingAction,
        bowlingStyle,
        bowlingProficiency,
        allRounderType});

  MatchTeamPlayerList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    playerId = json['player_id'];
    role = json['role'];
    playerStatus = json['player_status'];
    availability = json['availability'];
    paidStatus = json['paid_status'];
    name = json['name'];
    profilePhoto = json['profile_photo'];
    battingRole = json['batting_role'];
    bowlingRole = json['bowling_role'];
    wicketKeeper = json['wicket_keeper'];
    allRounder = json['all_rounder'];
    battingStyle = json['batting_style'];
    battingOrder = json['batting_order'];
    bowlingAction = json['bowling_action'];
    bowlingStyle = json['bowling_style'];
    bowlingProficiency = json['bowling_proficiency'];
    allRounderType = json['all_rounder_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['player_id'] = playerId;
    data['role'] = role;
    data['player_status'] = playerStatus;
    data['availability'] = availability;
    data['paid_status'] = paidStatus;
    data['name'] = name;
    data['profile_photo'] = profilePhoto;
    data['batting_role'] = battingRole;
    data['bowling_role'] = bowlingRole;
    data['wicket_keeper'] = wicketKeeper;
    data['all_rounder'] = allRounder;
    data['batting_style'] = battingStyle;
    data['batting_order'] = battingOrder;
    data['bowling_action'] = bowlingAction;
    data['bowling_style'] = bowlingStyle;
    data['bowling_proficiency'] = bowlingProficiency;
    data['all_rounder_type'] = allRounderType;
    return data;
  }
}
