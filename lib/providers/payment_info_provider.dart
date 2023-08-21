import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/match_history_payment_model.dart';
import '../models/payment_get_model.dart';
import '../models/payment_update_model.dart';
import '../models/revenue_team_list_model.dart';
import '../models/total_revenue-model.dart';
import '../models/upcoming_matches_payment_model.dart';
import '../utils/app_constants.dart';

class PaymentInfoProvider extends ChangeNotifier {

  RevenueTeamListModel revenueTeamListModel = RevenueTeamListModel();
  List<TeamsList> revenueTeamList = [];

  UpcomingMatchesPaymentModel upcomingMatchesPaymentModel =
      UpcomingMatchesPaymentModel();
  List<UpcomingMatches> upcomingMatchespayments = [];

  MatchHistoryPaymentModel matchHistoryPaymentModel =
      MatchHistoryPaymentModel();
  List<MatchHistory> matchHistoryPayment = [];

  TotalRevenueModel totalRevenueModel = TotalRevenueModel();

  PaymentGetModel paymentGetModel = PaymentGetModel();

  //payment get
  Future<PaymentGetModel> paymentGets(String matchId, String teamId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accToken = preferences.getString("access_token");
    var body = jsonEncode({
      'match_id': matchId,
      'team_id': teamId,
    });
    try {
      final response = await http.post(
        Uri.parse(AppConstants.paymentgeto),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accToken',
        },
        body: body,
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        paymentGetModel = PaymentGetModel.fromJson(decodedJson);

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
    return paymentGetModel;
  }

  //payment update
  PaymentUpdateModel paymentUpdateModel = PaymentUpdateModel();

  Future<PaymentUpdateModel> paymentUpdate(String matchId, String teamId, String paidPrice, String totalPrice) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accToken = preferences.getString("access_token");
    print("matchId $matchId team id $teamId paid price $paidPrice total price $totalPrice");
    var body = jsonEncode({
      'match_id': matchId,
      'team_id': teamId,
      'paid_price': paidPrice,
      'total_price': totalPrice
    });
    try {
      final response = await http.post(
        Uri.parse(AppConstants.paymentUpdate),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accToken',
        },
        body: body,
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        paymentUpdateModel = PaymentUpdateModel.fromJson(decodedJson);
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
    return paymentUpdateModel;
  }

  Future<RevenueTeamListModel> getRevenueTeamList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accToken = preferences.getString("access_token");
    try {
      final response = await http.get(
        Uri.parse(AppConstants.revenuelist),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accToken',
        },
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        revenueTeamListModel = RevenueTeamListModel.fromJson(decodedJson);
        for (var revenueList in decodedJson['teams_list']) {
          revenueTeamList.add(TeamsList.fromJson(revenueList));
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
      print('organizer login- Invalid data format');
    } catch (e) {
      print(e);
    }
    return revenueTeamListModel;
  }

//upcoming matches payment
  Future<List<UpcomingMatches>> getUpcomingMatchesPayment() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accToken = preferences.getString("access_token");

    try {
      final response = await http.get(
        Uri.parse(AppConstants.upcomingmatchespayment),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accToken',
        },
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        upcomingMatchesPaymentModel =
            UpcomingMatchesPaymentModel.fromJson(decodedJson);
        for (var upcomingmatchespayment in decodedJson['upcoming_matches']) {
          upcomingMatchespayments
              .add(UpcomingMatches.fromJson(upcomingmatchespayment));
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
      print('organizer login- Invalid data format');
    } catch (e) {
      print(e);
    }
    return upcomingMatchespayments;
  }

  //upcomingmatches payment match history

  Future<List<MatchHistory>> getMatchHistoryPayment() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accToken = preferences.getString("access_token");
    try {
      final response = await http.get(
        Uri.parse(AppConstants.matchhistorypayment),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accToken',
        },
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        matchHistoryPaymentModel =
            MatchHistoryPaymentModel.fromJson(decodedJson);
        for (var matchhistorypayments in decodedJson['match_history']) {
          matchHistoryPayment.add(MatchHistory.fromJson(matchhistorypayments));
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
      print('match history- Invalid data format');
    } catch (e) {
      print(e);
    }
    return matchHistoryPayment;
  }

  //revenue amount
  Future<TotalRevenueModel> totalRevenueAmount() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accToken = preferences.getString("access_token");
    try {
      final response = await http.get(
        Uri.parse(AppConstants.totalrevenue),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accToken',
        },
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        totalRevenueModel = TotalRevenueModel.fromJson(decodedJson);
        notifyListeners();
      } else {
        throw const HttpException('Failed to load data');
      }
    } on SocketException {
      print('No internet connection');
    } on HttpException {
      print('Failed to load data');
    } on FormatException {
      print('match history- Invalid data format');
    } catch (e) {
      print(e);
    }
    return totalRevenueModel;
  }

  List<Offings> offings = [];

  //offings list
  Future<List<Offings>> offingsList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accToken = preferences.getString("access_token");
    try {
      final response = await http.get(
        Uri.parse(AppConstants.totalrevenue),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accToken',
        },
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        totalRevenueModel = TotalRevenueModel.fromJson(decodedJson);
        for (var list in decodedJson['offings']) {
          offings.add(Offings.fromJson(list));
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
      print('offings list- Invalid data format');
    } catch (e) {
      print(e);
    }
    return offings;
  }

}
