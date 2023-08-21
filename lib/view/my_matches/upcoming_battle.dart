import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:elevens_organizer/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../models/upcoming_match_list_model.dart';
import '../../providers/booking_provider.dart';
import '../../providers/profile_provider.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import '../widgets/loader.dart';
import 'battles_list.dart';
import 'match_info_screen.dart';

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
          Expanded(
              child: loading
                  ? const Loader()
              : upcomingMatchList.isEmpty
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
                  : MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView.separated(
                    separatorBuilder: (context, _) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(),
                      );
                    },
                    itemCount: upcomingMatchList.length,
                    itemBuilder: (context, index) {
                      return Bounceable(
                        onTap: (){
                          Provider.of<BookingProvider>(context, listen: false).removeMatchTeamData();
                          Provider.of<BookingProvider>(context, listen: false).clearMatchInfo();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) {
                                  return MatchInfoScreen(matchId: upcomingMatchList[index].matchId.toString());
                                }),
                          );
                        },
                        child: Container(
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
                                  ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl: "${AppConstants.imageBaseUrl}${AppConstants.imageBaseUrlTeam}${upcomingMatchList[index].teamALogo}",
                                      fit: BoxFit.cover,
                                      width: 20.w,
                                      height: 9.h,
                                      errorWidget: (context, url, widget){
                                        return ClipOval(
                                          child: Image.asset(Images.groundListImage2, fit: BoxFit.cover, width: 20.w,
                                            height: 9.h,),
                                        );
                                      },
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        upcomingMatchList[index].teamAName.toString(),
                                        style: fontMedium.copyWith(
                                          fontSize: 11.5.sp,
                                          color: AppColor.textColor,
                                        ),
                                      ),
                                      Text(
                                        "vs",
                                        style: fontMedium.copyWith(
                                          fontSize: 11.sp,
                                          color: AppColor.redColor,
                                        ),
                                      ),
                                      Text(
                                        upcomingMatchList[index].teamBName.toString() == "" ? "TBA" : upcomingMatchList[index].teamBName.toString(),
                                        style: fontMedium.copyWith(
                                          fontSize: 11.5.sp,
                                          color: AppColor.textColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl: "${AppConstants.imageBaseUrl}${AppConstants.imageBaseUrlTeam}${upcomingMatchList[index].teamBLogo}",
                                      fit: BoxFit.cover,
                                      width: 20.w,
                                      height: 9.h,
                                      errorWidget: (context, url, widget){
                                        return ClipOval(
                                          child: Image.asset(Images.groundListImage2, fit: BoxFit.cover, width: 20.w,
                                            height: 9.h,),
                                        );
                                      },
                                    ),
                                  ),
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
                                              color: AppColor.iconBgColor,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Icon(
                                            Icons.access_time,
                                            color: AppColor.iconColour,
                                            size: 2.h,
                                          )),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Text(
                                        upcomingMatchList[index]
                                                .bookingSlotStart
                                                .toString(),
                                        style: fontMedium.copyWith(
                                          fontSize: 10.sp,
                                          color: AppColor.textColor,
                                        ),
                                      )
                                    ],
                                  ),
                                  const Spacer(),
                                  Text(
                                    upcomingMatchList[index]
                                            .bookingDate
                                            .toString(),
                                    style: fontMedium.copyWith(
                                      fontSize: 10.sp,
                                      color: AppColor.textColor,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
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
