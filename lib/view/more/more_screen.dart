import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:provider/provider.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../providers/auth_provider.dart';
import '../../providers/navigation_provider.dart';
import '../../providers/profile_provider.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import '../toss/flip_call_upcoming_list.dart';
import '../widgets/snackbar.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {


  getProfile(){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProfileProvider>(context, listen: false).getProfile();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: 28.h,
                child: Image.asset(Images.pitchImage, fit: BoxFit.cover,),
              ),
              Positioned(
                top: 5.h,
                left: 5.w,
                right: 5.w,
                child: Center(
                  child: Text("Profile",
                    style: fontMedium.copyWith(
                        fontSize: 16.sp,
                        color: AppColor.lightColor
                    ),),
                ),
              ),
              Positioned(
                top: 10.h,
                left: 5.w,
                right: 5.w,
                child: Consumer<ProfileProvider>(
                    builder: (context, profile, child) {
                      return Row(
                        children: [
                          Container(
                            height: 14.h,
                            width: 28.w,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColor.imageBorderColor, width: 3.0),
                                color: Colors.white,
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage("https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg?w=1380&t=st=1680345590~exp=1680346190~hmac=eb31a40018f2115d71ee38e25576a27bf9933b85d832af6bb6ece771dc2c4d42"))
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(profile.getName(),
                                  style: fontMedium.copyWith(
                                      fontSize: 15.sp,
                                      color: AppColor.lightColor
                                  ),),
                                SizedBox(height: 0.5.h),
                                Text(profile.getMobile(),
                                  style: fontRegular.copyWith(
                                      fontSize: 10.sp,
                                      color: AppColor.lightColor
                                  ),),
                                SizedBox(height: 0.5.h),
                                Bounceable(
                                  onTap:(){
                                    Provider.of<ProfileProvider>(context, listen: false).clearGroundAddress();
                                    Navigator.pushNamed(context, 'edit_profile')
                                        .then((value) {
                                      getProfile();
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 3.w,
                                      vertical: 1.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffF9D700),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Text("Edit Profile",
                                      style: fontRegular.copyWith(
                                          color: AppColor.textColor,
                                          fontSize: 8.sp
                                      ),),
                                  ),
                                ),
                                SizedBox(height: 0.5.h),
                                SizedBox(
                                  width: 40.w,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("66%",
                                        style: fontRegular.copyWith(
                                            fontSize: 9.sp,
                                            color: AppColor.lightColor
                                        ),),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(3.0),
                                        child: const LinearProgressIndicator(
                                          color: Color(0xffF9D700),
                                          backgroundColor: AppColor.lightColor,
                                          value: 0.66,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 5.w
              ),
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Consumer<ProfileProvider>(
                        builder: (context, profile, child) {
                          return profile.organizerDetails.adminApprove == 1
                              ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Referral Code",
                                style: fontMedium.copyWith(
                                    fontSize: 14.sp,
                                    color: AppColor.textColor
                                ),),
                              SizedBox(height: 2.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10.w,
                                        vertical: 1.h,
                                      ),
                                      decoration: BoxDecoration(
                                          color: const Color(0xffFAEDD0),
                                          borderRadius: BorderRadius.circular(5.0),
                                          border: RDottedLineBorder.all(color: AppColor.primaryColor)
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(profile.organizerDetails.organizerRefCode.toString(),
                                            textAlign: TextAlign.center,
                                            style: fontMedium.copyWith(
                                                fontSize: 14.sp,
                                                color: AppColor.textColor
                                            ),),
                                          InkWell(
                                              onTap: (){
                                                FlutterClipboard.copy(profile.organizerDetails.organizerRefCode.toString()).then(( value ){
                                                  print('copied');
                                                  Dialogs.snackbar("Referral code copied to clipboard", context, isError: false);
                                                });

                                              },
                                              child: Icon(Icons.copy, color: const Color(0xff8E8E8E), size: 5.w,))
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  InkWell(
                                      onTap: (){
                                        Share.share(profile.organizerDetails.organizerRefCode.toString());
                                      },
                                      child: SvgPicture.asset(Images.share, color: AppColor.textColor, width: 6.w,))
                                ],
                              ),
                            ],
                          )
                              : const SizedBox();
                        }
                    ),
                    Consumer<ProfileProvider>(
                        builder: (context, profile, child) {
                          return profile.organizerDetails.groundApprove == 0
                              ? Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 3.w,
                              vertical: 1.2.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColor.redColor,
                              borderRadius: BorderRadius.circular(5.0),
                              ),
                                child: Text("Update the ground details to get approved",
                            style: fontMedium.copyWith(
                                  fontSize: 10.sp,
                                  color: AppColor.lightColor
                            ),),
                              )
                              : const SizedBox();
                        }
                    ),

                    SizedBox(height: 2.h),
                    Text("Overview",
                      style: fontMedium.copyWith(
                          fontSize: 14.sp,
                          color: AppColor.textColor
                      ),),
                    SizedBox(height: 1.h),
                    InkWell(
                        onTap: (){
                          Provider.of<NavigationProvider>(context, listen: false).setCurrentIndex(1);
                        },
                        child: const ProfileOption("Bookings")),
                    const Divider(thickness: 0.7,),
                    InkWell(
                        onTap: (){
                          Provider.of<NavigationProvider>(context, listen: false).setCurrentIndex(2);
                        },
                        child: const ProfileOption("Matches")),
                    const Divider(thickness: 0.7,),
                    InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, "payment_information");
                        },
                        child: const ProfileOption("Payment Information")),
                    const Divider(thickness: 0.7,),
                    InkWell(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const FlipCallUpcomingList()));
                        },
                        child: const ProfileOption("Flip/Call toss")),
                    const Divider(thickness: 0.7,),
                    SizedBox(height: 2.h),
                    Text("Settings",
                      style: fontMedium.copyWith(
                          fontSize: 14.sp,
                          color: AppColor.textColor
                      ),),
                    SizedBox(height: 1.h),
                    InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, "notification_screen");
                        },
                        child: const ProfileOption("Notifications")),
                    const Divider(thickness: 0.7,),
                    SizedBox(height: 2.h),
                    Text("About",
                      style: fontMedium.copyWith(
                          fontSize: 14.sp,
                          color: AppColor.textColor
                      ),),
                    SizedBox(height: 1.h),
                    const ProfileOption("Terms & conditions"),
                    const Divider(thickness: 0.7,),
                    const ProfileOption("Privacy Policy"),
                    const Divider(thickness: 0.7,),
                    InkWell(
                        onTap: (){
                          openLogoutSheet();
                        },
                        child: const ProfileOption("Log out")),
                    const Divider(thickness: 0.7,),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> openLogoutSheet() {
    var platform = Theme.of(context).platform;
    return showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: false,
        builder: (BuildContext context) {
          return Padding(
            padding: platform == TargetPlatform.iOS
                ? EdgeInsets.symmetric(
                vertical: 5.h,
                horizontal: 2.w)
                : EdgeInsets.symmetric(
                vertical: 1.h,
                horizontal: 2.w),
            child: Container(
                height: 20.h,
                padding: EdgeInsets.symmetric(
                    vertical: 2.h,
                    horizontal: 5.w),
                decoration: BoxDecoration(
                  color: AppColor.lightColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Are you sure?",
                      style: fontMedium.copyWith(
                          color: AppColor.textColor,
                          fontSize: 14.sp),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      "Would you like to logout?",
                      style: fontRegular.copyWith(
                          color: AppColor.textMildColor,
                          fontSize: 12.sp),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        //don't close the app
                        Expanded(
                          child: InkWell(
                            splashColor: Colors.grey,
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColor.secondaryColor, width: 0.5),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                      1.5.h),
                                  child: Text(
                                    "No",
                                    style: fontMedium.copyWith(
                                      color: AppColor.secondaryColor,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        //close the app
                        Expanded(
                          child: InkWell(
                            splashColor: Colors.grey,
                            onTap: () async {
                              AuthProvider().logout().then((value) async {
                                if (value.status == true) {
                                  Navigator.pop(context);
                                  Navigator.pushNamed(
                                      context, 'login_screen'
                                  ).then((value) {
                                    // Snackbar.hideSnackBar(context);
                                  });
                                  Dialogs.snackbar("You've been logged out. Please log back in.", context, isError: false);
                                  SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                                  preferences.clear();
                                }
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColor.secondaryColor,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                      1.5.h),
                                  child: Text(
                                    "Yes",
                                    style: fontMedium.copyWith(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          );
        });
  }
}

class ProfileOption extends StatelessWidget {
  final String option;
  const ProfileOption(this.option, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 0.7.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(option,
            style: fontRegular.copyWith(
                fontSize: 11.sp,
                color: AppColor.textColor
            ),),
          Icon(Icons.arrow_forward_ios, color: const Color(0xff8E8E8E), size: 3.5.w,)
        ],
      ),
    );
  }
}
