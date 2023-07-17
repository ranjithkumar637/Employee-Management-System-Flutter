class GroundDetailsModel {
  bool? status;
  String? message;
  dynamic groundDetails;

  GroundDetailsModel({status, message, groundDetails});

  GroundDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json is List) {
      GroundDetails();
    } else {
      groundDetails = json['ground_details'] != null
          ? GroundDetails.fromJson(json['ground_details'])
          : null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (groundDetails != null) {
      data['ground_details'] = groundDetails!.toJson();
    }
    return data;
  }
}

class GroundDetails {
  dynamic id;
  String? groundName;
  String? groundContactNumber;
  dynamic groundBookingCost;
  String? description;
  String? pitch;
  dynamic boundaryLine;
  dynamic floodLight;
  String? mainImage;
  String? address;
  String? stateId;
  String? cityId;
  String? pincode;
  String? latitude;
  String? longitude;
  dynamic groundStatus;
  String? groundCreatedBy;
  String? houseNo;
  String? streetName;
  List<String>? galleryImage;

  GroundDetails(
      {id,
        groundName,
        groundContactNumber,
        groundBookingCost,
        description,
        pitch,
        boundaryLine,
        floodLight,
        mainImage,
        address,
        stateId,
        cityId,
        pincode,
        latitude,
        longitude,
        groundStatus,
        groundCreatedBy,
        houseNo,
        streetName,
        galleryImage});

  GroundDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groundName = json['ground_name'];
    groundContactNumber = json['ground_contact_number'];
    groundBookingCost = json['ground_booking_cost'];
    description = json['description'];
    pitch = json['pitch'];
    boundaryLine = json['boundary_line'];
    floodLight = json['flood_light'];
    mainImage = json['main_image'];
    address = json['address'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    pincode = json['pincode'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    groundStatus = json['ground_status'];
    groundCreatedBy = json['ground_created_by'];
    houseNo = json['house_no'];
    streetName = json['street_name'];
    if (json['gallery_image'] != null && json['gallery_image'] is List) {
      galleryImage = List<String>.from(json['gallery_image']);
    } else {
      galleryImage = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ground_name'] = groundName;
    data['ground_contact_number'] = groundContactNumber;
    data['ground_booking_cost'] = groundBookingCost;
    data['description'] = description;
    data['pitch'] = pitch;
    data['boundary_line'] = boundaryLine;
    data['flood_light'] = floodLight;
    data['main_image'] = mainImage;
    data['address'] = address;
    data['state_id'] = stateId;
    data['city_id'] = cityId;
    data['pincode'] = pincode;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['ground_status'] = groundStatus;
    data['ground_created_by'] = groundCreatedBy;
    data['house_no'] = houseNo;
    data['street_name'] = streetName;
    data['gallery_image'] = galleryImage;
    return data;
  }
}
