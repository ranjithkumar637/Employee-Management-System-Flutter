import 'package:flutter/material.dart';
import 'package:flutter_animator/animation/animation_preferences.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_up.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../providers/booking_provider.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import '../widgets/loader.dart';

class RecentBookings extends StatefulWidget {
  const RecentBookings({Key? key}) : super(key: key);

  @override
  State<RecentBookings> createState() => _RecentBookingsState();
}

class _RecentBookingsState extends State<RecentBookings> {


  // Future<List<RecentPlayvs>>? futureData;
  // List<RecentPlayvs> playVSList = [];
  // bool loading = false;
  //
  // getRecentBookingsList(){
  //   futureData = BookingProvider().getRecentBookingList().then((value) {
  //     setState(() {
  //       playVSList = [];
  //       playVSList.addAll(value);
  //     });
  //     print(playVSList);
  //     return playVSList;
  //   });
  // }
  //
  // setDelay() async {
  //   setState(() {
  //     loading = true;
  //   });
  //   getRecentBookingsList();
  //   await Future.delayed(const Duration(seconds: 1));
  //   setState(() {
  //     loading = false;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // setDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // if(loading)...[
          //   const Loader()
          // ] else...[
          //   //recent bookings list
          //   Expanded(
          //     child: playVSList.isEmpty
          //         ? Center(
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Image.asset(Images.noMatches, width: 80.w, fit: BoxFit.cover,),
          //           SizedBox(height: 3.h),
          //           Text("No matches found",
          //             style: fontMedium.copyWith(
          //                 fontSize: 12.sp,
          //                 color: AppColor.redColor
          //             ),),
          //         ],
          //       ),
          //     )
          //         : FadeInUp(
          //       preferences: const AnimationPreferences(
          //           duration: Duration(milliseconds: 600)
          //       ),
          //       child: FutureBuilder(
          //           future: futureData,
          //           builder: (context, snapshot) {
          //             if (snapshot.connectionState ==
          //                 ConnectionState.waiting) {
          //               return const CircularProgressIndicator();
          //             } if (snapshot.connectionState ==
          //                 ConnectionState.done) {
          //               return ListView.separated(
          //
          //                 physics: const BouncingScrollPhysics(),
          //                 separatorBuilder: (context, _){
          //                   return SizedBox(height: 2.h);
          //                 },
          //                 itemCount: playVSList.length,
          //                 itemBuilder: (context, index){
          //                   return BookingsCard(
          //                       playVSList[index].bookingSlotStart.toString(),
          //                       playVSList[index].bookingDate.toString(),
          //                       playVSList[index].groundName.toString(),
          //                       playVSList[index].name.toString(),
          //                       playVSList[index].groundName.toString(),
          //                       Images.team1, playVSList[index].teamName.toString(),
          //                       playVSList[index].teamAId.toString(),
          //                       playVSList[index].id.toString());
          //                 },
          //               );
          //             } else {
          //               return const CircularProgressIndicator();
          //             }
          //
          //           }
          //       ),
          //     ),
          //   ),
          // ],
        ],
      ),
    );
  }
}

class BookingsCard extends StatelessWidget {
  final String time, date, location, organizer, ground, teamImage, team, teamId, matchId;
  const BookingsCard(this.time, this.date, this.location, this.organizer, this.ground, this.teamImage, this.team, this.teamId, this.matchId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: (){
        // Navigator.pushNamed(context, 'play_vs_opponent_team', arguments: PlayVSBookingData(matchId, date, time, ground, team));
      },
      child: Container(
        width: double.maxFinite,
        margin: EdgeInsets.symmetric(
          horizontal: 5.w,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 5.w,
        ),
        decoration: BoxDecoration(
            color: AppColor.lightColor,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0,0),
                  blurRadius: 1.0,
                  spreadRadius: 1.0
              ),
            ]
        ),
        child: Row(
          children: [
            Container(
              height: 12.h,
              width: 24.w,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(teamImage))
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 5.w,
                    vertical: 1.4.h
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(team,
                      style: fontMedium.copyWith(
                          fontSize: 12.sp,
                          color: AppColor.textColor
                      ),),
                    SizedBox(height:1.h),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 0.8.w,
                            vertical: 0.4.h,
                          ),
                          decoration: BoxDecoration(
                              color: AppColor.iconBgColor,
                              shape: BoxShape.circle
                          ),
                          child: SvgPicture.asset(Images.location, color: AppColor.iconColour, width: 3.w,),
                        ),
                        SizedBox(width: 2.w),
                        Text(location,
                          style: fontMedium.copyWith(
                              fontSize: 9.sp,
                              color: AppColor.textColor
                          ),),
                      ],
                    ),
                    SizedBox(height:0.5.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 0.8.w,
                            vertical: 0.4.h,
                          ),
                          decoration: BoxDecoration(
                              color: AppColor.iconBgColor,
                              shape: BoxShape.circle
                          ),
                          child: SvgPicture.asset(Images.groundIcon, color: AppColor.iconColour, width: 3.w,),
                        ),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(organizer,
                                style: fontMedium.copyWith(
                                    fontSize: 9.sp,
                                    color: AppColor.textColor
                                ),),
                              SizedBox(height:0.5.h),
                              Text(ground,
                                style: fontMedium.copyWith(
                                    fontSize: 8.5.sp,
                                    color: AppColor.textMildColor
                                ),),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height:0.5.h),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 0.8.w,
                            vertical: 0.4.h,
                          ),
                          decoration: BoxDecoration(
                              color: AppColor.iconBgColor,
                              shape: BoxShape.circle
                          ),
                          child: Icon(Icons.access_time, color: AppColor.iconColour, size: 3.w,),
                        ),
                        SizedBox(width: 2.w),
                        Text(time,
                          style: fontMedium.copyWith(
                              fontSize: 9.sp,
                              color: AppColor.textColor
                          ),),
                      ],
                    ),
                    SizedBox(height:0.5.h),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 0.8.w,
                            vertical: 0.4.h,
                          ),
                          decoration: BoxDecoration(
                              color: AppColor.iconBgColor,
                              shape: BoxShape.circle
                          ),
                          child: SvgPicture.asset(Images.calendarIcon, color: AppColor.iconColour, width: 3.w,),
                        ),
                        SizedBox(width: 2.w),
                        Text(date,
                          style: fontMedium.copyWith(
                              fontSize: 9.sp,
                              color: AppColor.textColor
                          ),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

