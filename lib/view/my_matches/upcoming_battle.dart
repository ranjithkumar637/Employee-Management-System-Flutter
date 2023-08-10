import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import '../../models/upcoming_match_list_model.dart';
import '../../providers/profile_provider.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import 'battles_list.dart';

class UpcomingBattle extends StatefulWidget {
  const UpcomingBattle({Key? key}) : super(key: key);

  @override
  State<UpcomingBattle> createState() => _UpcomingBattleState();
}

class _UpcomingBattleState extends State<UpcomingBattle> {
  Future<List<UpcomingMatch>>? futureData;
  List<UpcomingMatch> upcomingMatchList = [];
  String firstDate = "";
  String lastDate = "";
  bool loading = false;

  getUpcomingMatchList() {
    futureData =
        ProfileProvider().getOrganizerUpcomingMatchList().then((value) {
      if (mounted) {
        setState(() {
          upcomingMatchList = [];
          upcomingMatchList.addAll(value);
        });
      }
      print(upcomingMatchList);
      return upcomingMatchList;
    });
  }

  setDelay() async {
    if (mounted) {
      setState(() {
        loading = true;
      });
    }
    getUpcomingMatchList();
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          upcomingMatchList.isEmpty
          ? const SizedBox()
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.5.h),
              child: Text(
                "This week upcoming matches",
                style: fontMedium.copyWith(
                    fontSize: 12.sp, color: AppColor.textColor),
              ),
            ),
          upcomingMatchList.isEmpty
          ? Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 16.h),
                  Image.asset(
                    Images.noMatches,
                    width: 80.w,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    "You don’t have any upcoming matches",
                    style: fontMedium.copyWith(
                        fontSize: 12.sp, color: AppColor.redColor),
                  ),
                ],
              ),
            )
          : Expanded(
              child: ListView.separated(
                  separatorBuilder: (context, _) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(),
                    );
                  },
                  itemCount: upcomingMatchList.length,
                  itemBuilder: (context, index) {
                    final item = upcomingMatchList[index];
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 2.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 2.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Image.asset(
                                  //  item["team1Logo"],
                                  //   height: 10.h,
                                  // ),
                                  Column(
                                    children: [
                                      Text(
                                        upcomingMatchList[index].teamAName ??
                                            "",
                                        style: fontMedium.copyWith(
                                          fontSize: 11.5.sp,
                                          color: AppColor.textColor,
                                        ),
                                      ),
                                      Text(
                                        "vs",
                                        style: fontMedium.copyWith(
                                          fontSize: 11.5.sp,
                                          color: AppColor.hintColour,
                                        ),
                                      ),
                                      Text(
                                        upcomingMatchList[index].teamBName ??
                                            '',
                                        style: fontMedium.copyWith(
                                          fontSize: 11.5.sp,
                                          color: AppColor.textColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Image.asset(
                                  //   item["team2Logo"],
                                  //   height: 10.h,
                                  // ),
                                ],
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              DottedLine(
                                dashColor: AppColor.hintColour.withOpacity(0.4),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 0.6.w,
                                              vertical: 0.3.h),
                                          decoration: BoxDecoration(
                                              color: AppColor.secondaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Icon(
                                            Icons.access_time,
                                            color: AppColor.primaryColor,
                                            size: 2.h,
                                          )),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Text(
                                        upcomingMatchList[index]
                                                .bookingSlotStart
                                                .toString() ??
                                            '',
                                        style: fontMedium.copyWith(
                                          fontSize: 12.sp,
                                          color: AppColor.textColor,
                                        ),
                                      )
                                    ],
                                  ),
                                  Spacer(),
                                  Text(
                                    upcomingMatchList[index]
                                            .bookingSlotEnd
                                            .toString() ??
                                        '',
                                    style: fontMedium.copyWith(
                                      fontSize: 12.sp,
                                      color: AppColor.textColor,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
              // Expanded(
              //   child: FutureBuilder(
              //       future: futureData,
              //       builder: (context, snapshot) {
              //         if (snapshot.connectionState ==
              //             ConnectionState.waiting) {
              //           return const CircularProgressIndicator();
              //         } if (snapshot.connectionState ==
              //             ConnectionState.done) {
              //           return MediaQuery.removePadding(
              //               context: context,
              //               removeTop: true,
              //               child: ListView.separated(
              //                 physics: const BouncingScrollPhysics(),
              //                 separatorBuilder: (context, _){
              //                   return SizedBox(height: 1.5.h);
              //                 },
              //                 itemCount: upcomingMatchList.length,
              //                 itemBuilder: (context, index){
              //                   return Bounceable(
              //                     onTap: (){
              //
              //                     },
              //                     child: BattlesList(
              //                       upcomingMatchList[index].mainImage.toString(),
              //                       '${upcomingMatchList[index].teamAName.toString()} vs ${upcomingMatchList[index].teamBName.toString() == "" ? "TBA" : upcomingMatchList[index].teamBName.toString()}',
              //                       upcomingMatchList[index].bookingDate.toString(),
              //                       upcomingMatchList[index].bookingSlotStart.toString(),
              //                       upcomingMatchList[index].groundName.toString(),
              //                       upcomingMatchList[index].organizerName.toString(),
              //                     ),
              //                   );
              //                 },
              //               ));
              //         } else{
              //           return const CircularProgressIndicator();
              //         }
              //       }
              //   ),
            ) // ),
    ]);
  }
}
