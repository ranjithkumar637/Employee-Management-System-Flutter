class UpcomingMatchesPaymentModel {
  bool? status;
  dynamic message;
  List<UpcomingMatches>? upcomingMatches;

  UpcomingMatchesPaymentModel(
      {status, message, upcomingMatches});

  UpcomingMatchesPaymentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['upcoming_matches'] != null) {
      upcomingMatches = <UpcomingMatches>[];
      json['upcoming_matches'].forEach((v) {
        upcomingMatches!.add(new UpcomingMatches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (upcomingMatches != null) {
      data['upcoming_matches'] =
          upcomingMatches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UpcomingMatches {
  dynamic matchId;
  dynamic teamId;
  dynamic teamName;
  dynamic logo;
  dynamic bookingDate;
  dynamic bookingSlotStart;
  dynamic bookingSlotEnd;
  dynamic paidPrice;
  dynamic totalPrice;
  dynamic paidStatus;
  dynamic matchNumber;

  UpcomingMatches(
      {matchId,
        teamId,
        teamName,
        logo,
        bookingDate,
        bookingSlotStart,
        bookingSlotEnd,
        paidPrice,
        totalPrice,
        paidStatus,
      matchNumber});

  UpcomingMatches.fromJson(Map<String, dynamic> json) {
    matchId = json['match_id'];
    teamId = json['team_id'];
    teamName = json['team_name'];
    logo = json['logo'];
    bookingDate = json['booking_date'];
    bookingSlotStart = json['booking_slot_start'];
    bookingSlotEnd = json['booking_slot_end'];
    paidPrice = json['paid_price'];
    totalPrice = json['total_price'];
    paidStatus = json['paid_status'];
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
    data['paid_price'] = paidPrice;
    data['total_price'] = totalPrice;
    data['paid_status'] = paidStatus;
    data['match_number'] = matchNumber;
    return data;
  }
}
