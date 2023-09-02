import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/captain_list_model.dart';
import '../models/city_list_model.dart';
import '../models/create_team_model.dart';
import '../models/squad_from_team_model.dart';
import '../models/state_based_city_list_model.dart';
import '../models/state_list_model.dart';
import '../models/team_list_model.dart';
import '../models/team_view_model.dart';
import '../models/tn_city_list_model.dart';
import '../models/today_matches_toss_model.dart';
import '../utils/app_constants.dart';

class TeamProvider extends ChangeNotifier{

  TeamListModel teamListModel = TeamListModel();
  List<TeamList> teamList = [];

  CreateTeamModel createTeamModel = CreateTeamModel();

  StateBasedCityListModel stateBasedCityListModel = StateBasedCityListModel();
  List<Cities> stateBasedCityList = [];
  City city = City();

  StateListModel stateListModel = StateListModel();
  List<StateList> stateList = [];

  CityListModel cityListModel = CityListModel();
  List<CityList> cityList = [];

  CaptainListModel captainListModel = CaptainListModel();
  List<CaptainList> captainList = [];

  String state = "", stateId = "";
  String stateBasedCity = "", stateBasedCityId = "";
  String captainName = "", captainId = "";

  SquadFromTeamModel squadFromTeamModel = SquadFromTeamModel();

  List<CaptainData> captainData = [];
  List<ViceCaptainData> vcData = [];
  List<AdminData> adminData = [];

  List<TeamPlayerList> teamPlayerList = [];
  TeamViewModel teamViewModel = TeamViewModel();
  TeamDetails teamDetails = TeamDetails();

  storeState(String stateName, String id){
    state = stateName;
    stateId = id;
    notifyListeners();
  }

  storeStateBasedCity(String cityName, String id){
    stateBasedCity = cityName;
    stateBasedCityId = id;
    notifyListeners();
  }

  clearData(){
    state = "";
    stateId = "";
    stateBasedCity = "";
    stateBasedCityId = "";
    notifyListeners();
  }

  String locationFilterCity = "";

  storeLocationFilterCity(String city){
    locationFilterCity = city;
    notifyListeners();
  }

  removeFilterCity(){
    locationFilterCity = "";
    notifyListeners();
  }

  TNCityListModel tnCityListModel = TNCityListModel();
  List<TnCity> tnCityList = [];

  //get tamilnadu city list
  Future<List<TnCity>> getTNCityList() async {
    tnCityList = [];
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accToken = preferences.getString("access_token");
    try {
      final response = await http.get(
        Uri.parse(AppConstants.tnCityList),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accToken',
        },
      ).timeout(const Duration(seconds: 15));
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        tnCityListModel = TNCityListModel.fromJson(decodedJson);
        for (var data in decodedJson['city']) {
          tnCityList.add(TnCity.fromJson(data));
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
      print('tn city list - Invalid data format');
    } catch (e) {
      print(e);
    }
    return tnCityList;
  }

  TodayMatchListForTossModel todayMatchListForTossModel =TodayMatchListForTossModel();
  List<TodayMatches> todayMatches=[];

  //today matches for toss
  Future<List<TodayMatches>> getTodayMatch() async {
    todayMatches= [];
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accToken = preferences.getString("access_token");
    try {
      final response = await http.get(
        Uri.parse(AppConstants.matchesfortoss ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accToken',
        },
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        todayMatchListForTossModel = TodayMatchListForTossModel.fromJson(decodedJson);
        for( var matches in decodedJson['today_matches']){
          todayMatches.add(TodayMatches.fromJson(matches));
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
      print('Recent Bookings- Invalid data format');
    } catch (e) {
      print(e);
    }
    return todayMatches;
  }

  //state list
  Future<List<TeamList>> getTeamList() async {
    teamList = [];
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accToken = preferences.getString("access_token");
    try {
      final response = await http.get(
        Uri.parse(AppConstants.teamList),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accToken',
        },
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        teamListModel = TeamListModel.fromJson(decodedJson);
        for (var state in decodedJson['team_list']) {
          teamList.add(TeamList.fromJson(state));
          notifyListeners();
        }
        notifyListeners();
      } else {
        // API call was not successful
        throw const HttpException('Failed to load data');
      }
    } on SocketException {
      print('No internet connection');
    } on HttpException {
      print('Failed to load data');
    } on FormatException {
      print('Team List - Invalid data format');
    } catch (e) {
      print(e);
    }
    return teamList;
  }

  //captain list
  Future<List<CaptainList>> getCaptainList() async {
    captainList = [];
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accToken = preferences.getString("access_token");
    try {
      final response = await http.get(
        Uri.parse(AppConstants.captainList),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accToken',
        },
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        captainListModel = CaptainListModel.fromJson(decodedJson);
        for (var state in decodedJson['captain_list']) {
          captainList.add(CaptainList.fromJson(state));
          notifyListeners();
        }
        notifyListeners();
      } else {
        // API call was not successful
        throw const HttpException('Failed to load data');
      }
    } on SocketException {
      print('No internet connection');
    } on HttpException {
      print('Failed to load data');
    } on FormatException {
      print('CaptainList - Invalid data format');
    } catch (e) {
      print(e);
    }
    return captainList;
  }

