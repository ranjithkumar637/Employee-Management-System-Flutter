class BookingHistoryListModel {
  bool? status;
  dynamic message;
  List<BookingHistory>? bookingHistory;

  BookingHistoryListModel({status, message, bookingHistory});

  BookingHistoryListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['booking_history'] != null) {
      bookingHistory = <BookingHistory>[];
      json['booking_history'].forEach((v) {
        bookingHistory!.add(new BookingHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (bookingHistory != null) {
      data['booking_history'] =
          bookingHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BookingHistory {
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
  dynamic matchNumber;

  BookingHistory(
      {matchId,
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
      matchNumber});

  BookingHistory.fromJson(Map<String, dynamic> json) {
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
    matchNumber = json['match_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['match_id'] = matchId;
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
    data['match_number'] = matchNumber;
    return data;
  }
}
