class RevenueTeamListModel {
  bool? status;
  dynamic message;
  dynamic totalRevenue;
  List<TeamsList>? teamsList;

  RevenueTeamListModel(
      {this.status, this.message, this.totalRevenue, this.teamsList});

  RevenueTeamListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    totalRevenue = json['total_revenue'];
    if (json['teams_list'] != null) {
      teamsList = <TeamsList>[];
      json['teams_list'].forEach((v) {
        teamsList!.add(new TeamsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['total_revenue'] = this.totalRevenue;
    if (this.teamsList != null) {
      data['teams_list'] = this.teamsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TeamsList {
  dynamic matchId;
  dynamic teamId;
  dynamic teamName;
  dynamic logo;
  dynamic totalPrice;
  dynamic paidPrice;
  dynamic paidStatus;
  dynamic bookingDate;
  dynamic bookingSlotStart;
  dynamic bookingSlotEnd;
  dynamic cityId;
  dynamic stateId;
  dynamic cityName;
  dynamic stateName;

  TeamsList(
      {this.matchId,
        this.teamId,
        this.teamName,
        this.logo,
        this.totalPrice,
        this.paidPrice,
        this.paidStatus,
        this.bookingDate,
        this.bookingSlotStart,
        this.bookingSlotEnd,
        this.cityId,
        this.stateId,
        this.cityName,
        this.stateName});

  TeamsList.fromJson(Map<String, dynamic> json) {
    matchId = json['match_id'];
    teamId = json['team_id'];
    teamName = json['team_name'];
    logo = json['logo'];
    totalPrice = json['total_price'];
    paidPrice = json['remain_price'];
    paidStatus = json['paid_status'];
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
    data['match_id'] = this.matchId;
    data['team_id'] = this.teamId;
    data['team_name'] = this.teamName;
    data['logo'] = this.logo;
    data['total_price'] = this.totalPrice;
    data['remain_price'] = this.paidPrice;
    data['paid_status'] = this.paidStatus;
    data['booking_date'] = this.bookingDate;
    data['booking_slot_start'] = this.bookingSlotStart;
    data['booking_slot_end'] = this.bookingSlotEnd;
    data['city_id'] = this.cityId;
    data['state_id'] = this.stateId;
    data['city_name'] = this.cityName;
    data['state_name'] = this.stateName;
    return data;
  }
}
