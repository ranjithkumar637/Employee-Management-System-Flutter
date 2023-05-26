import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../models/organizer_match_history_model.dart';
import '../../providers/profile_provider.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import '../widgets/loader.dart';
import 'battles_list.dart';

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
            : Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 5.w, vertical: 2.5.h
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
                Text("You don’t have any upcoming matches",
                  style: fontMedium.copyWith(
                      fontSize: 12.sp,
                      color: AppColor.redColor
                  ),),
              ],
            ),
          ) : FutureBuilder(
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
                        return Bounceable(
                          onTap: (){

                          },
                          child: BattlesList(
                              matchHistoryList[index].groundImage.toString(),
                              '${matchHistoryList[index].teamAName.toString()} vs ${matchHistoryList[index].teamBName.toString()}',
                              matchHistoryList[index].bookingDate.toString(),
                              matchHistoryList[index].bookingSlotStart.toString(),
                              matchHistoryList[index].groundName.toString(),
                            "JK organizers",
                          ),
                        );
                      },
                    ));
              } else{
                return const CircularProgressIndicator();
              }
            }
          ),
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
