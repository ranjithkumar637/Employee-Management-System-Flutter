import 'dart:convert';
import 'dart:io';

import 'package:elevens_organizer/models/organizer_match_history_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../utils/app_constants.dart';


class ProfileProvider extends ChangeNotifier{

  OrganizerMatchHistoryModel organizerMatchHistoryModel = OrganizerMatchHistoryModel();
  List<MatchHistoryList> matchHistoryList = [];

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
}