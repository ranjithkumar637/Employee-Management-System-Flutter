class PlayerInfoModel {
  bool? status;
  dynamic message;
  dynamic playerInfo;

  PlayerInfoModel({status, message, playerInfo});

  PlayerInfoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    playerInfo = json['player-info'] != null
        ? new PlayerInfo.fromJson(json['player-info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (playerInfo != null) {
      data['player-info'] = playerInfo!.toJson();
    }
    return data;
  }
}

class PlayerInfo {
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

  PlayerInfo(
      {name,
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

  PlayerInfo.fromJson(Map<String, dynamic> json) {
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
