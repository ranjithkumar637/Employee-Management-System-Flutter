class UpcomingMatchListModel {
  bool? status;
  dynamic message;
  List<UpcomingMatch>? upcomingMatch;

  UpcomingMatchListModel({status, message, upcomingMatch});

  UpcomingMatchListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['upcoming_match'] != null) {
      upcomingMatch = <UpcomingMatch>[];
      json['upcoming_match'].forEach((v) {
        upcomingMatch!.add(new UpcomingMatch.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (upcomingMatch != null) {
      data['upcoming_match'] =
          upcomingMatch!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UpcomingMatch {
  dynamic matchId;
  dynamic bookingDate;
  dynamic groundId;
  dynamic organizerName;
  dynamic groundName;
  dynamic groundImage;
  dynamic mainImage;
  dynamic teamAId;
  dynamic teamBId;
  dynamic teamAName;
  dynamic teamBName;
  dynamic teamALogo;
  dynamic teamBLogo;
  dynamic bookingSlotStart;
  dynamic bookingSlotEnd;
  dynamic matchNumber;
  dynamic matchStatus;
  dynamic live;

  UpcomingMatch(
      {matchId,
        bookingDate,
        groundId,
        organizerName,
        groundName,
        groundImage,
        mainImage,
        teamAId,
        teamBId,
        teamAName,
        teamBName,
        teamALogo,
        teamBLogo,
        bookingSlotStart,
        bookingSlotEnd, matchNumber, matchStatus, live});

  UpcomingMatch.fromJson(Map<String, dynamic> json) {
    matchId = json['match_id'];
    bookingDate = json['booking_date'];
    groundId = json['ground_id'];
    organizerName = json['organizer_name'];
    groundName = json['ground_name'];
    groundImage = json['ground_image'];
    mainImage = json['main_image'];
    teamAId = json['team_a_id'];
    teamBId = json['team_b_id'];
    teamAName = json['team_a_name'];
    teamBName = json['team_b_name'];
    teamALogo = json['team_a_logo'];
    teamBLogo = json['team_b_logo'];
    bookingSlotStart = json['booking_slot_start'];
    bookingSlotEnd = json['booking_slot_end'];
    matchNumber = json['match_number'];
    matchStatus = json['match_status'];
    live = json['live'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['match_id'] = matchId;
    data['booking_date'] = bookingDate;
    data['ground_id'] = groundId;
    data['organizer_name'] = organizerName;
    data['ground_name'] = groundName;
    data['ground_image'] = groundImage;
    data['main_image'] = mainImage;
    data['team_a_id'] = teamAId;
    data['team_b_id'] = teamBId;
    data['team_a_name'] = teamAName;
    data['team_b_name'] = teamBName;
    data['team_a_logo'] = teamALogo;
    data['team_b_logo'] = teamBLogo;
    data['booking_slot_start'] = bookingSlotStart;
    data['booking_slot_end'] = bookingSlotEnd;
    data['match_number'] = matchNumber;
    data['match_status'] = matchStatus;
    data['live'] = live;
    return data;
  }
}
