class UpcomingMatchesPaymentModel {
  bool? status;
  dynamic message;
  List<UpcomingMatches>? upcomingMatches;

  UpcomingMatchesPaymentModel(
      {this.status, this.message, this.upcomingMatches});

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
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.upcomingMatches != null) {
      data['upcoming_matches'] =
          this.upcomingMatches!.map((v) => v.toJson()).toList();
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

  UpcomingMatches(
      {this.matchId,
        this.teamId,
        this.teamName,
        this.logo,
        this.bookingDate,
        this.bookingSlotStart,
        this.bookingSlotEnd,
        this.paidPrice,
        this.totalPrice,
        this.paidStatus});

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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['match_id'] = this.matchId;
    data['team_id'] = this.teamId;
    data['team_name'] = this.teamName;
    data['logo'] = this.logo;
    data['booking_date'] = this.bookingDate;
    data['booking_slot_start'] = this.bookingSlotStart;
    data['booking_slot_end'] = this.bookingSlotEnd;
    data['paid_price'] = this.paidPrice;
    data['total_price'] = this.totalPrice;
    data['paid_status'] = this.paidStatus;
    return data;
  }
}
