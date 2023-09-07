class ProfileModel {
  dynamic message;
  bool? status;
  dynamic groundCount;
  dynamic totalRevenue;
  dynamic refPoints;
  dynamic notifyCount;
  OrganizerDetails? organizerDetails;
  List<SlotList>? slotList;

  ProfileModel(
      {message,
        status,
        notifyCount,
        groundCount,
        totalRevenue,
        refPoints,
        organizerDetails,
        slotList});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    notifyCount = json['notify_count'];
    groundCount = json['ground_count'];
    totalRevenue = json['total_revenue'];
    refPoints = json['ref_points'];
    organizerDetails = json['organizer_details'] != null
        ? new OrganizerDetails.fromJson(json['organizer_details'])
        : null;
    if (json['slotList'] != null) {
      slotList = <SlotList>[];
      json['slotList'].forEach((v) {
        slotList!.add(new SlotList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = message;
    data['status'] = status;
    data['notify_count'] = notifyCount;
    data['ground_count'] = groundCount;
    data['total_revenue'] = totalRevenue;
    data['ref_points'] = refPoints;
    if (organizerDetails != null) {
      data['organizer_details'] = organizerDetails!.toJson();
    }
    if (slotList != null) {
      data['slotList'] = slotList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrganizerDetails {
  dynamic id;
  dynamic name;
  dynamic progressValue;
  dynamic profilePhoto;
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
  dynamic orgPincode;
  dynamic streetName;
  dynamic groundId;
  dynamic adminApprove;
  dynamic groundApprove;
  dynamic groundContactNumber;
  dynamic groundSecondaryNumber;
  dynamic groundCityId;
  dynamic groundCityName;
  dynamic groundStateId;
  dynamic groundStateName;
  dynamic organizerRefCode;
  dynamic paymentUpi;
  dynamic qrCode;
  dynamic companyName;
  dynamic dob;
  dynamic createAt;

  OrganizerDetails(
      {id,
        name,
        progressValue,
        profilePhoto,
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
        orgPincode,
        streetName,
        groundId,
        adminApprove,
        groundApprove,
        groundContactNumber,
        groundSecondaryNumber,
        groundCityId,
        groundCityName,
        groundStateId,
        groundStateName,
        organizerRefCode,
        paymentUpi,
        qrCode,
        companyName,
        dob,
        createAt});

  OrganizerDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    progressValue = json['progress_bar'];
    profilePhoto = json['profile_photo'];
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
    orgPincode = json['org_pincode'];
    streetName = json['street_name'];
    groundId = json['ground_id'];
    adminApprove = json['admin_approve'];
    groundApprove = json['ground_approve'];
    groundContactNumber = json['ground_contact_number'];
    groundSecondaryNumber = json['ground_secondary_number'];
    groundCityId = json['ground_city_id'];
    groundCityName = json['ground_city_name'];
    groundStateId = json['ground_state_id'];
    groundStateName = json['ground_state_name'];
    organizerRefCode = json['organizer_ref_code'];
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
    data['progress_bar'] = progressValue;
    data['profile_photo'] = profilePhoto;
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
    data['org_pincode'] = orgPincode;
    data['street_name'] = streetName;
    data['ground_id'] = groundId;
    data['admin_approve'] = adminApprove;
    data['ground_approve'] = groundApprove;
    data['ground_contact_number'] = groundContactNumber;
    data['ground_secondary_number'] = groundSecondaryNumber;
    data['ground_city_id'] = groundCityId;
    data['ground_city_name'] = groundCityName;
    data['ground_state_id'] = groundStateId;
    data['ground_state_name'] = groundStateName;
    data['organizer_ref_code'] = organizerRefCode;
    data['payment_upi'] = paymentUpi;
    data['qr_code'] = qrCode;
    data['company_name'] = companyName;
    data['dob'] = dob;
    data['create_at'] = createAt;
    return data;
  }
}

class SlotList {
  dynamic date;
  dynamic day;

  SlotList({date, day});

  SlotList.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    day = json['day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = date;
    data['day'] = day;
    return data;
  }
}
