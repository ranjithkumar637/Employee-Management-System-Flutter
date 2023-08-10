import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:elevens_organizer/models/login_submit_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/login_model.dart';
import '../models/registration_model.dart';
import '../models/registration_submit_model.dart';
import '../models/response_model.dart';
import '../utils/app_constants.dart';

class AuthProvider extends ChangeNotifier{
//registration
  RegistrationModel registrationModel = RegistrationModel();
  RegistrationSubmitModel registrationSubmitModel = RegistrationSubmitModel();
  //login
  LoginModel loginModel = LoginModel();
  LoginSubmitModel loginSubmitModel = LoginSubmitModel();
  LoginData loginData = LoginData();

  String token = "";
  ResponseModel responseModel = ResponseModel();

  saveUserData(bool value, String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("isLoggedIn", value);
    preferences.setString("access_token", token);
  }

  // organizer login
  Future<LoginSubmitModel> login(String mobile) async {
    var body = jsonEncode({
      'mobile_no': mobile,
    });
    try {
      final response = await http.post(
        Uri.parse(AppConstants.organizerLogin),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      ).timeout(const Duration(seconds: 15));
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        loginSubmitModel = LoginSubmitModel.fromJson(decodedJson);
        loginData = LoginData.fromJson(decodedJson['data']);
        notifyListeners();
      } else {
        throw const HttpException('Failed to load data');
      }
    } on TimeoutException {
      print('Request timed out');
    } on SocketException {
      print('No internet connection');
    } on HttpException {
      print('Failed to load data');
    } on FormatException {
      print('organizer login submit- Invalid data format');
    } catch (e) {
      print(e);
    }
    return loginSubmitModel;
  }

  //login otp verify
  Future<LoginModel> loginOtpVerify(String userId, String otp) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("device_token");
    var body = jsonEncode({
      'user_id': userId,
      'otp': otp,
      "device_token": token.toString()
    });
    try {
      final response = await http.post(
        Uri.parse(AppConstants.organizerLoginOtpVerify),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      ).timeout(const Duration(seconds: 15));
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        loginModel = LoginModel.fromJson(decodedJson);
        token = loginModel.token.toString();
        saveUserData(true, token);
        notifyListeners();
      } else {
        throw const HttpException('Failed to load data');
      }
    } on TimeoutException {
      print('Request timed out');
    } on SocketException {
      print('No internet connection');
    } on HttpException {
      print('Failed to load data');
    } on FormatException {
      print('organizer login otp verify- Invalid data format');
    } catch (e) {
      print(e);
    }
    return loginModel;
  }

  // ORGANIZER logout
  Future<ResponseModel> logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accToken = preferences.getString("access_token");
    try {
      final response = await http.post(
        Uri.parse(AppConstants.organizerLogout),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accToken',
        },
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        responseModel = ResponseModel.fromJson(decodedJson);
        notifyListeners();
      } else {
        throw const HttpException('Failed to load data');
      }
    } on SocketException {
      print('No internet connection');
    } on HttpException {
      print('Failed to load data');
    } on FormatException {
      print('organizer logout- Invalid data format');
    } catch (e) {
      print(e);
    }
    return responseModel;
  }


  //register submit as organizer
  Future<RegistrationSubmitModel> register(String name, String email, String mobile, String companyName) async {
    var body = jsonEncode({
      'name': name,
      'email': email,
      'mobile_no': mobile,
      'company_name': companyName
    });
    try {
      final response = await http.post(
        Uri.parse(AppConstants.organizerRegister),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      ).timeout(const Duration(seconds: 15));
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        registrationSubmitModel = RegistrationSubmitModel.fromJson(decodedJson);
        notifyListeners();
      } else {
        throw const HttpException('Failed to load data');
      }
    } on TimeoutException {
      print('Request timed out');
    } on SocketException {
      print('No internet connection');
    } on HttpException {
      print('Failed to load data');
    } on FormatException {
      print('organizer register submit - Invalid data format');
    } catch (e) {
      print(e);
    }
    return registrationSubmitModel;
  }

  //register otp verify
  Future<RegistrationModel> registerOtpVerify(String userTempId, String otp) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("device_token");
    var body = jsonEncode({
      'user_temp_id': userTempId,
      'otp': otp,
      "device_token": token.toString()
    });
    try {
      final response = await http.post(
        Uri.parse(AppConstants.organizerRegisterOtpCheck),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      ).timeout(const Duration(seconds: 15));
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        registrationModel = RegistrationModel.fromJson(decodedJson);
        saveUserData(true, registrationModel.token.toString());
        print(registrationModel.token.toString());
        notifyListeners();
      } else {
        throw const HttpException('Failed to load data');
      }
    } on TimeoutException {
      print('Request timed out');
    } on SocketException {
      print('No internet connection');
    } on HttpException {
      print('Failed to load data');
    } on FormatException {
      print('organizer register tp verify- Invalid data format');
    } catch (e) {
      print(e);
    }
    return registrationModel;
  }
}