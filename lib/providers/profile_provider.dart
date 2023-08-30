import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:elevens_organizer/models/ground_details_model.dart';
import 'package:elevens_organizer/models/match_history_list_model.dart';
import 'package:elevens_organizer/models/profile_model.dart';
import 'package:elevens_organizer/models/profile_update_model.dart';
import 'package:elevens_organizer/models/referral_list_model.dart';
import 'package:elevens_organizer/models/response_model.dart';
import 'package:elevens_organizer/models/upcoming_match_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/in_the_offing_list_model.dart';
import '../models/match_details_model.dart';
import '../models/notification_list_model.dart';
import '../models/player_info_model.dart';
import '../models/player_match_history_list_model.dart';
import '../models/player_upcoming_match_list_model.dart';
import '../utils/app_constants.dart';


class ProfileProvider extends ChangeNotifier{

    MatchHistoryListModel matchHistoryListModel = MatchHistoryListModel();
  List<MatchHistoryList> matchHistoryList = [];

  ProfileModel profileModel = ProfileModel();
  OrganizerDetails organizerDetails = OrganizerDetails();
  String name = "", mobile = "", email = "", dob = "";
  String getName() => name;
  String getMobile() => mobile;
  String getEmail() => email;
  String getDob() => dob;

  ProfileUpdateModel profileUpdateModel = ProfileUpdateModel();

  ResponseModel responseModel = ResponseModel();
  UpcomingMatchListModel upcomingMatchListModel = UpcomingMatchListModel();
  List<UpcomingMatch> upcomingMatch = [];

  GroundDetailsModel groundDetailsModel = GroundDetailsModel();
  GroundDetails groundDetails = GroundDetails();
  List<String> groundImages = [];
  List<String> newGroundImages = [];
  List<String> mainImage = [];

  //storing locally
  String groundAddress = "";
    String groundStreet = "";
    String groundHouseNo = "", groundPinCode = "";
    String groundLatitude = "", groundLongitude = "";
    String stateIdGround = "", cityIdGround = "";

    //from api
  String address = "", street = "";
  String houseNo = "", pinCode = "";
  String latitude = "", longitude = "";
  String stateId = "", cityId = ""; // for ground
  String mainImg = "";

    String pitch = "", boundaryLine = "";
    int floodLight = 0;
    String description = "";

    //save ground information locally
  saveGroundInfo(String value1, String value2, int value3){
    print("flood light value $value3");
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

  //save ground address locally
  void saveGroundAddress(String streetData, String subLocality, String locality, String pin, String lat, String long, String houseNumber, String sId, String cId) {
    print(streetData);
    groundAddress = "$streetData, $subLocality, $locality, $pin";
    groundLatitude = lat;
    groundStreet = streetData;
    groundHouseNo = houseNumber;
    groundPinCode = pin;
    groundLongitude = long;
    stateIdGround = sId;
    cityIdGround = cId;
    notifyListeners();
  }

  bool bookings = false;
  bool matches = false;

  moveToBookings() {
    bookings = true;
    notifyListeners();
  }

    removeBookings() {
      bookings = false;
      notifyListeners();
    }

    removeMatches() {
      matches = false;
      notifyListeners();
    }

  moveToMatches() {
    matches = true;
    notifyListeners();
  }

  List<SlotList> slotList = [];

    NotificationListModel notificationListModel = NotificationListModel();
    List<NotificationList> notificationList = [];

    PlayerInfoModel playerInfoModel = PlayerInfoModel();
    PlayerInfo playerInfo = PlayerInfo();

    PlayerMatchHistoryListModel playerMatchHistoryListModel = PlayerMatchHistoryListModel();
    List<PlayerMatchHistory> matchHistoryPlayer = [];

    PlayerUpcomingMatchListModel playerUpcomingMatchListModel = PlayerUpcomingMatchListModel();
    List<PlayerUpcomingMatch> upcomingMatchPlayer = [];

    MatchDetailsModel matchDetailsModel = MatchDetailsModel();
    MatchDetails matchDetails = MatchDetails();

    //match history details
    Future<MatchDetailsModel> getMatchDetails(String matchId) async {
      matchDetailsModel = MatchDetailsModel();
      matchDetails = MatchDetails();
      print("match id $matchId");
      var body = jsonEncode({
        'id': matchId,
      });
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? accToken = preferences.getString("access_token");
      try {
        final response = await http.post(
          Uri.parse(AppConstants.matchDetails),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $accToken',
          },
          body: body,
        ).timeout(const Duration(seconds: 15));
        var decodedJson = json.decode(response.body);
        print(decodedJson);
        if (response.statusCode == 200) {
          matchDetailsModel = MatchDetailsModel.fromJson(decodedJson);
          matchDetails = MatchDetails.fromJson(decodedJson['match_details']);
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
        print('cap match details - Invalid data format');
      } catch (e) {
        print(e);
      }
      return matchDetailsModel;
    }

    Future<List<PlayerUpcomingMatch>> getPlayerUpcomingMatchList(String playerId) async {
      upcomingMatchPlayer = [];
      var body = jsonEncode({
        'player_id': playerId,
      });
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? accToken = preferences.getString("access_token");
      try {
        final response = await http.post(
            Uri.parse(AppConstants.playerUpcomingMatches),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $accToken',
            },
            body: body
        ).timeout(const Duration(seconds: 15));
        var decodedJson = json.decode(response.body);
        print(decodedJson);
        if (response.statusCode == 200) {
          playerUpcomingMatchListModel = PlayerUpcomingMatchListModel.fromJson(decodedJson);
          for (var state in decodedJson['upcoming_match']) {
            upcomingMatchPlayer.add(PlayerUpcomingMatch.fromJson(state));
            notifyListeners();
          }
          notifyListeners();
        } else {
          // API call was not successful
          throw const HttpException('Failed to load data');
        }
      } on TimeoutException{
        print("Request timed out");
      } on SocketException {
        print('No internet connection');
      } on HttpException {
        print('Failed to load data');
      } on FormatException {
        print('player upcoming matches - Invalid data format');
      } catch (e) {
        print(e);
      }
      return upcomingMatchPlayer;
    }

