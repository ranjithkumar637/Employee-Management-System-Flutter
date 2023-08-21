class NotificationListModel {
  bool? status;
  dynamic message;
  List<NotificationList>? notification;

  NotificationListModel({status, message, notification});

  NotificationListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['notification'] != null) {
      notification = <NotificationList>[];
      json['notification'].forEach((v) {
        notification!.add(new NotificationList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (notification != null) {
      data['notification'] = notification!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationList {
  dynamic id;
  dynamic matchId;
  dynamic matchNumber;
  dynamic groundId;
  dynamic groundImage;
  dynamic teamId;
  dynamic teamAId;
  dynamic teamBId;
  dynamic teamAName;
  dynamic teamBName;
  dynamic teamALogo;
  dynamic teamBLogo;
  dynamic bookingDate;
  dynamic bookingSlotStart;
  dynamic cityName;
  dynamic groundLatitude;
  dynamic groundLongitude;
  dynamic title;
  dynamic note;

  NotificationList(
      {id,
        matchId,
        matchNumber,
        groundId,
        groundImage,
        teamId,
        teamAId,
        teamBId,
        teamAName,
        teamBName,
        teamALogo,
        teamBLogo,
        bookingDate,
        bookingSlotStart,
        cityName,
        groundLatitude,
        groundLongitude,
        title,
        note});

  NotificationList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    matchId = json['match_id'];
    matchNumber = json['match_number'];
    groundId = json['ground_id'];
    groundImage = json['ground_image'];
    teamId = json['team_id'];
    teamAId = json['team_a_id'];
    teamBId = json['team_b_id'];
    teamAName = json['team_a_name'];
    teamBName = json['team_b_name'];
    teamALogo = json['team_a_logo'];
    teamBLogo = json['team_b_logo'];
    bookingDate = json['booking_date'];
    bookingSlotStart = json['booking_slot_start'];
    cityName = json['city_name'];
    groundLatitude = json['ground_latitude'];
    groundLongitude = json['ground_longitude'];
    title = json['title'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['match_id'] = matchId;
    data['match_number'] = matchNumber;
    data['ground_id'] = groundId;
    data['ground_image'] = groundImage;
    data['team_id'] = teamId;
    data['team_a_id'] = teamAId;
    data['team_b_id'] = teamBId;
    data['team_a_name'] = teamAName;
    data['team_b_name'] = teamBName;
    data['team_a_logo'] = teamALogo;
    data['team_b_logo'] = teamBLogo;
    data['booking_date'] = bookingDate;
    data['booking_slot_start'] = bookingSlotStart;
    data['city_name'] = cityName;
    data['ground_latitude'] = groundLatitude;
    data['ground_longitude'] = groundLongitude;
    data['title'] = title;
    data['note'] = note;
    return data;
  }
}
