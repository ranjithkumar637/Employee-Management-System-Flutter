class ProfileModel {
  String? message;
  bool? status;
  OrganizerDetails? organizerDetails;

  ProfileModel({message, status, organizerDetails});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    organizerDetails = json['organizer_details'] != null
        ? OrganizerDetails.fromJson(json['organizer_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (organizerDetails != null) {
      data['organizer_details'] = organizerDetails!.toJson();
    }
    return data;
  }
}

class OrganizerDetails {
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? paymentUpi;
  String? qrCode;
  String? companyName;
  String? createAt;

  OrganizerDetails(
      {id,
        name,
        email,
        mobile,
        paymentUpi,
        qrCode,
        companyName,
        createAt});

  OrganizerDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
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
    data['mobile'] = mobile;
    data['payment_upi'] = paymentUpi;
    data['qr_code'] = qrCode;
    data['company_name'] = companyName;
    data['create_at'] = createAt;
    return data;
  }
}