  //state list
  Future<List<StateList>> getStateList() async {
    stateList = [];
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accToken = preferences.getString("access_token");
    try {
      final response = await http.get(
        Uri.parse(AppConstants.stateList),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accToken',
        },
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        stateListModel = StateListModel.fromJson(decodedJson);
        for (var state in decodedJson['state']) {
          stateList.add(StateList.fromJson(state));
          notifyListeners();
        }
        notifyListeners();
      } else {
        // API call was not successful
        throw const HttpException('Failed to load data');
      }
    } on SocketException {
      print('No internet connection');
    } on HttpException {
      print('Failed to load data');
    } on FormatException {
      print('state list - Invalid data format');
    } catch (e) {
      print(e);
    }
    return stateList;
  }

  //city list
  Future<List<CityList>> getCityList() async {
    cityList = [];
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accToken = preferences.getString("access_token");
    try {
      final response = await http.get(
        Uri.parse(AppConstants.cityList),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accToken',
        },
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        cityListModel = CityListModel.fromJson(decodedJson);
        for (var city in decodedJson['city']) {
          cityList.add(CityList.fromJson(city));
          notifyListeners();
        }
        notifyListeners();
      } else {
        // API call was not successful
        throw const HttpException('Failed to load data');
      }
    } on SocketException {
      print('No internet connection');
    } on HttpException {
      print('Failed to load data');
    } on FormatException {
      print('city list - Invalid data format');
    } catch (e) {
      print(e);
    }
    return cityList;
  }

  //state based city list
  Future<List<Cities>> getStateBasedCityList(String stateId) async {
    stateBasedCityList = [];
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accToken = preferences.getString("access_token");
    var body = jsonEncode({
      'state_id': stateId,
    });
    try {
      final response = await http.post(
        Uri.parse(AppConstants.stateBasedCityList),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accToken',
        },
        body: body,
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        stateBasedCityListModel = StateBasedCityListModel.fromJson(decodedJson);
        city = City.fromJson(decodedJson['city']);
        for (var city in decodedJson['city']['cities']) {
          stateBasedCityList.add(Cities.fromJson(city));
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
      print('state based city list - Invalid data format');
    } catch (e) {
      print(e);
    }
    return stateBasedCityList;
  }

  //create team
  Future<CreateTeamModel> createTeam(List<String> teamLogo, List<String> qrCode,
      String teamName, String primaryContact, String secondaryContact,
      String captainName, String captainPrimaryContact, String captainLocation,
      String vcName, String vcPrimaryContact, String vcLocation,
      String adminName, String adminPrimaryContact, String adminState, String adminCity,
      String upiId,
      String captainSecondaryContact, String viceCaptainSecondaryContact, String adminSecondaryContact, String captainId) async {
    print("$teamName $primaryContact $secondaryContact $captainName $captainPrimaryContact $captainLocation $vcName $vcPrimaryContact $vcLocation $adminName $adminPrimaryContact"
        "$adminState $adminCity $upiId $captainSecondaryContact $viceCaptainSecondaryContact $adminSecondaryContact");
    // print("create team");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accToken = preferences.getString("access_token");

    var uri = Uri.parse(AppConstants.organizerTeamStore);
    final request = http.MultipartRequest("POST", uri);
    request.headers.addAll({
      'Authorization': 'Bearer $accToken',
      'Charset': 'utf-8',
      'Accept': 'application/json',
    });

    List<http.MultipartFile> file = [];

    for(var img in teamLogo) {
      if (img != "") {
        var multipartFile = await http.MultipartFile.fromPath(
          'logo',
          img,
          filename: img.split('/').last,
        );
        file.add(multipartFile);
      }}

    for(var img in qrCode) {
      if (img != "") {
        var multipartFile = await http.MultipartFile.fromPath(
          'qr_code',
          img,
          filename: img.split('/').last,
        );
        file.add(multipartFile);
      } }

    request.files.addAll(file);

    request.fields['team_name'] = teamName;
    request.fields['primary_contact'] = primaryContact;
    request.fields['secondary_contact'] = secondaryContact;
    request.fields['captain_name'] = captainName;
    request.fields['captain_primary_contact'] = captainPrimaryContact;
    request.fields['captain_location'] = captainLocation;
    request.fields['vice_captain_name'] = vcName;
    request.fields['vice_captain_primary_contact'] = vcPrimaryContact;
    request.fields['vice_captain_location'] = vcLocation;
    request.fields['admin_name'] = adminName;
    request.fields['admin_primary_contact'] = adminPrimaryContact;
    request.fields['admin_state'] = adminState;
    request.fields['upi_id'] = upiId;
    request.fields['admin_city'] = adminCity;
    request.fields['captain_secondary_contact'] = captainSecondaryContact;
    request.fields['vice_secondary_contact'] = viceCaptainSecondaryContact;
    request.fields['admin_secondary_contact'] = adminSecondaryContact;
    request.fields['captain_id'] = captainId;


    final res = await request.send();
    final reStr = await res.stream.bytesToString();
    var data = json.decode(reStr);

    print(res.statusCode);

    print(reStr);
    if (res.statusCode == 200) {
      createTeamModel =  CreateTeamModel.fromJson(data);
      notifyListeners();
    }
    else{
      print("Something Went Wrong. Please try again. : create team api ${res.statusCode}");
    }
    notifyListeners();
    return createTeamModel;
  }

  void storeCaptain(String name, String id) {
    captainName = name;
    captainId = id;
    notifyListeners();
  }

  //player list after choosing team
  Future<SquadFromTeamModel> getPlayersListOfTeam(String teamId) async {
    teamPlayerList = [];
    captainData = [];
    vcData = [];
    adminData = [];
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accToken = preferences.getString("access_token");
    var body = jsonEncode({
      'team_id': teamId,
    });
    try {
      final response = await http.post(
        Uri.parse(AppConstants.getSquadOfTeam),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accToken',
        },
        body: body,
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        squadFromTeamModel = SquadFromTeamModel.fromJson(decodedJson);
        for (var data in decodedJson['captain_list']) {
          captainData.add(CaptainData.fromJson(data));
          notifyListeners();
        }
        for (var data in decodedJson['vice_captain_list']) {
          vcData.add(ViceCaptainData.fromJson(data));
          notifyListeners();
        }
        for (var data in decodedJson['admin_list']) {
          adminData.add(AdminData.fromJson(data));
          notifyListeners();
        }
        notifyListeners();
        for (var data in decodedJson['team_player_list']) {
          teamPlayerList.add(TeamPlayerList.fromJson(data));
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
      print('player list of a team- Invalid data format');
    } catch (e) {
      print(e);
    }
    return squadFromTeamModel;
  }

  //view team
  Future<TeamViewModel> viewTeam(String teamId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accToken = preferences.getString("access_token");
    var body = jsonEncode({
      'team_id': teamId,
    });
    try {
      final response = await http.post(
        Uri.parse(AppConstants.organizerTeamView),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accToken',
        },
        body: body,
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        teamViewModel = TeamViewModel.fromJson(decodedJson);
        teamDetails = TeamDetails.fromJson(decodedJson['team_details']);
        notifyListeners();
      } else {
        throw const HttpException('Failed to load data');
      }
    } on SocketException {
      print('No internet connection');
    } on HttpException {
      print('Failed to load data');
    } on FormatException {
      print('view team - Invalid data format');
    } catch (e) {
      print(e);
    }
    return teamViewModel;
  }

}