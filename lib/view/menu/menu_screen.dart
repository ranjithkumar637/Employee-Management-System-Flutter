import 'dart:io';
import 'package:elevens_organizer/view/menu/widgets/bottom_menu_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import '../home/home_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  var _currentIndex = 0;
  int index = 0;

  List<Widget> pages = <Widget>[
    const HomeScreen(),
  Container(),
    Container(),
    Container(),
    // const MyTeams(),
    // const PlayVS(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  openExitSheet() {
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
                      "Would you like to close the app?",
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
                              exit(0);
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


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return openExitSheet();
      },
      child: Scaffold(
        body: pages.elementAt(_currentIndex),
        bottomNavigationBar: Container(
          height: 9.h,
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
            vertical: 1.h,
          ),
          decoration: const BoxDecoration(
            color: AppColor.lightColor,
            boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0,0),
                          blurRadius: 3.0,
                          spreadRadius: 3.0
                      ),
                    ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
            )
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Bounceable(
                  onTap:() => _onItemTapped(0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0),
                      color: _currentIndex == 0 ? AppColor.iconBgColor : Colors.transparent
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(Images.home, width: 6.w, color: _currentIndex == 0 ? AppColor.iconColour : AppColor.inactiveBottomNavText,),
                        MenuText("Home", _currentIndex == 0 ? AppColor.iconColour : AppColor.inactiveBottomNavText),
                      ],
                    ),
                  ),
                ),
              ),
              // SizedBox(width:3.w),
              Expanded(
                child: Bounceable(
                  onTap:() => _onItemTapped(1),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 1.w,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.0),
                        color: _currentIndex == 1 ? AppColor.iconBgColor : Colors.transparent
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(Images.myTeams, width: 6.w, color: _currentIndex == 1 ? AppColor.iconColour : AppColor.inactiveBottomNavText,),
                        MenuText("My Teams", _currentIndex == 1 ? AppColor.iconColour : AppColor.inactiveBottomNavText),
                      ],
                    ),
                  ),
                ),
              ),
              // SizedBox(width:3.w),
              Expanded(
                child: Bounceable(
                  onTap:() => _onItemTapped(2),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.0),
                        color: _currentIndex == 2 ? AppColor.iconBgColor : Colors.transparent
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(Images.playVs, width: 6.w, color: _currentIndex == 2 ? AppColor.iconColour : AppColor.inactiveBottomNavText,),
                        MenuText("PlayVS", _currentIndex == 2 ? AppColor.iconColour : AppColor.inactiveBottomNavText),
                      ],
                    ),
                  ),
                ),
              ),
              // SizedBox(width:3.w),
              Expanded(
                child: Bounceable(
                  onTap:() => _onItemTapped(3),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.0),
                        color: _currentIndex == 3 ? AppColor.iconBgColor : Colors.transparent
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        SvgPicture.asset(Images.more, width: 6.w, color: _currentIndex == 3 ? AppColor.iconColour : AppColor.inactiveBottomNavText,),
                        MenuText("More", _currentIndex == 3 ? AppColor.iconColour : AppColor.inactiveBottomNavText),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}