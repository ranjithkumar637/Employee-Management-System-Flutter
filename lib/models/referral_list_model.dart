class ReferralListModel {
  bool? status;
  dynamic message;
  dynamic refPoints;
  List<RefList>? refList;

  ReferralListModel({status, message, refPoints, refList});

  ReferralListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    refPoints = json['ref_points'];
    if (json['ref_list'] != null) {
      refList = <RefList>[];
      json['ref_list'].forEach((v) {
        refList!.add(new RefList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    data['ref_points'] = refPoints;
    if (refList != null) {
      data['ref_list'] = refList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RefList {
  dynamic id;
  dynamic organizerId;
  dynamic captainId;
  dynamic code;
  dynamic points;
  dynamic captainName;
  dynamic createdAt;
  dynamic updatedAt;

  RefList(
      {id,
        organizerId,
        captainId,
        code,
        points,
        captainName,
        createdAt,
        updatedAt});

  RefList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    organizerId = json['organizer_id'];
    captainId = json['captain_id'];
    code = json['code'];
    points = json['points'];
    captainName = json['captain_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['organizer_id'] = organizerId;
    data['captain_id'] = captainId;
    data['code'] = code;
    data['points'] = points;
    data['captain_name'] = captainName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
