import 'package:elevens_organizer/main.dart';

class OrganizerMatchHistoryModel {
  bool? status;
  String? message;
  List<MatchHistoryList>? matchHistory;

  OrganizerMatchHistoryModel({status, message, matchHistory});

  OrganizerMatchHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['match_history'] != null) {
      matchHistory = <MatchHistoryList>[];
      json['match_history'].forEach((v) {
        matchHistory!.add(MatchHistoryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (matchHistory != null) {
      data['match_history'] =
          matchHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MatchHistoryList {
  int? id;
  String? groundImage;
  String? mainImage;
  String? organizerName;
  String? groundName;
  String? teamAName;
  String? teamBName;
  String? bookingDate;
  String? bookingSlotStart;
  String? bookingSlotEnd;
  String? filterDate;

  MatchHistoryList(
      {id,
        groundImage,
        organizerName,
        mainImage,
        groundName,
        teamAName,
        teamBName,
        bookingDate,
        bookingSlotStart,
        bookingSlotEnd,
        filterDate});

  MatchHistoryList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groundImage = json['ground_image'];
    mainImage = json['main_image'];
    organizerName = json['organizer_name'];
    groundName = json['ground_name'];
    teamAName = json['team_a_name'];
    teamBName = json['team_b_name'];
    bookingDate = json['booking_date'];
    bookingSlotStart = json['booking_slot_start'];
    bookingSlotEnd = json['booking_slot_end'];
    filterDate = json['filter_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ground_image'] = groundImage;
    data['main_image'] = mainImage;
    data['organizer_name'] = organizerName;
    data['ground_name'] = groundName;
    data['team_a_name'] = teamAName;
    data['team_b_name'] = teamBName;
    data['booking_date'] = bookingDate;
    data['booking_slot_start'] = bookingSlotStart;
    data['booking_slot_end'] = bookingSlotEnd;
    data['filter_date'] = filterDate;
    return data;
  }
}
