class TotalRevenueModel {
  dynamic message;
  bool? status;
  dynamic groundCount;
  dynamic totalRevenue;
  OrganizerDetails? organizerDetails;
  List<Offings>? offings;

  TotalRevenueModel(
      {this.message,
        this.status,
        this.groundCount,
        this.totalRevenue,
        this.organizerDetails,
        this.offings});

  TotalRevenueModel.fromJson(Map<String, dynamic> json) {
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
    data['message'] = this.message;
    data['status'] = this.status;
    data['ground_count'] = this.groundCount;
    data['total_revenue'] = this.totalRevenue;
    if (this.organizerDetails != null) {
      data['organizer_details'] = this.organizerDetails!.toJson();
    }
    if (this.offings != null) {
      data['offings'] = this.offings!.map((v) => v.toJson()).toList();
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
      {this.id,
        this.name,
        this.email,
        this.cityId,
        this.city,
        this.stateId,
        this.state,
        this.mobile,
        this.alterMobileNo,
        this.groundName,
        this.latitude,
        this.longitude,
        this.address,
        this.houseNo,
        this.pincode,
        this.streetName,
        this.groundId,
        this.adminApprove,
        this.groundContactNumber,
        this.groundSecondaryNumber,
        this.paymentUpi,
        this.qrCode,
        this.companyName,
        this.dob,
        this.createAt});

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
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['city_id'] = this.cityId;
    data['city'] = this.city;
    data['state_id'] = this.stateId;
    data['state'] = this.state;
    data['mobile'] = this.mobile;
    data['alter_mobile_no'] = this.alterMobileNo;
    data['ground_name'] = this.groundName;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['address'] = this.address;
    data['house_no'] = this.houseNo;
    data['pincode'] = this.pincode;
    data['street_name'] = this.streetName;
    data['ground_id'] = this.groundId;
    data['admin_approve'] = this.adminApprove;
    data['ground_contact_number'] = this.groundContactNumber;
    data['ground_secondary_number'] = this.groundSecondaryNumber;
    data['payment_upi'] = this.paymentUpi;
    data['qr_code'] = this.qrCode;
    data['company_name'] = this.companyName;
    data['dob'] = this.dob;
    data['create_at'] = this.createAt;
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
      {this.matchId,
        this.teamAName,
        this.teamBName,
        this.teamALogo,
        this.teamBLogo,
        this.bookingDate,
        this.bookingSlotStart,
        this.cityId,
        this.stateId,
        this.cityName,
        this.stateName});

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
    data['match_id'] = this.matchId;
    data['team_a_name'] = this.teamAName;
    data['team_b_name'] = this.teamBName;
    data['team_a_logo'] = this.teamALogo;
    data['team_b_logo'] = this.teamBLogo;
    data['booking_date'] = this.bookingDate;
    data['booking_slot_start '] = this.bookingSlotStart;
    data['city_id'] = this.cityId;
    data['state_id'] = this.stateId;
    data['city_name'] = this.cityName;
    data['state_name'] = this.stateName;
    return data;
  }
}
