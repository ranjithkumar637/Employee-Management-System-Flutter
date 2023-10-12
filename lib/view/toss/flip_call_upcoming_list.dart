import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:elevens_organizer/providers/team_provider.dart';
import 'package:elevens_organizer/utils/colours.dart';
import 'package:elevens_organizer/utils/styles.dart';
import 'package:elevens_organizer/view/toss/toss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/today_matches_toss_model.dart';
import '../../utils/app_constants.dart';
import '../../utils/connectivity_status.dart';
import '../../utils/images.dart';
import '../widgets/loader.dart';
import '../widgets/no_internet_view.dart';
import '../widgets/snackbar.dart';

class FlipCallUpcomingList extends StatefulWidget {
  const FlipCallUpcomingList({super.key});

  @override
  State<FlipCallUpcomingList> createState() => _FlipCallUpcomingListState();
}

class _FlipCallUpcomingListState extends State<FlipCallUpcomingList> {
  Future<List<TodayMatches>> ? futureData;
  bool loading = false;

  String timeDifference = 'Calculating...';
  StreamController<String> timerController = StreamController<String>();


  bool checkTossGraceTimePassed(String startTime) {
    DateTime currentTime = DateTime.now();

    int hours = int.parse(startTime.substring(0, 2));
    int minutes = int.parse(startTime.substring(3, 5));
    bool isPM = startTime.endsWith('PM');

    if (isPM && hours != 12) {
      hours += 12;
    } else if (!isPM && hours == 12) {
      hours = 0;
    }

    DateTime parsedTime = DateTime(
      currentTime.year,
      currentTime.month,
      currentTime.day,
      hours,
      minutes,
    );

    Duration difference = currentTime.difference(parsedTime);

    print('Time Difference: ${difference.toString()}');
    if (difference.inHours > 1) {
      print('Time Difference is more than 1 hour');
      return true;
    } else {
      print('Time Difference is not more than 1 hour');
      return false;
    }
  }

  String checkTimeDifference(String end){
    DateTime currentTime = DateTime.now();

    // Parse end time string into a DateTime object (with today's date)
    DateFormat format = DateFormat("h:mm a");
    DateTime endTime = DateTime(
      currentTime.year,
      currentTime.month,
      currentTime.day,
      format.parse(end).hour,
      format.parse(end).minute,
    );

    // Calculate the time difference in minutes
    int timeDifferenceInMinutes = endTime.difference(currentTime).inMinutes + 1;

    // Calculate time difference in hours and remaining minutes
    int timeDifferenceInHours = timeDifferenceInMinutes ~/ 60;
    int remainingMinutes = timeDifferenceInMinutes % 60;

    String formattedTimeDifference = "";

    if (timeDifferenceInHours > 0) {
      formattedTimeDifference =
      '$timeDifferenceInHours hour${timeDifferenceInHours > 1 ? 's' : ''} ';
    }

    if (remainingMinutes > 0) {
      formattedTimeDifference =
      '$formattedTimeDifference$remainingMinutes minute${remainingMinutes > 1 ? 's' : ''}';
    }

    print('Time difference: $formattedTimeDifference');
    return formattedTimeDifference;

  }

  int checkTimePassed(String end){
    DateTime currentTime = DateTime.now();

    // Parse end time string into a DateTime object (with today's date)
    DateFormat format = DateFormat("h:mm a");
    DateTime endTime = DateTime(
      currentTime.year,
      currentTime.month,
      currentTime.day,
      format.parse(end).hour,
      format.parse(end).minute,
    );

    // Calculate the time difference in minutes
    int timeDifferenceInMinutes = endTime.difference(currentTime).inMinutes + 1;

    // Format the result as "X minutes"
    String formattedTimeDifference = '$timeDifferenceInMinutes minutes';

    print('Time difference: $formattedTimeDifference');
    return timeDifferenceInMinutes;
  }


  List<TodayMatches> todayMatches=[];

