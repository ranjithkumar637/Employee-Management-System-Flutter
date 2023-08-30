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
import '../widgets/reset_button.dart';
import '../widgets/snackbar.dart';
import '../widgets/submit_button.dart';
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
  List<BookingHistory> filteredItems = [];
  bool filter = false;

  static DateTime? _parseDateTime(String dateTimeString) {
    if (dateTimeString.isEmpty) return null;
    final parts = dateTimeString.split('-'); // Split using '-' instead of '/'
    if (parts.length != 3) return null;
    final day = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final year = int.tryParse(parts[2]);
    if (day == null || month == null || year == null) return null;
    return DateTime(year, month, day);
  }

  DateTime convertDate(String dateString){
    // Convert the date string to a DateTime object
    DateTime date = DateFormat("MMM dd, yyyy").parse(dateString);
    return date;
  }

  filterByDate() async {
    DateTime? startDate = _parseDateTime(firstDate.toString());
    DateTime? endDate = _parseDateTime(lastDate.toString());
    print(startDate);
    print(endDate);
    setState(() {
      filteredItems = bookingHistory.where((item) {
        return convertDate(item.bookingDate.toString()).isAfter(startDate!) && convertDate(item.bookingDate.toString()).isBefore(endDate!)
            || convertDate(item.bookingDate.toString()).isAtSameMomentAs(startDate) || convertDate(item.bookingDate.toString()).isAtSameMomentAs(endDate!) ;
      }).toList();
      print(filteredItems.length);
    });
    setState(() {
      loading = true;
    });
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      loading = false;
    });
  }

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
      body: loading
          ? const Loader()
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
              bookingHistory.isEmpty
                  ? const SizedBox()
                  : Column(
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
                                    lastDate: DateTime.now(),
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
                                    lastDate: DateTime.now(),
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
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
                    child: Row(
                      children: [
                        !filter ? const SizedBox() : Expanded(
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                filter = false;
                                firstDate= "";
                                lastDate = "";
                              });
                              setDelay();
                            },
                            child: const ResetButton(),
                          ),
                        ),
                        !filter ? const SizedBox() : SizedBox(width: 3.w),
                        firstDate == "" || lastDate == ""
                            ? const SizedBox()
                            : Expanded(
                          child: GestureDetector(
                            onTap: (){
                              DateTime? startDate = _parseDateTime(firstDate.toString());
                              DateTime? endDate = _parseDateTime(lastDate.toString());
                              print(startDate);
                              print(endDate);
                              if(firstDate == "" || lastDate == ""){
                                Dialogs.snackbar("Choose both start & end date", context, isError: true);
                              } else if(startDate!.isAfter(endDate!)){
                                Dialogs.snackbar("Choose a proper start & end date", context, isError: true);
                              } else{
                                filterByDate();
                                setState(() {
                                  filter = true;
                                });
                              }
                            },
                            child: const SubmitButton(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if(filter && filteredItems.isNotEmpty)...[
                Padding(
                  padding: EdgeInsets.only(
                      top: 2.h,
                      bottom: 2.h,
                      left: 5.w
                  ),
                  child: Text(
                    "Results",
                    style: fontBold.copyWith(
                        color: Colors.black,
                        fontSize: 12.sp),
                  ),
                )
              ]
              else if(filter && filteredItems.isEmpty)...[
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 5.w,
                        top: 5.h
                    ),
                    child: Text(
                      "No Results found",
                      style: fontMedium.copyWith(
                          color: AppColor.redColor,
                          fontSize: 12.sp),
                    ),
                  ),
                )
              ]
              else ...[
                  const SizedBox()
                ],
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
                    child: !filter
                    ? FutureBuilder(
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
                    )
                    : MediaQuery.removePadding(
                      removeTop: true,
                      context: context,
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (context, _){
                          return SizedBox(height: 2.h);
                        },
                        itemCount: filteredItems.length,
                        itemBuilder: (context, index){
                          return BookingsCard(
                              filteredItems[index].bookingSlotStart.toString(),
                              filteredItems[index].bookingDate.toString(),
                              filteredItems[index].cityName.toString(),
                              filteredItems[index].logo.toString(),
                              filteredItems[index].teamName.toString(),
                              filteredItems[index].teamId.toString(),
                              filteredItems[index].matchId.toString());
                        },
                      ),
                    ),
                  ),
                ),
            ],
          ),
    );
  }
}

