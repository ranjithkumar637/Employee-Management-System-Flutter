class InTheOffingListModel {
  bool? status;
  dynamic message;
  List<Offings>? offings;

  InTheOffingListModel({status, message, offings});

  InTheOffingListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['offings'] != null) {
      offings = <Offings>[];
      json['offings'].forEach((v) {
        offings!.add(Offings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (offings != null) {
      data['offings'] = offings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Offings {
  dynamic matchId;
  dynamic teamAName;
  dynamic teamBName;
  dynamic teamALogo;
  dynamic teamBLogo;
  dynamic bookingDate;
  dynamic bookingSlotStart;
  dynamic cityId;
  dynamic stateId;
  dynamic cityName;
  dynamic stateName;

  Offings(
      {matchId,
        teamAName,
        teamBName,
        teamALogo,
        teamBLogo,
        bookingDate,
        bookingSlotStart,
        cityId,
        stateId,
        cityName,
        stateName});

  Offings.fromJson(Map<String, dynamic> json) {
    matchId = json['match_id'];
    teamAName = json['team_a_name'];
    teamBName = json['team_b_name'];
    teamALogo = json['team_a_logo'];
    teamBLogo = json['team_b_logo'];
    bookingDate = json['booking_date'];
    bookingSlotStart = json['booking_slot_start '];
    cityId = json['city_id'];
    stateId = json['state_id'];
    cityName = json['city_name'];
    stateName = json['state_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['match_id'] = matchId;
    data['team_a_name'] = teamAName;
    data['team_b_name'] = teamBName;
    data['team_a_logo'] = teamALogo;
    data['team_b_logo'] = teamBLogo;
    data['booking_date'] = bookingDate;
    data['booking_slot_start '] = bookingSlotStart;
    data['city_id'] = cityId;
    data['state_id'] = stateId;
    data['city_name'] = cityName;
    data['state_name'] = stateName;
    return data;
  }
}
