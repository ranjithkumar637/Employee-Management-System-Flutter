class ResendOtpModel {
  bool? status;
  dynamic message;
  dynamic otp;

  ResendOtpModel({status, message, otp});

  ResendOtpModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['otp'] = otp;
    return data;
  }
}
