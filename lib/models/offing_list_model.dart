class OffingsListModel {
  bool? status;
  dynamic message;
  List<OffingsList>? offings;

  OffingsListModel({status, message, offings});

  OffingsListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['offings'] != null) {
      offings = <OffingsList>[];
      json['offings'].forEach((v) {
        offings!.add(new OffingsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (offings != null) {
      data['offings'] = offings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OffingsList {
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
  dynamic groundName;
  dynamic organizerName;
  dynamic groundImage;
  dynamic matchNumber;

  OffingsList(
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
        stateName,
      groundName, organizerName, groundImage, matchNumber});

  OffingsList.fromJson(Map<String, dynamic> json) {
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
    groundName = json['ground_name'];
    organizerName = json['organizer_name'];
    groundImage = json['ground_image'];
    matchNumber = json['match_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['ground_name'] = groundName;
    data['organizer_name'] = organizerName;
    data['ground_name'] = groundName;
    data['ground_image'] = groundImage;
    data['match_number'] = matchNumber;
    return data;
  }
}
