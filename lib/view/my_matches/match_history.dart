import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:elevens_organizer/view/my_matches/match_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/match_history_list_model.dart';
import '../../providers/booking_provider.dart';
import '../../providers/profile_provider.dart';
import '../../utils/app_constants.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import '../widgets/loader.dart';
import '../widgets/reset_button.dart';
import '../widgets/snackbar.dart';
import '../widgets/submit_button.dart';
import 'battles_list.dart';
import 'match_history_card.dart';

class MatchHistory extends StatefulWidget {
  const MatchHistory({Key? key}) : super(key: key);

  @override
  State<MatchHistory> createState() => _MatchHistoryState();
}

class _MatchHistoryState extends State<MatchHistory> {

  Future<List<MatchHistoryList>>? futureData;
  List<MatchHistoryList> matchHistoryList = [];
  String firstDate = "";
  String lastDate = "";
  bool loading = false;

  getMatchHistoryList(){
    futureData = ProfileProvider().getOrganizerMatchHistoryList().then((value) {
      setState(() {
        matchHistoryList = [];
        matchHistoryList.addAll(value);
      });
      print(matchHistoryList);
      return matchHistoryList;
    });
  }

  List<MatchHistoryList> filteredItems = [];
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
      filteredItems = matchHistoryList.where((item) {
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

  setDelay() async {
    setState(() {
      loading = true;
    });
    getMatchHistoryList();
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
    return loading
        ? const Loader()
        : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        matchHistoryList.isEmpty
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
                              lastDate: DateTime.now().add(const Duration(days: 7)),
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

        Expanded(
          child: matchHistoryList.isEmpty
              ? Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 16.h),
                Image.asset(Images.noMatches, width: 80.w, fit: BoxFit.cover,),
                SizedBox(height: 3.h),
                Text("You don’t have any match history",
                  style: fontMedium.copyWith(
                      fontSize: 12.sp,
                      color: AppColor.redColor
                  ),),
              ],
            ),
          ) : !filter
              ? FutureBuilder(
              future: futureData,
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } if (snapshot.connectionState ==
                    ConnectionState.done) {
                  return MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (context, _){
                          return SizedBox(height: 1.5.h);
                        },
                        itemCount: matchHistoryList.length,
                        itemBuilder: (context, index){
                          final match = matchHistoryList[index];
                          return Bounceable(
                              onTap: (){
                                if(match.matchStatus.toString() == "Abandoned" || match.matchStatus.toString() == "Cancelled"){

                                } else {
                                  Provider.of<BookingProvider>(context, listen: false).removeMatchTeamData();
                                  Provider.of<BookingProvider>(context, listen: false).clearMatchInfo();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) {
                                          return MatchInfoScreen(matchId: matchHistoryList[index].id.toString());
                                        }),
                                  );
                                }

                              },
                              child:  MatchHistoryCard(match)
                          );
                        },
                      ));
                } else{
                  return const CircularProgressIndicator();
                }
              }
          )
              : MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, _){
                  return SizedBox(height: 1.5.h);
                },
                itemCount: filteredItems.length,
                itemBuilder: (context, index){
                  final match = filteredItems[index];
                  return Bounceable(
                      onTap: (){
                        Provider.of<BookingProvider>(context, listen: false).removeMatchTeamData();
                        Provider.of<BookingProvider>(context, listen: false).clearMatchInfo();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) {
                                return MatchInfoScreen(matchId: filteredItems[index].id.toString());
                              }),
                        );
                      },
                      child: MatchHistoryCard(match)
                  );
                },
              )),
        ),
      ],
    );
  }
}

class DateFilterContainer extends StatelessWidget {
  final String date;
  const DateFilterContainer(this.date, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 1.5.h,
      ),
      decoration: BoxDecoration(
        color: AppColor.lightColor,
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: Row(
        children: [
          Text(date,
            style: fontRegular.copyWith(
                fontSize: 12.sp,
                color: AppColor.textMildColor
            ),),
          const Spacer(),
          SvgPicture.asset(Images.calendarIcon, color: AppColor.secondaryColor, width: 5.w,),
        ],
      ),
    );
  }
}
