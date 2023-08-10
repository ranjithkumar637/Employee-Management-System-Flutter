import 'dart:convert';
import 'dart:io';

import 'package:elevens_organizer/models/booking_history_list_model.dart';
import 'package:elevens_organizer/models/recent_booking_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/slot_list_model.dart';
import '../models/toss_won_by_model.dart';
import '../utils/app_constants.dart';

class BookingProvider extends ChangeNotifier{

  RecentBookingListModel recentBookingListModel = RecentBookingListModel();
  List<RecentBooking> recentBooking = [];

  BookingHistoryListModel bookingHistoryListModel = BookingHistoryListModel();

  List<BookingHistory> bookingHistory = [];

  SlotsListModel slotsListModel = SlotsListModel();
  List<SlotTimeList> slotTimeList = [];

  Future<SlotsListModel> getSlotsTimeList(String groundId, DateTime bookingDate) async {
    print(bookingDate.toLocal().toString());
    print(groundId);
    slotsListModel = SlotsListModel();
    slotTimeList.clear();
    notifyListeners();
    var body = jsonEncode({
      'ground_id': groundId,
      'date': bookingDate.toLocal().toString().split(' ').first.toString()
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accToken = preferences.getString("access_token");
    try {
      final response = await http.post(
        Uri.parse(AppConstants.slotsTimeList),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accToken',
        },
        body: body,
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        slotsListModel = SlotsListModel.fromJson(decodedJson);
        for (var data in decodedJson['slot_list']) {
          slotTimeList.add(SlotTimeList.fromJson(data));
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
      print('slots time List - Invalid data format');
    } catch (e) {
      print(e);
    }
    return slotsListModel;
  }


  //toss won by
  TossWonModel tossWonModel=TossWonModel();
  Future<TossWonModel> tosswonby(String matchId, String tossWonBy,String tossResult) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accToken = preferences.getString("access_token");
    var body = jsonEncode({
      "match_id":matchId,
      "toss_won_by":tossWonBy,
      "toss_result":tossResult,
    });
    try {
      final response = await http.post(
        Uri.parse(AppConstants.tosswon),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accToken',
        },
        body: body,
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        tossWonModel = TossWonModel.fromJson(decodedJson);
        notifyListeners();
      } else {
        throw const HttpException('Failed to load data');
      }
    } on SocketException {
      print('No internet connection');
    } on HttpException {
      print('Failed to load data');
    } on FormatException {
      print('Toss Won Details- Invalid data format');
    } catch (e) {
      print(e);
    }
    return tossWonModel;
  }

//reecent bookings
  Future<List<RecentBooking>> getRecentBooking() async {
    recentBooking = [];
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accToken = preferences.getString("access_token");
    try {
      final response = await http.get(
        Uri.parse(AppConstants.recentbookings),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accToken',
        },
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        recentBookingListModel = RecentBookingListModel.fromJson(decodedJson);
        for( var bookings in decodedJson['recent_bookings']){
          recentBooking.add(RecentBooking.fromJson(bookings));
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
    return recentBooking;
  }
//booking history
  Future<List<BookingHistory>> getBookingHistory() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accToken = preferences.getString("access_token");
    try {
      final response = await http.get(
        Uri.parse(AppConstants.bookingshistory),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accToken',
        },

      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        bookingHistoryListModel = BookingHistoryListModel.fromJson(decodedJson);
        for(var history in decodedJson['booking_history']){
          bookingHistory.add(BookingHistory.fromJson(history));
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
    return bookingHistory;
  }

}