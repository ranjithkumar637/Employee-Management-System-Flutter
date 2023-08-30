class TodayMatchListForTossModel {
  bool? status;
  dynamic message;
  List<TodayMatches>? todayMatches;

  TodayMatchListForTossModel({status, message, todayMatches});

  TodayMatchListForTossModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['today_matches'] != null) {
      todayMatches = <TodayMatches>[];
      json['today_matches'].forEach((v) {
        todayMatches!.add(new TodayMatches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (todayMatches != null) {
      data['today_matches'] =
          todayMatches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TodayMatches {
  TeamAData? teamAData;
  TeamAData? teamBData;
  dynamic freezeCount;

  TodayMatches({teamAData, teamBData, freezeCount});

  TodayMatches.fromJson(Map<String, dynamic> json) {
    teamAData = json['team_a_data'] != null
        ? new TeamAData.fromJson(json['team_a_data'])
        : null;
    teamBData = json['team_b_data'] != null
        ? new TeamAData.fromJson(json['team_b_data'])
        : null;
    freezeCount = json['freeze_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (teamAData != null) {
      data['team_a_data'] = teamAData!.toJson();
    }
    if (teamBData != null) {
      data['team_b_data'] = teamBData!.toJson();
    }
    data['freeze_count'] = freezeCount;
    return data;
  }
}

class TeamAData {
  dynamic matchId;
  dynamic captainMobileNo;
  dynamic teamId;
  dynamic teamName;
  dynamic logo;
  dynamic bookingDate;
  dynamic bookingSlotStart;
  dynamic bookingSlotEnd;
  dynamic cityId;
  dynamic stateId;
  dynamic cityName;
  dynamic stateName;
  dynamic teamFreeze;

  TeamAData(
      {matchId,
        captainMobileNo,
        teamId,
        teamName,
        logo,
        bookingDate,
        bookingSlotStart,
        bookingSlotEnd,
        cityId,
        stateId,
        cityName,
        stateName,
        teamFreeze});

  TeamAData.fromJson(Map<String, dynamic> json) {
    matchId = json['match_id'];
    captainMobileNo = json['captain_mobile_no'];
    teamId = json['team_id'];
    teamName = json['team_name'];
    logo = json['logo'];
    bookingDate = json['booking_date'];
    bookingSlotStart = json['booking_slot_start'];
    bookingSlotEnd = json['booking_slot_end'];
    cityId = json['city_id'];
    stateId = json['state_id'];
    cityName = json['city_name'];
    stateName = json['state_name'];
    teamFreeze = json['team_freeze'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['match_id'] = matchId;
    data['captain_mobile_no'] = captainMobileNo;
    data['team_id'] = teamId;
    data['team_name'] = teamName;
    data['logo'] = logo;
    data['booking_date'] = bookingDate;
    data['booking_slot_start'] = bookingSlotStart;
    data['booking_slot_end'] = bookingSlotEnd;
    data['city_id'] = cityId;
    data['state_id'] = stateId;
    data['city_name'] = cityName;
    data['state_name'] = stateName;
    data['team_freeze'] = teamFreeze;
    return data;
  }
}
