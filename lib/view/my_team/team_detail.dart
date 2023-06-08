import 'package:elevens_organizer/view/my_team/team_detail_data.dart';
import 'package:elevens_organizer/view/my_team/team_detail_player_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/booking_provider.dart';
import '../../providers/team_provider.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';

class TeamDetail extends StatefulWidget {
  final String teamId, teamName;
  const TeamDetail(this.teamId, this.teamName, {Key? key}) : super(key: key);

  @override
  State<TeamDetail> createState() => _TeamDetailState();
}

class _TeamDetailState extends State<TeamDetail> with SingleTickerProviderStateMixin{

  bool loading = false;
  late TabController tabController;

  setDelay() async {
    if(mounted){
      setState(() {
        loading = true;
      });
    }
    getSquad();
    await Future.delayed(const Duration(seconds: 1));
    if(mounted){
      setState(() {
        loading = false;
      });
    }
  }

  getSquad(){
    Provider.of<TeamProvider>(context, listen: false).getPlayersListOfTeam(widget.teamId);
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    setDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: Consumer<TeamProvider>(
        builder: (context, squad, child) {
          return Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 32.h,
                    child: ClipPath(
                      clipper: ProsteBezierCurve(
                        position: ClipPosition.bottom,
                        list: [
                          BezierCurveSection(
                            start: Offset(0, 27.h),
                            top: Offset(MediaQuery.of(context).size.width / 2, 32.h),
                            end: Offset(MediaQuery.of(context).size.width, 27.h),
                          ),
                        ],
                      ),
                      child: Image.asset(Images.pitchImage, fit: BoxFit.cover,),
                    ),
                  ),
                  Positioned(
                    child: SizedBox(
                      width: double.infinity,
                      height: 32.h,
                      child: ClipPath(
                        clipper: ProsteBezierCurve(
                          position: ClipPosition.bottom,
                          list: [
                            BezierCurveSection(
                              start: Offset(0, 27.h),
                              top: Offset(MediaQuery.of(context).size.width / 2, 32.h),
                              end: Offset(MediaQuery.of(context).size.width, 27.h),
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
                              fontSize: 16.sp,
                              color: AppColor.lightColor
                          ),),
                        SizedBox(width: 7.w,),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10.h,
                    child: Column(
                      children: [
                        Container(
                          height: 13.h,
                          width: 26.w,
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColor.imageBorderColor, width: 2),
                              shape: BoxShape.circle,
                              color: Colors.white,
                              image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(Images.teamTopImage))
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Positioned(
                          left: 10.w,
                          right: 10.w,
                          child: Center(
                            child: Text(widget.teamName,
                              overflow: TextOverflow.ellipsis,
                              style: fontBold.copyWith(
                                  fontSize: 16.sp,
                                  color: AppColor.lightColor
                              ),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              TabBar(
                  isScrollable: true,
                  indicatorColor: AppColor.secondaryColor,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelStyle: fontMedium.copyWith(
                      fontSize: 12.sp
                  ),
                  unselectedLabelColor: AppColor.unselectedTabColor,
                  labelColor: AppColor.secondaryColor,
                  controller: tabController,
                  tabs: const [
                    Tab(
                      text: "Team Details",
                    ),
                    Tab(
                      text: "Squad",
                    ),
                  ]),
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
                      TeamDetailData(widget.teamId),
                      TeamDetailPlayerList(squad, setDelay),
                    ]),
              ),
            ],
          );
        }
      ),
    );
  }
}
