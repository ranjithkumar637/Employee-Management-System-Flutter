class ProfileUpdateModel {
  bool? status;
  String? message;
  UpdatedOrganizerDetails? organizerDetails;
  UpdatedGroundDetails? groundDetails;

  ProfileUpdateModel(
      {status, message, organizerDetails, groundDetails});

  ProfileUpdateModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    organizerDetails = json['organizer_details'] != null
        ? UpdatedOrganizerDetails.fromJson(json['organizer_details'])
        : null;
    groundDetails = json['ground_details'] != null
        ? UpdatedGroundDetails.fromJson(json['ground_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (organizerDetails != null) {
      data['organizer_details'] = organizerDetails!.toJson();
    }
    if (groundDetails != null) {
      data['ground_details'] = groundDetails!.toJson();
    }
    return data;
  }
}

class UpdatedOrganizerDetails {
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? companyName;
  String? profileImgPath;
  int? location;
  String? dob;
  String? paymentUpi;
  String? qrCode;
  int? approved;
  int? active;
  String? createdAt;
  String? updatedAt;
  String? profilePhotoUrl;

  UpdatedOrganizerDetails(
      {id,
        name,
        email,
        mobile,
        companyName,
        profileImgPath,
        location,
        dob,
        paymentUpi,
        qrCode,
        approved,
        active,
        createdAt,
        updatedAt,
        profilePhotoUrl});

  UpdatedOrganizerDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    companyName = json['company_name'];
    profileImgPath = json['profile_img_path'];
    location = json['location'];
    dob = json['dob'];
    paymentUpi = json['payment_upi'];
    qrCode = json['qr_code'];
    approved = json['approved'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profilePhotoUrl = json['profile_photo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['company_name'] = companyName;
    data['profile_img_path'] = profileImgPath;
    data['location'] = location;
    data['dob'] = dob;
    data['payment_upi'] = paymentUpi;
    data['qr_code'] = qrCode;
    data['approved'] = approved;
    data['active'] = active;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['profile_photo_url'] = profilePhotoUrl;
    return data;
  }
}

class UpdatedGroundDetails {
  int? id;
  int? organizerId;
  String? groundName;
  String? groundContactNumber;
  int? groundBookingCost;
  String? description;
  String? pitch;
  String? boundaryLine;
  int? floodLight;
  String? mainImage;
  String? galleryImage;
  String? address;
  int? stateId;
  int? cityId;
  String? pincode;
  String? latitude;
  String? longitude;
  int? groundStatus;
  String? groundCreatedBy;
  String? createdAt;
  String? updatedAt;

  UpdatedGroundDetails(
      {id,
        organizerId,
        groundName,
        groundContactNumber,
        groundBookingCost,
        description,
        pitch,
        boundaryLine,
        floodLight,
        mainImage,
        galleryImage,
        address,
        stateId,
        cityId,
        pincode,
        latitude,
        longitude,
        groundStatus,
        groundCreatedBy,
        createdAt,
        updatedAt});

  UpdatedGroundDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    organizerId = json['organizer_id'];
    groundName = json['ground_name'];
    groundContactNumber = json['ground_contact_number'];
    groundBookingCost = json['ground_booking_cost'];
    description = json['description'];
    pitch = json['pitch'];
    boundaryLine = json['boundary_line'];
    floodLight = json['flood_light'];
    mainImage = json['main_image'];
    galleryImage = json['gallery_image'];
    address = json['address'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    pincode = json['pincode'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    groundStatus = json['ground_status'];
    groundCreatedBy = json['ground_created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['organizer_id'] = organizerId;
    data['ground_name'] = groundName;
    data['ground_contact_number'] = groundContactNumber;
    data['ground_booking_cost'] = groundBookingCost;
    data['description'] = description;
    data['pitch'] = pitch;
    data['boundary_line'] = boundaryLine;
    data['flood_light'] = floodLight;
    data['main_image'] = mainImage;
    data['gallery_image'] = galleryImage;
    data['address'] = address;
    data['state_id'] = stateId;
    data['city_id'] = cityId;
    data['pincode'] = pincode;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['ground_status'] = groundStatus;
    data['ground_created_by'] = groundCreatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
