class RegistrationSubmitModel {
  bool? status;
  String? message;
  int? otp;
  int? userTempId;

  RegistrationSubmitModel(
      {this.status, this.message, this.otp, this.userTempId});

  RegistrationSubmitModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    otp = json['otp'];
    userTempId = json['user_temp_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['otp'] = this.otp;
    data['user_temp_id'] = this.userTempId;
    return data;
  }
}
