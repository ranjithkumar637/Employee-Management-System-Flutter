import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      Timer(
          const Duration(seconds: 2), () async {
        if(isLogin == true){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return EnterOtpScreen(true, false, "", userId.toString(), mobile.toString());
            }),
          );
        } else{
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return EnterOtpScreen(false, true, "", userId.toString(), mobile.toString());
            }),
          );
        }
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
        body: Column(
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
      ),
    );
  }
}
