class HomeDetailsModel {
  dynamic message;
  bool? status;
  dynamic groundCount;
  dynamic totalRevenue;
  OrganizerDetails? organizerDetails;
  List<Offings>? offings;

  HomeDetailsModel(
      {message,
        status,
        groundCount,
        totalRevenue,
        organizerDetails,
        offings});

  HomeDetailsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    groundCount = json['ground_count'];
    totalRevenue = json['total_revenue'];
    organizerDetails = json['organizer_details'] != null
        ? new OrganizerDetails.fromJson(json['organizer_details'])
        : null;
    if (json['offings'] != null) {
      offings = <Offings>[];
      json['offings'].forEach((v) {
        offings!.add(new Offings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = message;
    data['status'] = status;
    data['ground_count'] = groundCount;
    data['total_revenue'] = totalRevenue;
    if (organizerDetails != null) {
      data['organizer_details'] = organizerDetails!.toJson();
    }
    if (offings != null) {
      data['offings'] = offings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrganizerDetails {
  dynamic id;
  dynamic name;
  dynamic email;
  dynamic cityId;
  dynamic city;
  dynamic stateId;
  dynamic state;
  dynamic mobile;
  dynamic alterMobileNo;
  dynamic groundName;
  dynamic latitude;
  dynamic longitude;
  dynamic address;
  dynamic houseNo;
  dynamic pincode;
  dynamic streetName;
  dynamic groundId;
  dynamic adminApprove;
  dynamic groundContactNumber;
  dynamic groundSecondaryNumber;
  dynamic paymentUpi;
  dynamic qrCode;
  dynamic companyName;
  dynamic dob;
  dynamic createAt;

  OrganizerDetails(
      {id,
        name,
        email,
        cityId,
        city,
        stateId,
        state,
        mobile,
        alterMobileNo,
        groundName,
        latitude,
        longitude,
        address,
        houseNo,
        pincode,
        streetName,
        groundId,
        adminApprove,
        groundContactNumber,
        groundSecondaryNumber,
        paymentUpi,
        qrCode,
        companyName,
        dob,
        createAt});

  OrganizerDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    cityId = json['city_id'];
    city = json['city'];
    stateId = json['state_id'];
    state = json['state'];
    mobile = json['mobile'];
    alterMobileNo = json['alter_mobile_no'];
    groundName = json['ground_name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
    houseNo = json['house_no'];
    pincode = json['pincode'];
    streetName = json['street_name'];
    groundId = json['ground_id'];
    adminApprove = json['admin_approve'];
    groundContactNumber = json['ground_contact_number'];
    groundSecondaryNumber = json['ground_secondary_number'];
    paymentUpi = json['payment_upi'];
    qrCode = json['qr_code'];
    companyName = json['company_name'];
    dob = json['dob'];
    createAt = json['create_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['city_id'] = cityId;
    data['city'] = city;
    data['state_id'] = stateId;
    data['state'] = state;
    data['mobile'] = mobile;
    data['alter_mobile_no'] = alterMobileNo;
    data['ground_name'] = groundName;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['address'] = address;
    data['house_no'] = houseNo;
    data['pincode'] = pincode;
    data['street_name'] = streetName;
    data['ground_id'] = groundId;
    data['admin_approve'] = adminApprove;
    data['ground_contact_number'] = groundContactNumber;
    data['ground_secondary_number'] = groundSecondaryNumber;
    data['payment_upi'] = paymentUpi;
    data['qr_code'] = qrCode;
    data['company_name'] = companyName;
    data['dob'] = dob;
    data['create_at'] = createAt;
    return data;
  }
}

class Offings {
  dynamic matchId;
  dynamic teamAName;
  dynamic teamBName;
  dynamic teamALogo;
  dynamic teamBLogo;
  dynamic bookingDate;
  dynamic bookingSlotStart;
  dynamic cityId;
  dynamic stateId;
  dynamic cityName;
  dynamic stateName;

  Offings(
      {matchId,
        teamAName,
        teamBName,
        teamALogo,
        teamBLogo,
        bookingDate,
        bookingSlotStart,
        cityId,
        stateId,
        cityName,
        stateName});

  Offings.fromJson(Map<String, dynamic> json) {
    matchId = json['match_id'];
    teamAName = json['team_a_name'];
    teamBName = json['team_b_name'];
    teamALogo = json['team_a_logo'];
    teamBLogo = json['team_b_logo'];
    bookingDate = json['booking_date'];
    bookingSlotStart = json['booking_slot_start '];
    cityId = json['city_id'];
    stateId = json['state_id'];
    cityName = json['city_name'];
    stateName = json['state_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['match_id'] = matchId;
    data['team_a_name'] = teamAName;
    data['team_b_name'] = teamBName;
    data['team_a_logo'] = teamALogo;
    data['team_b_logo'] = teamBLogo;
    data['booking_date'] = bookingDate;
    data['booking_slot_start '] = bookingSlotStart;
    data['city_id'] = cityId;
    data['state_id'] = stateId;
    data['city_name'] = cityName;
    data['state_name'] = stateName;
    return data;
  }
}
