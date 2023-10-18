import 'package:app_settings/app_settings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clipboard/clipboard.dart';
import 'package:elevens_organizer/view/profile/edit_profile.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:provider/provider.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../providers/auth_provider.dart';
import '../../providers/navigation_provider.dart';
import '../../providers/profile_provider.dart';
import '../../providers/team_provider.dart';
import '../../utils/app_constants.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import '../auth/login_screen.dart';
import '../toss/flip_call_upcoming_list.dart';
import '../widgets/snackbar.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {

  bool permissionGranted = true;


  getProfile() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.setForegroundNotificationPresentationOptions(
        sound: true,
        badge: true,
        alert: true
    );
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if(mounted){
        setState(() {
          permissionGranted = true;
        });
      }
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      if(mounted){
        setState(() {
          permissionGranted = true;
        });
      }
      print('User granted provisional permission');
    } else {
      if(mounted){
        setState(() {
          permissionGranted = false;
        });
      }
      print('User declined or has not accepted permission');
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ProfileProvider().getProfile(context)
          .then((value) async {
        if(value.status == true){
          Provider.of<ProfileProvider>(context, listen: false).getProfile(context);
        } else if(value.status == false && value.message.toString() == "Unauthenticated"){
          Dialogs.snackbar("User unauthenticated", context, isError: true);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) {
              return const LoginScreen();
            }),
          );
          SharedPreferences preferences =
              await SharedPreferences.getInstance();
          preferences.clear();
        }
      });
    });
  }

  double calculateProgressValue(String progress){
    double value = int.parse(progress) / 100;
    return value;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Column(
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
                    top: 2.h + statusBarHeight,
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
                              ClipOval(
                                child: CachedNetworkImage(
                                  height: 12.h,
                                  width: 24.w,
                                  fit: BoxFit.cover,
                                  imageUrl: "${AppConstants.imageBaseUrl}${AppConstants.imageBaseUrlProfile}${profile.organizerDetails.profilePhoto.toString()}",
                                  errorWidget: (context, url, widget){
                                    return Image.network("https://cdn-icons-png.flaticon.com/256/4389/4389644.png", height: 14.h,
                                      width: 28.w,
                                      fit: BoxFit.cover,);
                                  },
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
                                        Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) {
                                        return const EditProfile();
                                      }),
                                    ).then((value) {
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
                                          Text("${profile.organizerDetails.progressValue}%",
                                            style: fontRegular.copyWith(
                                                fontSize: 9.sp,
                                                color: AppColor.lightColor
                                            ),),
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(3.0),
                                            child: LinearProgressIndicator(
                                              color: const Color(0xffF9D700),
                                              backgroundColor: AppColor.lightColor,
                                              value: double.parse(calculateProgressValue(profile.organizerDetails.progressValue.toString()).toString()),
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
                                                      Dialogs.snackbar("Referral code copied", context, isError: false);
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
                                            String url = "https://play.google.com/store/apps/details?id=com.eleven.captain";
                                            Share.share('Hey fellow cricket captains! Enjoy the game even more by using our referral code ${profile.organizerDetails.organizerRefCode.toString()}.'
                                                ' It\'s your ticket to fantastic cricket experiences. Share the code and let\'s play together! 🏏🤝 \n $url');
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
                              return profile.profileModel.groundCount.toString() == "0" ?
                              Bounceable(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return const EditProfile();
                                    }),
                                  ).then((value) {
                                    getProfile();
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: 2.h
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 3.w,
                                    vertical: 1.2.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColor.redColor.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text("Currently, we're awaiting your update on the ground info!",
                                          style: fontMedium.copyWith(
                                              fontSize: 10.sp,
                                              color: AppColor.lightColor
                                          ),),
                                      ),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: AppColor.lightColor,
                                        size: 6.w,
                                      ),
                                    ],
                                  ),
                                ),
                              ) :
                              profile.profileModel.groundCount.toString() == "1" && profile.organizerDetails.groundApprove == 0
                                  ? Bounceable(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return const EditProfile();
                                    }),
                                  ).then((value) {
                                    getProfile();
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: 2.h
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 3.w,
                                    vertical: 1.2.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColor.redColor.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text("Awaiting admin's approval, your ground will be approved very shortly",
                                          style: fontMedium.copyWith(
                                              fontSize: 10.sp,
                                              color: AppColor.lightColor
                                          ),),
                                      ),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: AppColor.lightColor,
                                        size: 6.w,
                                      ),
                                    ],
                                  ),
                                ),
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
                        // InkWell(
                        //     onTap: (){
                        //       Navigator.pushNamed(context, "payment_information");
                        //     },
                        //     child: const ProfileOption("Payment Information")),
                        // const Divider(thickness: 0.7,),
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
                        InkWell(
                            onTap: (){
                              _launchUrl("https://11scricket360.com/terms-conditions/");
                            },
                            child: const ProfileOption("Terms & conditions")),
                        const Divider(thickness: 0.7,),
                        InkWell(
                            onTap: (){
                              _launchUrl("https://11scricket360.com/privacy-policy/");
                            },
                            child: const ProfileOption("Privacy Policy")),
                        const Divider(thickness: 0.7,),
                        InkWell(
                            onTap: (){
                              _launchUrl("https://11scricket360.com/cancellation-refund-policy");
                            },
                            child: const ProfileOption("Cancellation and Refund Policy")),
                        const Divider(thickness: 0.7,),
                        InkWell(
                            onTap: (){
                              openLogoutSheet();
                            },
                            child: const ProfileOption("Log out")),
                        const Divider(thickness: 0.7,),
                        SizedBox(height: permissionGranted ? 0 : 12.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          permissionGranted
          ? const SizedBox()
          : Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 3.w,
                vertical: 2.h,
              ),
              width: double.maxFinite,
              decoration: const BoxDecoration(
                color: Color(0xffFEF5E7),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text("Allow permission to get notified for every action on your 11s journey",
                      style: fontMedium.copyWith(
                        color: const Color(0xff34495E),
                        fontSize: 11.sp
                      ),
                    ),
                  ),
                  SizedBox(width: 3.w),
                  InkWell(
                    onTap: () => AppSettings.openAppSettings(type: AppSettingsType.notification),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 2.w,
                        vertical: 1.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xff34495E),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Text("Go to Settings",
                        style: fontMedium.copyWith(
                            color: AppColor.lightColor,
                            fontSize: 10.sp
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
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
                              SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                              AuthProvider().logout().then((value) async {
                                if (value.status == true) {
                                  Dialogs.snackbar("You've been logged out.", context, isError: false);
                                  preferences.clear();
                                  WidgetsBinding.instance.addPostFrameCallback((_) async {
                                    Navigator.pushReplacementNamed(
                                        context, 'login_screen'
                                    );
                                   });
                                } else if (value.status == false) {
                                  Dialogs.snackbar(
                                      value.message.toString(),
                                      context, isError: true);
                                } else {
                                  Dialogs.snackbar(
                                      "Something went wrong. Please try again",
                                      context, isError: true);
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
