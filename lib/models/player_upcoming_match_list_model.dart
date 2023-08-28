class PlayerUpcomingMatchListModel {
  bool? status;
  String? message;
  List<PlayerUpcomingMatch>? upcomingMatch;

  PlayerUpcomingMatchListModel({status, message, upcomingMatch});

  PlayerUpcomingMatchListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['upcoming_match'] != null) {
      upcomingMatch = <PlayerUpcomingMatch>[];
      json['upcoming_match'].forEach((v) {
        upcomingMatch!.add(new PlayerUpcomingMatch.fromJson(v));
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

class PlayerUpcomingMatch {
  int? id;
  int? groundId;
  int? teamAId;
  int? teamBId;
  String? bookingDate;
  String? bookingSlotStart;
  String? bookingSlotEnd;
  String? teamAName;
  String? teamBName;
  String? teamALogo;
  String? teamBLogo;
  String? groundName;
  String? mainImage;
  String? galleryImage;
  String? organizerName;
  String? formattedBookingDate;
  String? matchNumber;

  PlayerUpcomingMatch(
      {id,
        groundId,
        teamAId,
        teamBId,
        bookingDate,
        bookingSlotStart,
        bookingSlotEnd,
        teamAName,
        teamBName,
        teamALogo,
        teamBLogo,
        groundName,
        mainImage,
        galleryImage,
        organizerName,
        formattedBookingDate,
        matchNumber});

  PlayerUpcomingMatch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groundId = json['ground_id'];
    teamAId = json['team_a_id'];
    teamBId = json['team_b_id'];
    bookingDate = json['booking_date'];
    bookingSlotStart = json['booking_slot_start'];
    bookingSlotEnd = json['booking_slot_end'];
    teamAName = json['team_a_name'];
    teamBName = json['team_b_name'];
    teamALogo = json['team_a_logo'];
    teamBLogo = json['team_b_logo'];
    groundName = json['ground_name'];
    mainImage = json['main_image'];
    galleryImage = json['gallery_image'];
    organizerName = json['organizer_name'];
    formattedBookingDate = json['formatted_booking_date'];
    matchNumber = json['match_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['ground_id'] = groundId;
    data['team_a_id'] = teamAId;
    data['team_b_id'] = teamBId;
    data['booking_date'] = bookingDate;
    data['booking_slot_start'] = bookingSlotStart;
    data['booking_slot_end'] = bookingSlotEnd;
    data['team_a_name'] = teamAName;
    data['team_b_name'] = teamBName;
    data['team_a_logo'] = teamALogo;
    data['team_b_logo'] = teamBLogo;
    data['ground_name'] = groundName;
    data['main_image'] = mainImage;
    data['gallery_image'] = galleryImage;
    data['organizer_name'] = organizerName;
    data['formatted_booking_date'] = formattedBookingDate;
    data['match_number'] = matchNumber;
    return data;
  }
}
