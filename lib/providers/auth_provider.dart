import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/login_model.dart';
import '../models/registration_model.dart';
import '../utils/app_constants.dart';

class AuthProvider extends ChangeNotifier{
//registration
  RegistrationModel registrationModel = RegistrationModel();
  //login
  LoginModel loginModel = LoginModel();
  String token = "";

  saveUserData(bool value, String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("isLoggedIn", value);
    preferences.setString("access_token", token);
  }

  // captain login
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


  //register as captain
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