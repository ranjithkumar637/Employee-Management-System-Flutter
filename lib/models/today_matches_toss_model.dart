class TodayMatchListForTossModel {
  bool? status;
  dynamic message;
  List<TodayMatches>? todayMatches;

  TodayMatchListForTossModel({this.status, this.message, this.todayMatches});

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
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.todayMatches != null) {
      data['today_matches'] =
          this.todayMatches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TodayMatches {
  TeamAData? teamAData;
  TeamAData? teamBData;

  TodayMatches({this.teamAData, this.teamBData});

  TodayMatches.fromJson(Map<String, dynamic> json) {
    teamAData = json['team_a_data'] != null
        ? new TeamAData.fromJson(json['team_a_data'])
        : null;
    teamBData = json['team_b_data'] != null
        ? new TeamAData.fromJson(json['team_b_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.teamAData != null) {
      data['team_a_data'] = this.teamAData!.toJson();
    }
    if (this.teamBData != null) {
      data['team_b_data'] = this.teamBData!.toJson();
    }
    return data;
  }
}

class TeamAData {
 dynamic matchId;
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

  TeamAData(
      {this.matchId,
        this.teamId,
        this.teamName,
        this.logo,
        this.bookingDate,
        this.bookingSlotStart,
        this.bookingSlotEnd,
        this.cityId,
        this.stateId,
        this.cityName,
        this.stateName});

  TeamAData.fromJson(Map<String, dynamic> json) {
    matchId = json['match_id'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['match_id'] = this.matchId;
    data['team_id'] = this.teamId;
    data['team_name'] = this.teamName;
    data['logo'] = this.logo;
    data['booking_date'] = this.bookingDate;
    data['booking_slot_start'] = this.bookingSlotStart;
    data['booking_slot_end'] = this.bookingSlotEnd;
    data['city_id'] = this.cityId;
    data['state_id'] = this.stateId;
    data['city_name'] = this.cityName;
    data['state_name'] = this.stateName;
    return data;
  }
}
