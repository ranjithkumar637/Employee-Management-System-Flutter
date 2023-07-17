import 'package:elevens_organizer/view/home/points_revenue_box.dart';
import 'package:elevens_organizer/view/home/ref_code_dialog_box.dart';
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
import '../widgets/slot_colour_info.dart';
import 'custom_date_picker.dart';
import 'home_grid_options.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool loading = false;
  DateTime deliveryDate = DateTime.now();

  setDelay() async {
    if(mounted){
      setState(() {
        loading = true;
      });
    }
    getProfile();
    await Future.delayed(const Duration(seconds: 1));
    // showReferralCode();
    if(mounted){
      setState(() {
        loading = false;
      });
    }
  }

  showReferralCode(){
    showDialog(context: context,
        builder: (BuildContext context){
          return const RefCodeDialog(refCode: "GHYYH1900UI");
        }
    );
  }

  getProfile(){
    Provider.of<ProfileProvider>(context, listen: false).getProfile();
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
                    bottom: -90.0,
                    right: 5.w,
                    left: 5.w,
                    child: Row(
                      children: [
                        const Expanded(
                          child: PointsAndRevenueBox(Images.refPointsImage, "Total Referral\nPoints", "250 pt", 1),
                        ),
                        SizedBox(width: 4.w),
                        const Expanded(
                          child: PointsAndRevenueBox(Images.revenueAmountImage, "Total Revenue\nAmount", "25000", 2),
                        ),
                      ],
                    ),
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
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColor.imageBorderColor, width: 3.0),
                              color: Colors.white,
                              image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage("https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg?w=1380&t=st=1680345590~exp=1680346190~hmac=eb31a40018f2115d71ee38e25576a27bf9933b85d832af6bb6ece771dc2c4d42"))
                            ),
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Consumer<ProfileProvider>(
                          builder: (context, profile, child) {
                            return Expanded(
                              child: Text("Hello!\n${profile.getName()}",
                                style: fontMedium.copyWith(
                                    fontSize: 14.sp,
                                    color: AppColor.lightColor
                                ),),
                            );
                          }
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GestureDetector(
                                onTap:(){
                                  Navigator.pushNamed(context, "notification_screen");
                                },
                                child: SvgPicture.asset(Images.notification, color: AppColor.lightColor, width: 5.5.w,)),
                            SizedBox(height: 2.h),
                            profile.organizerDetails.adminApprove == 1 ? Bounceable(
                              onTap: (){
                                showReferralCode();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 3.w,
                                  vertical: 0.6.h,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: Row(
                                  children: [
                                    Text("BHFHDF9800M",
                                      style: fontRegular.copyWith(
                                          fontSize: 10.sp,
                                          color: AppColor.lightColor
                                      ),),
                                    SizedBox(width: 2.w),
                                    SvgPicture.asset(Images.share, color: AppColor.lightColor, width: 4.w,),
                                  ],
                                ),
                              ),
                            ) : const SizedBox(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 3.w,
                          vertical: 1.5.h
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: 5.w,
                          vertical: 2.h
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.lightColor,
                          borderRadius: BorderRadius.circular(15.0),
                            ),
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("This Week Battle",
                                  style: fontMedium.copyWith(
                                      color: AppColor.textColor,
                                      fontSize: 12.sp
                                  ),),
                                SizedBox(height: 1.5.h),
                                CustomDatePicker(
                                    onDateSelected: (date) {
                                      setState(() {
                                        deliveryDate = date;
                                      });
                                    },
                                    itemWidth: 15.w),
                              ],
                            ),
                            SizedBox(height: 2.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Slot Time",
                                  style: fontMedium.copyWith(
                                      color: AppColor.textColor,
                                      fontSize: 11.sp
                                  ),),
                                SizedBox(height: 1.5.h),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text("2 left",
                                            style: fontMedium.copyWith(
                                                color: AppColor.textColor,
                                                fontSize: 8.sp
                                            ),),
                                          SizedBox(height: 0.5.h),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 6.w,
                                              vertical: 0.8.h,
                                            ),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30.0),
                                                color: AppColor.availableSlot
                                            ),
                                            child: Text("7:00 AM",
                                              style: fontRegular.copyWith(
                                                  color: AppColor.lightColor,
                                                  fontSize: 10.sp
                                              ),),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text("2 left",
                                            style: fontMedium.copyWith(
                                                color: AppColor.textColor,
                                                fontSize: 8.sp
                                            ),),
                                          SizedBox(height: 0.5.h),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 6.w,
                                              vertical: 0.8.h,
                                            ),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30.0),
                                                color: AppColor.selectedSlot
                                            ),
                                            child: Text("11:00 AM",
                                              style: fontRegular.copyWith(
                                                  color: AppColor.textColor,
                                                  fontSize: 10.sp
                                              ),),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text("Full",
                                            style: fontMedium.copyWith(
                                                color: AppColor.textColor,
                                                fontSize: 8.sp
                                            ),),
                                          SizedBox(height: 0.5.h),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 6.w,
                                              vertical: 0.8.h,
                                            ),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30.0),
                                                color: AppColor.bookedSlot
                                            ),
                                            child: Text("2:00 PM",
                                              style: fontRegular.copyWith(
                                                  color: AppColor.textColor,
                                                  fontSize: 10.sp
                                              ),),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),                         ],
                            ),
                            SizedBox(height: 2.h),
                            InkWell(
                              onTap: (){
                                Navigator.pushNamed(context, 'view_opponent_team');
                              },
                              child: Center(
                                child: Text("View (Opponent)",
                                  style: fontMedium.copyWith(
                                      fontSize: 10.sp,
                                      color: AppColor.secondaryColor
                                  ),),
                              ),
                            ),
                            SizedBox(height: 1.h),
                            const SlotColourInfo(),
                          ],
                        ),
                      ),
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
}





