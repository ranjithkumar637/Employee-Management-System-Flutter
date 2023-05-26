class CaptainListModel {
  bool? status;  List<CaptainList>? captainList;

  String? message;

  CaptainListModel({this.status, this.message, this.captainList});

  CaptainListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['captain_list'] != null) {
      captainList = <CaptainList>[];
      json['captain_list'].forEach((v) {
        captainList!.add(new CaptainList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.captainList != null) {
      data['captain_list'] = this.captainList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CaptainList {
  int? id;
  String? name;
  String? profilePhotoUrl;

  CaptainList({this.id, this.name, this.profilePhotoUrl});

  CaptainList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profilePhotoUrl = json['profile_photo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['profile_photo_url'] = this.profilePhotoUrl;
    return data;
  }
}
