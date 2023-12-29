class TelecastModel {
  bool? status;
  String? message;
  Telecast? telecast;

  TelecastModel({this.status, this.message, this.telecast});

  TelecastModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    telecast = json['telecast'] != null
        ? new Telecast.fromJson(json['telecast'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.telecast != null) {
      data['telecast'] = this.telecast!.toJson();
    }
    return data;
  }
}

class Telecast {
  int? id;
  String? title;
  String? iframe;
  int? active;
  String? createdAt;
  String? updatedAt;

  Telecast(
      {this.id,
        this.title,
        this.iframe,
        this.active,
        this.createdAt,
        this.updatedAt});

  Telecast.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    iframe = json['iframe'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['iframe'] = this.iframe;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
