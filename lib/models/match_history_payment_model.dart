class MatchHistoryPaymentModel {
  bool? status;
  dynamic message;
  List<MatchHistory>? matchHistory;

  MatchHistoryPaymentModel({status, message, matchHistory});

  MatchHistoryPaymentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['match_history'] != null) {
      matchHistory = <MatchHistory>[];
      json['match_history'].forEach((v) {
        matchHistory!.add(new MatchHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (matchHistory != null) {
      data['match_history'] =
          matchHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MatchHistory {
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

  MatchHistory(
      {matchId,
        teamId,
        teamName,
        logo,
        bookingDate,
        bookingSlotStart,
        bookingSlotEnd,
        paidPrice,
        totalPrice,
        paidStatus});

  MatchHistory.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
