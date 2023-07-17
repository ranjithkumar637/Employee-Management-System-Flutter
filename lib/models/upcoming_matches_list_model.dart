import 'package:elevens_organizer/main.dart';

class UpcomingMatchesListModel {
  bool? status;
  String? message;
  List<UpcomingMatch>? upcomingMatch;

  UpcomingMatchesListModel({status, message, upcomingMatch});

  UpcomingMatchesListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['upcoming_match'] != null) {
      upcomingMatch = <UpcomingMatch>[];
      json['upcoming_match'].forEach((v) {
        upcomingMatch!.add(UpcomingMatch.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
  String? bookingDate;
  dynamic groundId;
  String? organizerName;
  String? groundName;
  String? groundImage;
  String? mainImage;
  dynamic teamAId;
  dynamic teamBId;
  String? teamAName;
  String? teamBName;
  String? bookingSlotStart;
  String? bookingSlotEnd;

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
        bookingSlotStart,
        bookingSlotEnd});

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
    bookingSlotStart = json['booking_slot_start'];
    bookingSlotEnd = json['booking_slot_end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    data['booking_slot_start'] = bookingSlotStart;
    data['booking_slot_end'] = bookingSlotEnd;
    return data;
  }
}
