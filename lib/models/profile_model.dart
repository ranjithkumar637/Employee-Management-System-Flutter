class ProfileModel {
  String? message;
  bool? status;
  OrganizerDetails? organizerDetails;
  int? groundCount;

  ProfileModel(
      {message, status, organizerDetails, groundCount});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    organizerDetails = json['organizer_details'] != null
        ? OrganizerDetails.fromJson(json['organizer_details'])
        : null;
    groundCount = json['ground_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (organizerDetails != null) {
      data['organizer_details'] = organizerDetails!.toJson();
    }
    data['ground_count'] = groundCount;
    return data;
  }
}

class OrganizerDetails {
  int? id;
  String? name;
  String? email;
  String? location;
  String? mobile;
  String? groundName;
  String? latitude;
  String? longitude;
  String? address;
  String? houseNo;
  String? pincode;
  String? streetName;
  int? groundId;
  int? adminApprove;
  String? groundContactNumber;
  String? paymentUpi;
  String? qrCode;
  String? companyName;
  dynamic dob;
  String? createAt;

  OrganizerDetails(
      {id,
        name,
        email,
        location,
        mobile,
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
        paymentUpi,
        qrCode,
        companyName,
        dob,
        createAt});

  OrganizerDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    location = json['location'];
    mobile = json['mobile'];
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
    paymentUpi = json['payment_upi'];
    qrCode = json['qr_code'];
    companyName = json['company_name'];
    dob = json['dob'];
    createAt = json['create_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['location'] = location;
    data['mobile'] = mobile;
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
    data['payment_upi'] = paymentUpi;
    data['qr_code'] = qrCode;
    data['company_name'] = companyName;
    data['dob'] = dob;
    data['create_at'] = createAt;
    return data;
  }
}
