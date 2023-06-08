import 'dart:convert';
import 'dart:io';

import 'package:elevens_organizer/models/ground_details_model.dart';
import 'package:elevens_organizer/models/organizer_match_history_model.dart';
import 'package:elevens_organizer/models/profile_model.dart';
import 'package:elevens_organizer/models/profile_update_model.dart';
import 'package:elevens_organizer/models/response_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../utils/app_constants.dart';


class ProfileProvider extends ChangeNotifier{

  OrganizerMatchHistoryModel organizerMatchHistoryModel = OrganizerMatchHistoryModel();
  List<MatchHistoryList> matchHistoryList = [];

  ProfileModel profileModel = ProfileModel();
  OrganizerDetails organizerDetails = OrganizerDetails();
  String name = "", mobile = "", email = "";
  String getName() => name;
  String getMobile() => mobile;
  String getEmail() => email;

  ProfileUpdateModel profileUpdateModel = ProfileUpdateModel();

  ResponseModel responseModel = ResponseModel();

  GroundDetailsModel groundDetailsModel = GroundDetailsModel();
  GroundDetails groundDetails = GroundDetails();
  List<String> groundImages = [];
  List<String> newGroundImages = [];
  List<String> mainImage = [];

  String pitch = "", boundaryLine = "";
  int floodLight = 0;
  String description = "";

  //save ground information locally
  saveGroundInfo(String value1, String value2, int value3){
    pitch = value1;
    boundaryLine = value2;
    floodLight = value3;
    notifyListeners();
  }

  //save description locally
  saveDescriptionInfo(String value1){
    description = value1;
    notifyListeners();
  }

  //save ground images locally
  void saveGroundImages(String images) {
    newGroundImages.add(images);
    notifyListeners();
  }

  //save ground images locally
  void saveGroundMainImage(String image) {
    mainImage.add(image);
    notifyListeners();
  }


  //captain match history list
  Future<List<MatchHistoryList>> getOrganizerMatchHistoryList() async {
    matchHistoryList = [];
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accToken = preferences.getString("access_token");
    try {
      final response = await http.get(
        Uri.parse(AppConstants.organizerMatchHistoryList),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accToken',
        },
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        organizerMatchHistoryModel = OrganizerMatchHistoryModel.fromJson(decodedJson);
        for (var data in decodedJson['match_history']) {
          matchHistoryList.add(MatchHistoryList.fromJson(data));
          notifyListeners();
        }
        notifyListeners();
      } else {
        throw const HttpException('Failed to load data');
      }
    } on SocketException {
      print('No internet connection');
    } on HttpException {
      print('Failed to load data');
    } on FormatException {
      print('organizer match history list - Invalid data format');
    } catch (e) {
      print(e);
    }
    return matchHistoryList;
  }

  //get profile
  getProfile() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accToken = preferences.getString("access_token");
    print(accToken);
    try {
      final response = await http.get(
        Uri.parse(AppConstants.organizerViewProfile),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accToken',
        },
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        profileModel = ProfileModel.fromJson(decodedJson);
        organizerDetails = OrganizerDetails.fromJson(decodedJson['organizer_details']);
        name = organizerDetails.name.toString();
        email = organizerDetails.email.toString();
        mobile = organizerDetails.mobile.toString();
        notifyListeners();
      } else {
        throw const HttpException('Failed to load data');
      }
    } on SocketException {
      print('No internet connection');
    } on HttpException {
      print('Failed to load data');
    } on FormatException {
      print('organizer get profile - Invalid data format');
    } catch (e) {
      print(e);
    }
    return profileModel;
  }

  Future<ProfileUpdateModel> updateProfile(String groundName, String groundContact, String name, String dob, String location) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accToken = preferences.getString("access_token");
    print(accToken);
    print("$groundName $groundContact $name $dob $location");
    var body = jsonEncode({
      'ground_name': groundName,
      'ground_contact_number': groundContact,
      'name': name,
      'dob': dob,
      'location': location,
    });
    try {
      final response = await http.post(
        Uri.parse(AppConstants.organizerProfileUpdate),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accToken',
        },
        body: body,
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        profileUpdateModel = ProfileUpdateModel.fromJson(decodedJson);
        notifyListeners();
      } else {
        throw const HttpException('Failed to load data');
      }
    } on SocketException {
      print('No internet connection');
    } on HttpException {
      print('Failed to load data');
    } on FormatException {
      print('organizer update profile - Invalid data format');
    } catch (e) {
      print(e);
    }
    return profileUpdateModel;
  }

  //get ground details
  getGroundDetails() async {
    groundImages = [];
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accToken = preferences.getString("access_token");
    print(accToken);
    try {
      final response = await http.get(
        Uri.parse(AppConstants.groundDetails),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accToken',
        },
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        groundDetailsModel = GroundDetailsModel.fromJson(decodedJson);
        groundDetails = GroundDetails.fromJson(decodedJson['ground_details']);
        pitch = groundDetails.pitch.toString();
        boundaryLine = groundDetails.boundaryLine.toString();
        floodLight = int.parse(groundDetails.floodLight.toString());
        description = groundDetails.description.toString();
        for (var data in decodedJson['ground_details']['gallery_image']) {
          groundImages.add(data);
          notifyListeners();
        }
        notifyListeners();
      } else {
        throw const HttpException('Failed to load data');
      }
    } on SocketException {
      print('No internet connection');
    } on HttpException {
      print('Failed to load data');
    } on FormatException {
      print('organizer ground details - Invalid data format');
    } catch (e) {
      print(e);
    }
    return profileModel;
  }

  //update ground details
  Future<ResponseModel> updateGroundDetails(String description, List<String> main, List<String> gallery,
      String houseNo, String floodLight, String address, String pinCode, String latitude, String longitude, String pitch, String boundaryLine) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accToken = preferences.getString("access_token");
    print(accToken);
    var uri = Uri.parse(AppConstants.groundDetailsUpdate);
    final request = http.MultipartRequest("POST", uri);
    request.headers.addAll({
      'Authorization': 'Bearer $accToken',
      'Charset': 'utf-8',
      'Accept': 'application/json',
    });

    List<http.MultipartFile> newList = [];

    for (var img in main) {
      if (img != "") {
        var multipartFile = await http.MultipartFile.fromPath(
          'main_image',
          img,
          filename: img.split('/').last,
        );
        newList.add(multipartFile);
      }
    }
    for (var img in gallery) {
      if (img != "") {
        var multipartFile = await http.MultipartFile.fromPath(
          'gallery_image[]',
          img,
          filename: img.split('/').last,
        );
        newList.add(multipartFile);
      }
    }

    request.files.addAll(newList);
    request.fields['description'] = description;
    request.fields['house_no'] = houseNo;
    request.fields['pitch'] = pitch;
    request.fields['boundary_line'] = boundaryLine;
    request.fields['flood_light'] = floodLight;
    request.fields['address'] = address;
    request.fields['pincode'] = pinCode;
    request.fields['latitude'] = latitude;
    request.fields['longitude'] = longitude;

    final res = await request.send();
    final reStr = await res.stream.bytesToString();
    var data = json.decode(reStr);

    print(res.statusCode);

    print(reStr);

    if (res.statusCode == 200) {
      responseModel = ResponseModel.fromJson(data);
      notifyListeners();
    } else {
      print(
          "something went wrong : update ground details api ${res.statusCode}");
    }
    notifyListeners();
    return responseModel;
  }

}