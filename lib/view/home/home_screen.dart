import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/profile_provider.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import 'home_grid_options.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool loading = false;

  setDelay() async {
    if(mounted){
      setState(() {
        loading = true;
      });
    }
    getProfile();
    await Future.delayed(const Duration(seconds: 2));
    if(mounted){
      setState(() {
        loading = false;
      });
    }
  }

  getProfile(){
    // Provider.of<ProfileProvider>(context, listen: false).getCaptainProfile();
  }

  @override
  void initState() {
    super.initState();
    setDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: loading
      ? Center(child: Lottie.asset("assets/wicket.json", width: 100.w))
      : Consumer<ProfileProvider>(
        builder: (context, profile, child) {
          return Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 28.h,
                    child: ClipPath(
                      clipper: ProsteBezierCurve(
                        position: ClipPosition.bottom,
                        list: [
                          BezierCurveSection(
                            start: Offset(0, 22.h),
                            top: Offset(MediaQuery.of(context).size.width / 2, 28.h),
                            end: Offset(MediaQuery.of(context).size.width, 22.h),
                          ),
                        ],
                      ),
                      child: Image.asset(Images.pitchImage, fit: BoxFit.cover,),
                    ),
                  ),
                  Positioned(
                    child: SizedBox(
                      height: 28.h,
                      width: double.infinity,
                      child: ClipPath(
                        clipper: ProsteBezierCurve(
                          position: ClipPosition.bottom,
                          list: [
                            BezierCurveSection(
                              start: Offset(0, 22.h),
                              top: Offset(MediaQuery.of(context).size.width / 2, 28.h),
                              end: Offset(MediaQuery.of(context).size.width, 22.h),
                            ),
                          ],
                        ),
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xff383838),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //referral points & revenue aomount
                  Positioned(
                    bottom: 0.0,
                    right: 5.w,
                    left: 5.w,
                    child: const SizedBox(),
                  ),
                  Positioned(
                    top: 5.h,
                    left: 5.w,
                    right: 5.w,
                    child: Row(
                      children: [
                        Bounceable(
                          onTap:(){
                                                                    },
                          child: Container(
                            height: 10.h,
                            width: 20.w,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage("https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg?w=1380&t=st=1680345590~exp=1680346190~hmac=eb31a40018f2115d71ee38e25576a27bf9933b85d832af6bb6ece771dc2c4d42"))
                            ),
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: Text("Hello! Ajith",
                            style: fontMedium.copyWith(
                                fontSize: 14.sp,
                                color: AppColor.lightColor
                            ),),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GestureDetector(
                                onTap:(){
                                  Navigator.pushNamed(context, "notification_screen");
                                },
                                child: SvgPicture.asset(Images.notification, color: AppColor.lightColor, width: 5.w,)),
                            SizedBox(height: 2.h),
                            Bounceable(
                              onTap: (){
                                openTeamCodesSheet();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 3.w,
                                  vertical: 0.6.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColor.primaryColor,
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: Center(
                                  child: Text("Team code",
                                    style: fontRegular.copyWith(
                                        fontSize: 11.sp,
                                        color: AppColor.textColor
                                    ),),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 5.w,
                    top: 17.5.h,
                    child: InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, "add_address");
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(Images.location, color: AppColor.locationIconColor, width: 4.5.w,),
                          SizedBox(width: 2.w),
                          Text("Chrompet, Chennai 600210",
                            style: fontRegular.copyWith(
                                fontSize: 11.sp,
                                color: AppColor.lightColor
                            ),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3.h),
              Expanded(
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      SizedBox(height: 2.h),
                      //6 options
                      const HomeGridOptions(),
                      SizedBox(height: 3.h),
                      //in the offing title
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w
                        ),
                        child: Text("Priority Requirement",
                          style: fontMedium.copyWith(
                              fontSize: 12.sp,
                              color: AppColor.textColor
                          ),),
                      ),
                      SizedBox(height: 2.h),
                      //horizontal listview
                      // const InTheOffingList(),
                      SizedBox(height: 4.h),

                    ],
                  ),
                ),
              ),
            ],
          );
        }
      ),
    );
  }

  void openTeamCodesSheet() {
    // showModalBottomSheet<void>(
    //     context: context,
    //     backgroundColor: Colors.transparent,
    //     isScrollControlled: true,
    //     builder: (BuildContext context) {
    //       return const TeamCodes();
    //     });
  }
}




