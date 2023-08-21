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
                Text("You don’t have any match history",
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
                              Provider.of<BookingProvider>(context, listen: false).removeMatchTeamData();
                              Provider.of<BookingProvider>(context, listen: false).clearMatchInfo();
                              Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                              return MatchInfoScreen(matchId: matchHistoryList[index].id.toString());
                                            }),
                                          );
                                        },
                            child:  Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColor.lightColor,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 3.w,
                                        vertical: 1.4.h,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          ClipOval(
                                            child: CachedNetworkImage(
                                              imageUrl: "${
                                                  AppConstants.imageBaseUrl
                                              }${AppConstants.imageBaseUrlTeam}${matchHistoryList[index].teamBLogo}",
                                              errorWidget: (context, url, error) => Image.asset(Images.groundImage, width: 5.w, fit: BoxFit.cover,),
                                              width: 20.w,
                                              height: 10.h,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Text("${matchHistoryList[index].teamAName}",
                                                  style: fontBold.copyWith(
                                                    color: AppColor.textColor,
                                                    fontSize: 11.sp,
                                                  ),),
                                                SizedBox(height: 0.5.h),
                                                Text('vs',
                                                    style:
                                                    fontMedium.copyWith(
                                                      color: AppColor
                                                          .redColor,
                                                      fontSize: 11.sp,
                                                    )),
                                                SizedBox(height: 0.5.h),
                                                Text(matchHistoryList[index].teamBName == "" ? "TBA" : "${matchHistoryList[index].teamBName}",
                                                  style: fontBold.copyWith(
                                                    color: AppColor.textColor,
                                                    fontSize: 11.sp,
                                                  ),),
                                              ],
                                            ),
                                          ),
                                          ClipOval(
                                            child: CachedNetworkImage(imageUrl: "${
                                                AppConstants.imageBaseUrl
                                            }${AppConstants.imageBaseUrlTeam}${matchHistoryList[index].teamALogo}",
                                              errorWidget: (context, url, error) => Icon(Icons.person_outline_rounded, size: 4.w,),
                                              width: 20.w,
                                              height: 10.h,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    DottedLine(
                                      dashColor: AppColor.hintColour.withOpacity(0.4),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 3.w,
                                        vertical: 1.5.h
                                      ),
                                      child: Row(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                padding:
                                                EdgeInsets.symmetric(
                                                  horizontal: 1.w,
                                                  vertical: 0.5.h,
                                                ),
                                                decoration: BoxDecoration(
                                                    color: AppColor
                                                        .secondaryColor
                                                        .withOpacity(0.2),
                                                    shape: BoxShape.circle),
                                                child: Icon(
                                                  Icons.access_time,
                                                  color: AppColor
                                                      .secondaryColor,
                                                  size: 3.5.w,
                                                ),
                                              ),
                                              SizedBox(width: 1.w),
                                              Text(
                                                matchHistoryList[index].bookingSlotStart.toString(),
                                                style: fontMedium
                                                    .copyWith(
                                                    fontSize:
                                                    10.sp,
                                                    color: AppColor
                                                        .textColor),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                padding:
                                                EdgeInsets.symmetric(
                                                  horizontal: 1.w,
                                                  vertical: 0.5.h,
                                                ),
                                                decoration: BoxDecoration(
                                                    color: AppColor
                                                        .secondaryColor
                                                        .withOpacity(0.2),
                                                    shape: BoxShape.circle),
                                                child: SvgPicture.asset(
                                                  Images.calendarIcon,
                                                  color: AppColor
                                                      .secondaryColor,
                                                  width: 3.5.w,
                                                ),
                                              ),
                                              SizedBox(width: 1.w),
                                              Text(
                                                matchHistoryList[index].bookingDate.toString(),
                                                style: fontMedium.copyWith(
                                                    fontSize: 10.sp,
                                                    color: AppColor
                                                        .textColor),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                        );
                        // return Bounceable(
                        //   onTap: (){
                        //
                        //   },
                        //   child: BattlesList(
                        //       matchHistoryList[index].mainImage.toString(),
                        //       matchHistoryList[index].teamBName.toString() == ""
                        //           ?'${matchHistoryList[index].teamAName.toString()} vs TBA'
                        //       : '${matchHistoryList[index].teamAName.toString()} vs ${matchHistoryList[index].teamBName.toString()}',
                        //       matchHistoryList[index].bookingDate.toString(),
                        //       matchHistoryList[index].bookingSlotStart.toString(),
                        //       matchHistoryList[index].groundName.toString(),
                        //     matchHistoryList[index].organizerName.toString(),
                        //   ),
                        // );
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
