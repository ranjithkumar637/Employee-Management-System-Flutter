class RevenueTeamListModel {
  bool? status;
  dynamic message;
  dynamic totalRevenue;
  List<TeamsList>? teamsList;

  RevenueTeamListModel(
      {status, message, totalRevenue, teamsList});

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
    data['status'] = status;
    data['message'] = message;
    data['total_revenue'] = totalRevenue;
    if (teamsList != null) {
      data['teams_list'] = teamsList!.map((v) => v.toJson()).toList();
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
  dynamic matchNumber;

  TeamsList(
      {matchId,
        teamId,
        teamName,
        logo,
        totalPrice,
        paidPrice,
        paidStatus,
        bookingDate,
        bookingSlotStart,
        bookingSlotEnd,
        cityId,
        stateId,
        cityName,
        stateName,
      matchNumber});

  TeamsList.fromJson(Map<String, dynamic> json) {
    matchId = json['match_id'];
    teamId = json['team_id'];
    teamName = json['team_name'];
    logo = json['logo'];
    totalPrice = json['total_price'];
    paidPrice = json['paid_price'];
    paidStatus = json['paid_status'];
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
    data['total_price'] = totalPrice;
    data['paid_price'] = paidPrice;
    data['paid_status'] = paidStatus;
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
