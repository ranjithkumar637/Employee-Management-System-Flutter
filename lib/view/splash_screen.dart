import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/images.dart';
import 'auth/enter_otp.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  getPrefs() async {

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
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool? login = preferences.getBool("isLoggedIn");
    String? userId = preferences.getString("user_temp_id");
    String? mobile = preferences.getString("mobile");
    bool? isLogin = preferences.getBool("isLoginScreen");
    print("user_id $userId mobile $mobile isLoginScreen $isLogin");

    if(login == true){
      String? token = await FirebaseMessaging.instance.getToken();
      print(token);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("device_token" , token.toString());
      Timer(
          const Duration(seconds: 2), () async {
        Navigator.pushNamed(context, 'menu_screen');
      }
      );
    }
    else if(userId == null) {
      Timer(
          const Duration(seconds: 2), () async {
        Navigator.pushNamed(context, 'login_screen');
      }
      );
    }
    else if(userId.isNotEmpty) {
      // Timer(
      //     const Duration(seconds: 2), () async {
      //   if(isLogin == true){
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) {
      //         return EnterOtpScreen(true, false, "", userId.toString(), mobile.toString(), true);
      //       }),
      //     );
      //   } else{
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) {
      //         return EnterOtpScreen(false, true, "", userId.toString(), mobile.toString(), true);
      //       }),
      //     );
      //   }
      // }
      // );
      Timer(
          const Duration(seconds: 2), () async {
        Navigator.pushNamed(context, 'login_screen');
      }
      );
    } else{
      Timer(
          const Duration(seconds: 2), () async {
        Navigator.pushNamed(context, 'login_screen');
      }
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: AppColor.lightColor,
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            Align(
                alignment: Alignment.topRight,
                child: SvgPicture.asset(Images.splashTopImage, fit: BoxFit.cover)),
            Align(
                alignment: Alignment.bottomLeft,
                child: SvgPicture.asset(Images.splashBottomImage, fit: BoxFit.cover)),
            Column(
              children: [
                FadeInRight(
                  child: Align(
                      alignment: Alignment.topRight,
                      child: SvgPicture.asset(Images.splashTop, fit: BoxFit.cover, width: 100.w,)),
                ),
                const Spacer(),
                ZoomIn(child: Image.asset(Images.logo, width: 50.w,)),
                const Spacer(),
                FadeInLeft(
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: SvgPicture.asset(Images.splashBottom, fit: BoxFit.cover, width: 100.w,)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
