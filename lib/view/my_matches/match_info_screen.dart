import 'package:cached_network_image/cached_network_image.dart';
import 'package:elevens_organizer/view/my_matches/your_match_info.dart';
import 'package:elevens_organizer/view/my_matches/your_opponent_team.dart';
import 'package:elevens_organizer/view/my_matches/your_team.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/booking_provider.dart';
import '../../utils/app_constants.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import '../widgets/loader.dart';

class MatchInfoScreen extends StatefulWidget {
  final String matchId;
  const MatchInfoScreen({Key? key, required this.matchId}) : super(key: key);

  @override
  State<MatchInfoScreen> createState() => _MatchInfoScreenState();
}

class _MatchInfoScreenState extends State<MatchInfoScreen> with SingleTickerProviderStateMixin{

  late TabController tabController;
  bool loading = false;
  double _verticalDragStart = 0;
  bool moveToTop = false;

  void _onVerticalDragStart(DragStartDetails details) {
    _verticalDragStart = details.globalPosition.dy;
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    double currentPosition = details.globalPosition.dy;
    double difference =  _verticalDragStart - currentPosition;

    // Check if the swipe is upwards (from down to top)
    if (difference > 50) {
      // Trigger your action when swipe is detected
      print("Swiped to top!");
      setState(() {
        moveToTop = true;
      });
      // Replace the above print statement with the desired action you want to perform
    } else if (difference < -50) {
      // Trigger your action when swipe is detected
      print("Swiped to bottom!");
      setState(() {
        moveToTop = false;
      });
      // Replace the above print statement with the desired action you want to perform
    }
  }

  getMatchDetails(){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BookingProvider>(context, listen: false).getMatchInfo(widget.matchId)
          .then((value) async {
        if(value.status == true){
          await Future.delayed(const Duration(seconds: 1));
          setState(() {
            loading = false;
          });
        }
      });
    });

  }

  Future<void> setDelay() async {
    if(mounted){
      setState(() {
        loading = true;
      });
    }
    getMatchDetails();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    setDelay();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<BookingProvider>(
          builder: (context, match, child) {
            return loading
                ? const Loader()
                : Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: moveToTop ? 10.h : 32.h,
                      child: ClipPath(
                        clipper: ProsteBezierCurve(
                          position: ClipPosition.bottom,
                          list: [
                            BezierCurveSection(
                              start: Offset(0, moveToTop ? 10.h : 27.h),
                              top: Offset(MediaQuery.of(context).size.width / 2, moveToTop ? 10.h : 32.h),
                              end: Offset(MediaQuery.of(context).size.width, moveToTop ? 10.h : 27.h),
                            ),
                          ],
                        ),
                        child: Image.asset(Images.pitchImage, fit: BoxFit.cover,),
                      ),
                    ),
                    Positioned(
                      child: SizedBox(
                        width: double.infinity,
                        height: moveToTop ? 10.h : 32.h,
                        child: ClipPath(
                          clipper: ProsteBezierCurve(
                            position: ClipPosition.bottom,
                            list: [
                              BezierCurveSection(
                                start: Offset(0, moveToTop ? 10.h : 27.h),
                                top: Offset(MediaQuery.of(context).size.width / 2, moveToTop ? 10.h : 32.h),
                                end: Offset(MediaQuery.of(context).size.width, moveToTop ? 10.h : 27.h),
                              ),
                            ],
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xff333334),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 5.h,
                      left: 5.w,
                      right: 5.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Bounceable(
                              onTap:(){
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.arrow_back, color: AppColor.lightColor, size: 7.w,)),
                          Text("Team",
                            style: fontMedium.copyWith(
                                fontSize: 15.sp,
                                color: AppColor.lightColor
                            ),),
                          SizedBox(width: 7.w,),
                        ],
                      ),
                    ),
                    moveToTop
                        ? const SizedBox()
                        : Positioned(
                      left: 5.w,
                      right: 5.w,
                      top: 12.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: "${AppConstants.imageBaseUrl}${AppConstants.imageBaseUrlTeam}${match.teamAData.logo}",
                                height: 11.h,
                                width: 24.w,
                                fit: BoxFit.cover,
                                errorWidget:(context, url, error) =>
                                    ClipOval(
                                        child: Image.asset(Images.createTeamBg, fit: BoxFit.cover,)),
                              )),
                          SizedBox(width: 3.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('${match.teamAData.teamName}',
                                  overflow: TextOverflow.ellipsis,
                                  style: fontMedium.copyWith(
                                      fontSize: 13.sp,
                                      color: AppColor.lightColor
                                  ),),
                                SizedBox(height: 0.5.h),
                                Text('vs',
                                  style: fontMedium.copyWith(
                                      fontSize: 13.sp,
                                      color: AppColor.lightColor
                                  ),),
                                SizedBox(height: 0.5.h),
                                Text(match.teamBData.teamName.toString() == "null" ? "TBA" : match.teamBData.teamName.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: fontMedium.copyWith(
                                      fontSize: 13.sp,
                                      color: AppColor.lightColor
                                  ),),
                              ],
                            ),
                          ),
                          SizedBox(width: 3.w),
                          ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: "${AppConstants.imageBaseUrl}${AppConstants.imageBaseUrlTeam}${match.teamBData.logo}",
                                height: 11.h,
                                width: 24.w,
                                fit: BoxFit.cover,
                                errorWidget:(context, url, error) =>
                                    ClipOval(
                                        child: Image.asset(Images.createTeamBg, fit: BoxFit.cover,)),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                GestureDetector(
                  onVerticalDragStart: _onVerticalDragStart,
                  onVerticalDragUpdate: _onVerticalDragUpdate,
                  child: TabBar(
                      indicatorColor: AppColor.secondaryColor,
                      isScrollable: true,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelStyle: fontMedium.copyWith(
                          fontSize: 12.sp
                      ),
                      unselectedLabelColor: AppColor.unselectedTabColor,
                      labelColor: AppColor.secondaryColor,
                      controller: tabController,
                      tabs: [
                        Tab(
                          text: '${match.teamAData.teamName}',
                        ),
                        Tab(
                          text: match.teamBData.teamName.toString() == "null" ? "TBA" : match.teamBData.teamName.toString(),
                        ),
                        const Tab(
                          text: "Match Info",
                        ),
                      ]),
                ),
                Theme(
                    data: ThemeData(
                      dividerTheme: const DividerThemeData(
                        space: 0,
                        thickness: 0.5,
                        indent: 0,
                        endIndent: 0,
                      ),
                    ),
                    child: const Divider()),
                Expanded(
                  child: TabBarView(
                      controller: tabController,
                      children: [
                        YourTeam(widget.matchId, match.teamAData.id.toString()),
                        YourOpponentTeam(widget.matchId, match.teamBData.id.toString()),
                        const YourMatchInfo(),
                      ]),
                ),

              ],
            );
          }
      ),
    );
  }
}
