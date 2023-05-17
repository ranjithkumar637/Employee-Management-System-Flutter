import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  getPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool? login = preferences.getBool("isLoggedIn");

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
