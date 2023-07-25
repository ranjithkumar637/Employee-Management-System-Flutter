class LoginSubmitModel {
  bool? status;
  String? message;
  LoginData? loginData;

  LoginSubmitModel({this.status, this.message, this.loginData});

  LoginSubmitModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    loginData = json['data'] != null
        ? new LoginData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.loginData != null) {
      data['data'] = this.loginData!.toJson();
    }
    return data;
  }
}

class LoginData {
  int? userId;
  String? name;
  int? otp;

  LoginData({this.userId, this.name, this.otp});

  LoginData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['otp'] = this.otp;
    return data;
  }
}
