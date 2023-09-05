class MatchHistoryListModel {
  bool? status;
  dynamic message;
  List<MatchHistoryList>? matchHistory;

  MatchHistoryListModel({this.status, this.message, this.matchHistory});

  MatchHistoryListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['match_history'] != null) {
      matchHistory = <MatchHistoryList>[];
      json['match_history'].forEach((v) {
        matchHistory!.add(new MatchHistoryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.matchHistory != null) {
      data['match_history'] =
          this.matchHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MatchHistoryList {
  dynamic id;
  dynamic groundImage;
  dynamic mainImage;
  dynamic organizerName;
  dynamic groundName;
  dynamic teamAName;
  dynamic teamBName;
  dynamic teamALogo;
  dynamic teamBLogo;
  dynamic bookingDate;
  dynamic bookingSlotStart;
  dynamic bookingSlotEnd;
  dynamic filterDate;
  dynamic matchNumber;
  dynamic matchStatus;

  MatchHistoryList(
      {this.id,
        this.groundImage,
        this.mainImage,
        this.organizerName,
        this.groundName,
        this.teamAName,
        this.teamBName,
        this.teamALogo,
        this.teamBLogo,
        this.bookingDate,
        this.bookingSlotStart,
        this.bookingSlotEnd,
        this.filterDate,
      this.matchNumber, this.matchStatus});

  MatchHistoryList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groundImage = json['ground_image'];
    mainImage = json['main_image'];
    organizerName = json['organizer_name'];
    groundName = json['ground_name'];
    teamAName = json['team_a_name'];
    teamBName = json['team_b_name'];
    teamALogo = json['team_a_logo'];
    teamBLogo = json['team_b_logo'];
    bookingDate = json['booking_date'];
    bookingSlotStart = json['booking_slot_start'];
    bookingSlotEnd = json['booking_slot_end'];
    filterDate = json['filter_date'];
    matchNumber = json['match_number'];
    matchStatus = json['match_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ground_image'] = this.groundImage;
    data['main_image'] = this.mainImage;
    data['organizer_name'] = this.organizerName;
    data['ground_name'] = this.groundName;
    data['team_a_name'] = this.teamAName;
    data['team_b_name'] = this.teamBName;
    data['team_a_logo'] = this.teamALogo;
    data['team_b_logo'] = this.teamBLogo;
    data['booking_date'] = this.bookingDate;
    data['booking_slot_start'] = this.bookingSlotStart;
    data['booking_slot_end'] = this.bookingSlotEnd;
    data['filter_date'] = this.filterDate;
    data['match_number'] = this.matchNumber;
    data['match_status'] = this.matchStatus;
    return data;
  }
}
