import 'package:elevens_organizer/providers/booking_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/animation/animation_preferences.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_up.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../models/booking_history_list_model.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import '../my_matches/match_history.dart';
import '../widgets/loader.dart';
import 'bookings_card.dart';

class BookingHistoryScreen extends StatefulWidget {
  const BookingHistoryScreen({Key? key}) : super(key: key);

  @override
  State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {

  String firstDate = "";
  String lastDate = "";

  Future<List<BookingHistory>>? futureData ;
  bool loading = false;

  List<BookingHistory> bookingHistory = [];

  getBookingHistoryList(){
    futureData = BookingProvider().getBookingHistory().then((value) {
      setState(() {
        bookingHistory = [];
        bookingHistory.addAll(value);
      });
      print(bookingHistory);
      return bookingHistory;
    });
  }

  setDelay() async{
    setState(() {
      loading = true;
    });
    getBookingHistoryList();
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    setDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 5.w, vertical: 2.h
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  useMaterial3: true,
                                  colorScheme: const ColorScheme.light(
                                    primary: AppColor.primaryColor,
                                    onPrimary: AppColor.textColor,
                                    onSurface: AppColor.textColor,
                                  ),
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      foregroundColor: AppColor.secondaryColor, // button text color
                                    ),
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );

                          if (picked != null) {
                            setState(() {
                              firstDate = DateFormat("dd-MM-yyyy").format(picked);
                            });
                          }
                        },
                        child: DateFilterContainer(firstDate.toString() == "null" || firstDate.toString() == "" ? "Start Date" : firstDate.toString())),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: GestureDetector(
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  useMaterial3: true,
                                  colorScheme: const ColorScheme.light(
                                    primary: AppColor.primaryColor,
                                    onPrimary: AppColor.textColor,
                                    onSurface: AppColor.textColor,
                                  ),
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      foregroundColor: AppColor.secondaryColor, // button text color
                                    ),
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );

                          if (picked != null) {
                            setState(() {
                              lastDate = DateFormat("dd-MM-yyyy").format(picked);
                            });
                          }
                        },
                        child: DateFilterContainer(lastDate.toString() == "null" || lastDate.toString() == "" ? "End Date" : lastDate.toString())),
                  ),
                ],
              )
          ),
          if(loading)...[
            const Loader()
          ] else...[
            bookingHistory.isEmpty
                ? Expanded(
                  child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(Images.noMatches, width: 80.w, fit: BoxFit.cover,),
                    SizedBox(height: 3.h),
                    Text("No matches found",
                      style: fontMedium.copyWith(
                          fontSize: 12.sp,
                          color: AppColor.redColor
                      ),),
                  ],
              ),
            ),
                )
                : Expanded(
              child: FadeInUp(
                preferences: const AnimationPreferences(
                    duration: Duration(milliseconds: 600)
                ),
                child: FutureBuilder(
                    future: futureData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } if (snapshot.connectionState ==
                          ConnectionState.done) {
                        return MediaQuery.removePadding(
                          removeTop: true,
                          context: context,
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            separatorBuilder: (context, _){
                              return SizedBox(height: 2.h);
                            },
                            itemCount: bookingHistory.length,
                            itemBuilder: (context, index){
                              return BookingsCard(
                                  bookingHistory[index].bookingSlotStart.toString(),
                                  bookingHistory[index].bookingDate.toString(),
                                  bookingHistory[index].cityName.toString(),
                                  bookingHistory[index].logo.toString(),
                                  bookingHistory[index].teamName.toString(),
                                  bookingHistory[index].teamId.toString(),
                                  bookingHistory[index].matchId.toString());
                            },
                          ),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }

                    }
                ),
              ),
            ),
          ],

        ],
      ),
    );
  }
}

