class MatchDetailsModel {
  bool? status;
  dynamic message;
  MatchDetails? matchDetails;

  MatchDetailsModel({status, message, matchDetails});

  MatchDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    matchDetails = json['match_details'] != null
        ? MatchDetails.fromJson(json['match_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (matchDetails != null) {
      data['match_details'] = matchDetails!.toJson();
    }
    return data;
  }
}

class MatchDetails {
  dynamic matchId;
  dynamic teamAId;
  dynamic teamBId;
  dynamic teamAName;
  dynamic teamBName;
  dynamic teamALogo;
  dynamic teamBLogo;
  dynamic overSlots;
  dynamic bookingDate;
  dynamic bookingSlotStart;
  dynamic bookingSlotEnd;
  dynamic groundId;
  dynamic groundName;
  dynamic groundImage;
  dynamic mainImage;
  dynamic address;
  dynamic houseNo;
  dynamic streetName;
  dynamic cityId;
  dynamic stateId;
  dynamic cityName;
  dynamic stateName;
  dynamic latitude;
  dynamic longitude;
  dynamic upiId;
  dynamic qrCode;
  dynamic tossWin;
  dynamic totalPrice;
  dynamic remainPrice;
  dynamic organizerId;
  dynamic organizerName;
  dynamic groundAmount;

  MatchDetails(
      {matchId,
        teamAId,
        teamBId,
        teamAName,
        teamBName,
        teamALogo,
        teamBLogo,
        overSlots,
        bookingDate,
        bookingSlotStart,
        bookingSlotEnd,
        groundId,
        groundName,
        groundImage,
        mainImage,
        address,
        houseNo,
        streetName,
        cityId,
        stateId,
        cityName,
        stateName,
        latitude,
        longitude,
        upiId,
        qrCode,
        tossWin,
        totalPrice,
        remainPrice,
        organizerId,
        organizerName,
      groundAmount});

  MatchDetails.fromJson(Map<String, dynamic> json) {
    matchId = json['match_id'];
    teamAId = json['team_a_id'];
    teamBId = json['team_b_id'];
    teamAName = json['team_a_name'];
    teamBName = json['team_b_name'];
    teamALogo = json['team_a_logo'];
    teamBLogo = json['team_b_logo'];
    overSlots = json['over_slots'];
    bookingDate = json['booking_date'];
    bookingSlotStart = json['booking_slot_start'];
    bookingSlotEnd = json['booking_slot_end'];
    groundId = json['ground_id'];
    groundName = json['ground_name'];
    groundImage = json['ground_image'];
    mainImage = json['main_image'];
    address = json['address'];
    houseNo = json['house_no'];
    streetName = json['street_name'];
    cityId = json['city_id'];
    stateId = json['state_id'];
    cityName = json['city_name'];
    stateName = json['state_name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    upiId = json['upi_id'];
    qrCode = json['qr_code'];
    tossWin = json['toss_win'];
    totalPrice = json['total_price'];
    remainPrice = json['remain_price'];
    organizerId = json['organizer_id'];
    organizerName = json['organizer_name'];
    groundAmount = json['ground_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['match_id'] = matchId;
    data['team_a_id'] = teamAId;
    data['team_b_id'] = teamBId;
    data['team_a_name'] = teamAName;
    data['team_b_name'] = teamBName;
    data['team_a_logo'] = teamALogo;
    data['team_b_logo'] = teamBLogo;
    data['over_slots'] = overSlots;
    data['booking_date'] = bookingDate;
    data['booking_slot_start'] = bookingSlotStart;
    data['booking_slot_end'] = bookingSlotEnd;
    data['ground_id'] = groundId;
    data['ground_name'] = groundName;
    data['ground_image'] = groundImage;
    data['main_image'] = mainImage;
    data['address'] = address;
    data['house_no'] = houseNo;
    data['street_name'] = streetName;
    data['city_id'] = cityId;
    data['state_id'] = stateId;
    data['city_name'] = cityName;
    data['state_name'] = stateName;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['upi_id'] = upiId;
    data['qr_code'] = qrCode;
    data['toss_win'] = tossWin;
    data['total_price'] = totalPrice;
    data['remain_price'] = remainPrice;
    data['organizer_id'] = organizerId;
    data['organizer_name'] = organizerName;
    data['ground_amount'] = groundAmount;
    return data;
  }
}
