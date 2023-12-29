class SlideShowModel {
  bool? status;
  String? message;
  List<Slides>? slides;

  SlideShowModel({this.status, this.message, this.slides});

  SlideShowModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['slides'] != null) {
      slides = <Slides>[];
      json['slides'].forEach((v) {
        slides!.add(new Slides.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.slides != null) {
      data['slides'] = this.slides!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Slides {
  int? id;
  String? title;
  String? image;
  String? link;
  int? active;
  int? linkActive;
  String? createdAt;
  String? updatedAt;

  Slides(
      {this.id,
        this.title,
        this.image,
        this.link,
        this.active,
        this.linkActive,
        this.createdAt,
        this.updatedAt});

  Slides.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    link = json['link'];
    linkActive = json['link_active'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['link_active'] = this.linkActive;
    data['link'] = this.link;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