    //player match history list
    Future<List<PlayerMatchHistory>> getPlayerMatchHistoryList(String playerId) async {
      matchHistoryPlayer = [];
      var body = jsonEncode({
        'player_id': playerId,
      });
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? accToken = preferences.getString("access_token");
      try {
        final response = await http.post(
            Uri.parse(AppConstants.playerMatchHistory),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $accToken',
            },
            body: body
        ).timeout(const Duration(seconds: 15));
        var decodedJson = json.decode(response.body);
        print(decodedJson);
        if (response.statusCode == 200) {
          playerMatchHistoryListModel = PlayerMatchHistoryListModel.fromJson(decodedJson);
          for (var state in decodedJson['match_history']) {
            matchHistoryPlayer.add(PlayerMatchHistory.fromJson(state));
            notifyListeners();
          }
          notifyListeners();
        } else {
          // API call was not successful
          throw const HttpException('Failed to load data');
        }
      } on TimeoutException{
        print("Request timed out");
      } on SocketException {
        print('No internet connection');
      } on HttpException {
        print('Failed to load data');
      } on FormatException {
        print('player match history - Invalid data format');
      } catch (e) {
        print(e);
      }
      return matchHistoryPlayer;
    }

    //get player information
    Future<PlayerInfoModel> getPlayerInfo(String playerId) async {
      print("player id $playerId");
      playerInfoModel = PlayerInfoModel();
      playerInfo = PlayerInfo();
      var body = jsonEncode({
        'player_id': playerId,
      });
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? accToken = preferences.getString("access_token");
      try {
        final response = await http.post(
          Uri.parse(AppConstants.playerInfo),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $accToken',
          },
          body: body,
        ).timeout(const Duration(seconds: 15));
        var decodedJson = json.decode(response.body);
        print(decodedJson);
        if (response.statusCode == 200) {
          playerInfoModel = PlayerInfoModel.fromJson(decodedJson);
          playerInfo = PlayerInfo.fromJson(decodedJson['player-info']);
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
        print('player info - Invalid data format');
      } catch (e) {
        print(e);
      }
      return playerInfoModel;
    }

    //notification list
    Future<List<NotificationList>> getNotificationList() async {
      notificationList = [];
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? accToken = preferences.getString("access_token");
      try {
        final response = await http.get(
          Uri.parse(AppConstants.notificationList),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $accToken',
          },
        );
        var decodedJson = json.decode(response.body);
        print(decodedJson);
        if (response.statusCode == 200) {
          notificationListModel = NotificationListModel.fromJson(decodedJson);
          for (var data in decodedJson['notification']) {
            notificationList.add(NotificationList.fromJson(data));
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
        print('notification list - Invalid data format');
      } catch (e) {
        print(e);
      }
      return notificationList;
    }


    ReferralListModel referralListModel = ReferralListModel();
    List<RefList> refList = [];

    //referrals list
    Future<List<RefList>> getReferralsList() async {
      refList = [];
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? accToken = preferences.getString("access_token");
      try {
        final response = await http.get(
          Uri.parse(AppConstants.referralList),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $accToken',
          },
        );
        var decodedJson = json.decode(response.body);
        print(decodedJson);
        if (response.statusCode == 200) {
          referralListModel = ReferralListModel.fromJson(decodedJson);
          for (var data in decodedJson['ref_list']) {
            refList.add(RefList.fromJson(data));
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
        print('referrals list - Invalid data format');
      } catch (e) {
        print(e);
      }
      return refList;
    }

    //organizer match history list
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
        matchHistoryListModel = MatchHistoryListModel.fromJson(decodedJson);
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

  //organizer upcoming matches list
  Future<List<UpcomingMatch>> getOrganizerUpcomingMatchList() async {
    upcomingMatch = [];
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accToken = preferences.getString("access_token");
    try {
      final response = await http.get(
        Uri.parse(AppConstants.organizerUpcomingMatchesList),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accToken',
        },
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        upcomingMatchListModel = UpcomingMatchListModel.fromJson(decodedJson);
        for (var data in decodedJson['upcoming_match']) {
          upcomingMatch.add(UpcomingMatch.fromJson(data));
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
      print('organizer UpcomingMatch list - Invalid data format');
    } catch (e) {
      print(e);
    }
    return upcomingMatch;
  }

  //get profile
  getProfile() async {
    slotList.clear();
     notifyListeners();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accToken = preferences.getString("access_token");
    print("get profile $accToken");
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
        for (var data in decodedJson['slotList']) {
          slotList.add(SlotList.fromJson(data));
          notifyListeners();
        }
        name = organizerDetails.name.toString();
        email = organizerDetails.email.toString();
        mobile = organizerDetails.mobile.toString();
        dob = organizerDetails.dob.toString();
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

  Future<ProfileUpdateModel> updateProfile(String groundName, String groundContact, String name, String dob, String location, String companyName,
      String latitude, String longitude, String address, String houseNo, String pinCode,
      String streetName, String cityId, String stateId, String groundCityId, String groundStateId, String organizerPinCode) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accToken = preferences.getString("access_token");
    print(accToken);
    print("$groundName $groundContact $name $dob $location $companyName");
    print("$latitude $longitude $address $houseNo $pinCode $streetName");
    print("$cityId $stateId $groundCityId $groundStateId $organizerPinCode");
    var body = jsonEncode({
      'ground_name': groundName,
      'ground_contact_number': groundContact,
      'latitude': latitude,
      'company_name': companyName,
      'longitude': longitude,
      'address': address,
      'house_no': houseNo,
      'pincode': pinCode,
      'street_name': streetName,
      'name': name,
      'dob': dob,
      'location': location == "" ? "" : int.parse(location),
      'city_id': cityId,
      'state_id': stateId,
      'ground_city_id': groundCityId,
      'ground_state_id': groundStateId,
      'org_pincode': organizerPinCode,
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
        if(decodedJson['ground_details'] is List){
          groundDetails = GroundDetails();
          notifyListeners();
        } else if(decodedJson['ground_details'] is Map){
          groundDetails = GroundDetails.fromJson(decodedJson['ground_details']);
          pitch = groundDetails.pitch.toString();
          boundaryLine = groundDetails.boundaryLine.toString();
          floodLight = int.parse(groundDetails.floodLight.toString());
          description = groundDetails.description.toString();
          address = groundDetails.address.toString();
          street = groundDetails.streetName.toString();
          houseNo = groundDetails.houseNo.toString();
          pinCode = groundDetails.pincode.toString();
          latitude = groundDetails.latitude.toString();
          longitude = groundDetails.longitude.toString();
          mainImg = groundDetails.mainImage.toString();
          stateId = groundDetails.stateId.toString();
          cityId = groundDetails.cityId.toString();
          print(mainImg);
          notifyListeners();
        }

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
      String houseNo, String floodLight, String address, String pinCode, String latitude, String longitude, String pitch, String boundaryLine, String streetName, String stateId, String cityId) async{
    print("$description $houseNo $floodLight $address $pinCode $latitude $longitude  $pitch $boundaryLine $streetName");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accToken = preferences.getString("access_token");
    print(accToken);
    // try {
    var uri = Uri.parse(AppConstants.groundDetailsUpdate);
    final request = http.MultipartRequest("POST", uri);
    request.headers.addAll({
      'Authorization': 'Bearer $accToken',
      'Charset': 'utf-8',
      'Accept': 'application/json',
    });

    List<http.MultipartFile> newList = [];

    for (var img in main) {
      print(img.split('/').last);
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
    request.fields['street_name'] = streetName;
    request.fields['state_id'] = stateId;
    request.fields['city_id'] = cityId;

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
    // }
    // on FileSystemException {
    //   // throw const FileSystemException('Failed to send request');
    // }
    notifyListeners();
    return responseModel;
  }

}