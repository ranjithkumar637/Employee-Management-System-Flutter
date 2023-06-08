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
  String? groundContactNumber;
  String? paymentUpi;
  String? qrCode;
  String? companyName;
  String? createAt;

  OrganizerDetails(
      {id,
        name,
        email,
        location,
        mobile,
        groundName,
        groundContactNumber,
        paymentUpi,
        qrCode,
        companyName,
        createAt});

  OrganizerDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    location = json['location'];
    mobile = json['mobile'];
    groundName = json['ground_name'];
    groundContactNumber = json['ground_contact_number'];
    paymentUpi = json['payment_upi'];
    qrCode = json['qr_code'];
    companyName = json['company_name'];
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
    data['ground_contact_number'] = groundContactNumber;
    data['payment_upi'] = paymentUpi;
    data['qr_code'] = qrCode;
    data['company_name'] = companyName;
    data['create_at'] = createAt;
    return data;
  }
}
