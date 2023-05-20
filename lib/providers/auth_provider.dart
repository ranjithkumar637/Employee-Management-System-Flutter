import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/login_model.dart';
import '../models/registration_model.dart';
import '../models/response_model.dart';
import '../utils/app_constants.dart';

class AuthProvider extends ChangeNotifier{
//registration
  RegistrationModel registrationModel = RegistrationModel();
  //login
  LoginModel loginModel = LoginModel();
  String token = "";
  ResponseModel responseModel = ResponseModel();

  saveUserData(bool value, String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("isLoggedIn", value);
    preferences.setString("access_token", token);
  }

  // organizer login
  Future<LoginModel> login(String mobile, String password) async {
    var body = jsonEncode({
      'mobile': mobile,
      'password': password,
    });
    try {
      final response = await http.post(
        Uri.parse(AppConstants.organizerLogin),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        loginModel = LoginModel.fromJson(decodedJson);
        token = loginModel.data!.rememberToken.toString();
        saveUserData(true, token);
        notifyListeners();
      } else {
        throw const HttpException('Failed to load data');
      }
    } on SocketException {
      print('No internet connection');
    } on HttpException {
      print('Failed to load data');
    } on FormatException {
      print('organizer login- Invalid data format');
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


  //register as organizer
  Future<RegistrationModel> register(String name, String email, String mobile, String password, String companyName) async {
    var body = jsonEncode({
      'name': name,
      'email': email,
      'mobile': mobile,
      'password': password,
      'company_name': companyName
    });
    try {
      final response = await http.post(
        Uri.parse(AppConstants.organizerRegister),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        registrationModel = RegistrationModel.fromJson(decodedJson);
        saveUserData(true, registrationModel.accessToken.toString());
        notifyListeners();
      } else {
        throw const HttpException('Failed to load data');
      }
    } on SocketException {
      print('No internet connection');
    } on HttpException {
      print('Failed to load data');
    } on FormatException {
      print('organizer register - Invalid data format');
    } catch (e) {
      print(e);
    }
    return registrationModel;
  }
}