  getTodayMatchList(){
    futureData = TeamProvider().getTodayMatch().then((value) {
      print(value);
      setState(() {
        todayMatches=[];
        todayMatches.addAll(value);
      });
      print(todayMatches);
      return(todayMatches);
    });
  }

  setDelay()async{
   setState(() {
     loading=true;
   });
   getTodayMatchList();
   await Future.delayed(const Duration(seconds:1));
   setState(() {
     loading=false;
   });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setDelay();
  }

  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    if (connectionStatus == ConnectivityStatus.offline) {
      return const NoInternetView();
    }
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            SizedBox(height: 5.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back,size: 7.w,color: AppColor.textColor,)),
                Text('Flip / Call (Toss)',style: fontMedium.copyWith(fontSize: 14.sp,color: AppColor.textColor),),
               SizedBox(width: 6.w,),
              ],
            ),
            SizedBox(height: 3.h,),
            todayMatches.isEmpty || checkTimePassed(todayMatches.first.teamAData!.bookingSlotStart) == 0
                || checkTimePassed(todayMatches.first.teamAData!.bookingSlotStart) < 0
            ? const SizedBox()
            : Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 2.w,
                vertical: 1.h,
              ),
              decoration: BoxDecoration(
                color: AppColor.lightColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: RichText(
                  text: TextSpan(
                    text: "The next match scheduled is SET to begin in another ",style: fontRegular.copyWith(
                    fontSize: 11.sp,color: AppColor.hintColour,
                  ),
                    children: <TextSpan>[
                      TextSpan(
                        text: checkTimeDifference(todayMatches.first.teamAData!.bookingSlotStart.toString()),
                          style: fontMedium.copyWith(
                        fontSize: 11.sp,
                        color: AppColor.redColor
                      )
                      )
                    ]
                  ),
                ),
              ),
            ),
            SizedBox(height: 3.h,),
            loading
            ? const Loader()
            : Expanded(
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: todayMatches.isEmpty
                    ? Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 10.h),
                      Image.asset(Images.noMatches, width: 80.w, fit: BoxFit.cover,),
                      SizedBox(height: 3.h),
                      Text("You don’t have any matches",
                        style: fontMedium.copyWith(
                            fontSize: 12.sp,
                            color: AppColor.redColor
                        ),),
                    ],
                  ),
                )
                    : ListView.separated(
                  separatorBuilder: (context, _) {
                    return SizedBox(height: 2.h,);
                  },
                  itemCount: todayMatches.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, int index) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      startTimer(todayMatches[index].teamBData!.bookingSlotStart.toString());
                    });
                    return Bounceable(
                      onTap: (){
                        if(todayMatches[index].freezeCount.toString() == "2" && todayMatches[index].teamACaptain.toString() == "1" && todayMatches[index].teamBCaptain.toString() == "1"){
                          if(int.parse(todayMatches[index].matchTeamACount.toString()) >= 11 && int.parse(todayMatches[index].matchTeamBCount.toString()) >= 11){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) =>
                                    Toss(
                                      todayMatches[index].teamAData!.teamName
                                          .toString(),
                                      todayMatches[index].teamAData!.teamId
                                          .toString(),
                                      todayMatches[index].teamBData!.teamName
                                          .toString(),
                                      todayMatches[index].teamBData!.teamId
                                          .toString(),
                                      todayMatches[index].teamAData!.matchId
                                          .toString(),
                                      todayMatches[index].teamAData!.logo
                                          .toString(),
                                      todayMatches[index].teamBData!.logo
                                          .toString(),
                                    )));
                          } else if(int.parse(todayMatches[index].matchTeamACount.toString()) >= 11 && int.parse(todayMatches[index].matchTeamBCount.toString()) < 11){
                            Dialogs.snackbar("Team ${todayMatches[index].teamBData?.teamName.toString()} is yet to be frozen with a minimum of 11 players", context, isError: true);
                          } else if(int.parse(todayMatches[index].matchTeamACount.toString()) < 11 && int.parse(todayMatches[index].matchTeamBCount.toString()) >= 11){
                            Dialogs.snackbar("Team ${todayMatches[index].teamAData?.teamName.toString()} is yet to be frozen with a minimum of 11 players", context, isError: true);
                          } else if(int.parse(todayMatches[index].matchTeamACount.toString()) < 11 && int.parse(todayMatches[index].matchTeamBCount.toString()) < 11){
                            Dialogs.snackbar("Both teams yet to be frozen with a minimum of 11 players", context, isError: true);
                          }
                        }
                        else if(todayMatches[index].teamBData!.teamFreeze.toString() == "1" && todayMatches[index].teamBCaptain.toString() == "0"
                            && todayMatches[index].teamAData!.teamFreeze.toString() == "1" && todayMatches[index].teamACaptain.toString() == "0"){
                          Dialogs.snackbar("No captain assigned in both teams", context, isError: true);
                        } else if(todayMatches[index].teamAData!.teamFreeze.toString() == "1" && todayMatches[index].teamACaptain.toString() == "0"){
                          Dialogs.snackbar("No captain assigned in ${todayMatches[index].teamAData!.teamName
                              .toString()}", context, isError: true);
                        } else if(todayMatches[index].teamBData!.teamFreeze.toString() == "1" && todayMatches[index].teamBCaptain.toString() == "0"){
                          Dialogs.snackbar("No captain assigned in ${todayMatches[index].teamBData!.teamName
                              .toString()}", context, isError: true);
                        } else {
                          Dialogs.snackbar("Both teams must be frozen to flip a toss", context, isError: true);
                        }
                      },
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
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      ClipOval(
                                        child: CachedNetworkImage(imageUrl: "${
                                            AppConstants.imageBaseUrl
                                        }${AppConstants.imageBaseUrlTeam}${todayMatches[index].teamAData?.logo}",
                                          errorWidget: (context, url, error) => Image.asset(Images.createTeamBg, fit: BoxFit.cover, width: 22.w,
                                            height: 10.h,),
                                          width: 22.w,
                                          height: 10.h,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      if(todayMatches[index].teamAData!.teamFreeze.toString() == "0")...[
                                        SizedBox(height: 1.h),
                                        Text(
                                          "Team not yet frozen",
                                          style: fontMedium
                                              .copyWith(
                                              fontSize:
                                              9.sp,
                                              color: AppColor
                                                  .redColor),
                                        ),
                                      ] else ...[
                                        const SizedBox()
                                      ],
                                      if(todayMatches[index].teamAData!.teamFreeze.toString() == "1" && todayMatches[index].teamACaptain.toString() == "0")...[
                                        SizedBox(height: 1.h),
                                        Text(
                                          "Captain not assigned",
                                          style: fontMedium
                                              .copyWith(
                                              fontSize:
                                              9.sp,
                                              color: AppColor
                                                  .redColor),
                                        ),
                                      ] else ...[
                                        const SizedBox()
                                      ],

                                    ],
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 1.w,
                                      ),
                                      child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                            text: "${todayMatches[index].teamAData?.teamName.toString()}\n",
                                            style: fontBold.copyWith(
                                              color: AppColor.textColor,
                                              fontSize: 11.sp,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: 'vs\n',
                                                  style:
                                                  fontMedium.copyWith(
                                                    color: AppColor
                                                        .redColor,
                                                    fontSize: 10.sp,
                                                  )),
                                              TextSpan(
                                                text: todayMatches[index].teamBData?.teamName.toString() == ""
                                                    ? "TBA"
                                                    : todayMatches[index].teamBData?.teamName.toString(),
                                                style: fontBold.copyWith(
                                                  color:
                                                  AppColor.textColor,
                                                  fontSize: 11.sp,
                                                ),
                                              )
                                            ]),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      ClipOval(
                                        child: CachedNetworkImage(imageUrl: "${
                                            AppConstants.imageBaseUrl
                                        }${AppConstants.imageBaseUrlTeam}${todayMatches[index].teamBData?.logo}",
                                          errorWidget: (context, url, error) => Image.asset(Images.createTeamBg, fit: BoxFit.cover, width: 22.w,
                                            height: 10.h,),
                                          width: 22.w,
                                          height: 10.h,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      if(todayMatches[index].teamBData!.teamFreeze.toString() == "0")...[
                                        SizedBox(height: 1.h),
                                        Text(
                                          "Team not yet frozen",
                                          style: fontMedium
                                              .copyWith(
                                              fontSize:
                                              9.sp,
                                              color: AppColor
                                                  .redColor),
                                        ),
                                      ] else ...[
                                        const SizedBox()
                                      ],
                                      if(todayMatches[index].teamBData!.teamFreeze.toString() == "1" && todayMatches[index].teamBCaptain.toString() == "0")...[
                                        SizedBox(height: 1.h),
                                        Text(
                                          "Captain not assigned",
                                          style: fontMedium
                                              .copyWith(
                                              fontSize:
                                              9.sp,
                                              color: AppColor
                                                  .redColor),
                                        ),
                                      ] else ...[
                                        const SizedBox()
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            DottedLine(
                              dashColor: AppColor.hintColour.withOpacity(0.4),
                            ),
                            Row(
                              children: [
                                StreamBuilder<String>(
                                  stream: timerController.stream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      String timeDifference = snapshot.data!;
                                      return SizedBox(
                                        height: 6.h,
                                        width: 34.w,
                                        child: ClipPath(
                                          clipper: CustomClipperWidget(),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.only(
                                                  bottomLeft: Radius.circular(12.0)
                                              ),
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  AppColor.secondaryColor.withOpacity(0.8),
                                                  AppColor.primaryColor.withOpacity(0.8),
                                                ],
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                timeDifference,
                                                style: fontMedium.copyWith(
                                                    fontSize: 13.sp,
                                                    color: AppColor.textColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return const Text('Loading...');
                                    }
                                  },
                                ),
                                SizedBox(width: 2.w),
                                Expanded(
                                  child: Text("#${todayMatches[index].matchNumber.toString()}",
                                    style: fontBold.copyWith(
                                        fontSize: 9.5.sp,
                                        color: const Color(0xff6495ED)
                                    ),),
                                ),
                                SizedBox(width: 1.w),
                                Expanded(
                                  child: Row(
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
                                      Expanded(
                                        child: Text(
                                          todayMatches[index].teamBData!.bookingSlotStart.toString(),
                                          style: fontMedium
                                              .copyWith(
                                              fontSize:
                                              9.sp,
                                              color: AppColor
                                                  .textColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void startTimer(String start) {
    DateTime currentTime = DateTime.now();
    DateFormat format = DateFormat("h:mm a");
    DateTime startTime = DateTime(
      currentTime.year,
      currentTime.month,
      currentTime.day,
      format.parse(start).hour,
      format.parse(start).minute,
    );

    // Replace '2023-10-05 17:30:00' with your desired time in the format 'YYYY-MM-DD HH:MM:SS'.
    DateTime targetTime = DateTime.parse(startTime.toString());
    int differenceInSeconds = targetTime.difference(currentTime).inSeconds;

    timerController.sink.add(formatTime(differenceInSeconds));
    // Start a timer that updates the time difference every minute
    Timer.periodic(const Duration(seconds: 1), (timer) {
      currentTime = DateTime.now();
      int newTimeDifferenceInMinutes =
          startTime.difference(currentTime).inSeconds + 1;
      timerController.sink.add(formatTime(newTimeDifferenceInMinutes));
    });
  }

  String formatTime(int seconds) {
    // int minutes = seconds ~/ 60;
    // int remainingSeconds = seconds % 60;
    Duration duration = Duration(seconds: seconds);

    if (duration.inHours >= 1) {
      // More than an hour remaining, format as "hh:mm:ss"
      return '${duration.inHours}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    } else {
      // Less than an hour remaining, format as "mm:ss"
      return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    }
  }

}

class CustomClipperWidget extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width * 0.8, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
