class RecentBookingListModel {
  bool? status;
  dynamic message;
  List<RecentBooking>? recentBooking;

  RecentBookingListModel({status, message, recentBooking});

  RecentBookingListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['recent_booking'] != null) {
      recentBooking = <RecentBooking>[];
      json['recent_booking'].forEach((v) {
        recentBooking!.add(new RecentBooking.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (recentBooking != null) {
      data['recent_booking'] =
          recentBooking!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RecentBooking {
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

  RecentBooking(
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
        stateName});

  RecentBooking.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
