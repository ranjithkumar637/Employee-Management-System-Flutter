import 'dart:io';
import 'package:elevens_organizer/providers/profile_provider.dart';
import 'package:elevens_organizer/view/menu/widgets/bottom_menu_text.dart';
import 'package:elevens_organizer/view/more/more_screen.dart';
import 'package:elevens_organizer/view/my_matches/my_matches.dart';
import 'package:elevens_organizer/view/revenue/revenue_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/navigation_provider.dart';
import '../../utils/colours.dart';
import '../../utils/connectivity_status.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import '../home/home_screen.dart';
import '../my_bookings/bookings.dart';
import '../my_team/my_teams.dart';
import '../widgets/no_internet_view.dart';
import '../widgets/snackbar.dart';

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
    const MyBookings(),
    const MyMatchesScreen(),
    const RevenueScreen(),
    const MoreScreen()
  ];

  moveToBookings() {
    setState(() {
      _currentIndex = 1;
    });
  }

  moveToMatches() {
    setState(() {
      _currentIndex = 2;
    });
  }

  moveToRevenue() {
    setState(() {
      _currentIndex = 3;
    });
  }

  moveToHome(){
    setState(() {
      _currentIndex = 0;
    });
  }

  moveToMore(){
    setState(() {
      _currentIndex = 4;
    });
  }

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

  checkForUpdate(){
    InAppUpdate.checkForUpdate().then((updateInfo) {
      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        if (updateInfo.immediateUpdateAllowed) {
          // Perform immediate update
          InAppUpdate.performImmediateUpdate().then((appUpdateResult) {
            if (appUpdateResult == AppUpdateResult.success) {
              //App Update successful
              Dialogs.snackbar("Enjoy the latest version !!", context, isError: false, isLong: true);
            }
          });
        } else if (updateInfo.flexibleUpdateAllowed) {
          //Perform flexible update
          InAppUpdate.startFlexibleUpdate().then((appUpdateResult) {
            if (appUpdateResult == AppUpdateResult.success) {
              //App Update successful
              InAppUpdate.completeFlexibleUpdate();
              Dialogs.snackbar("Enjoy the latest version !!", context, isError: false, isLong: true);
            }
          });
        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkForUpdate();
  }


  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    if (connectionStatus == ConnectivityStatus.offline) {
      return const NoInternetView();
    }
    return WillPopScope(
      onWillPop: () async{
        if(_currentIndex == 0){
          return openExitSheet();
        } else {
          Provider.of<NavigationProvider>(context, listen: false).setCurrentIndex(0);
          moveToHome();
          return false;
        }
      },
      child: Scaffold(
        body: pages.elementAt(_currentIndex),
        bottomNavigationBar: Consumer<NavigationProvider>(
          builder: (context, nav, child) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if(nav.currentIndex == 0){
                moveToHome();
              } else if(nav.currentIndex == 1){
                moveToBookings();
              } else if(nav.currentIndex == 2){
                moveToMatches();
              }else if(nav.currentIndex == 3){
                moveToRevenue();
              } else if(nav.currentIndex == 4){
                moveToMore();
              }
             });
            return Consumer<ProfileProvider>(
              builder: (context, move, child) {
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  if (move.bookings == true) {
                    moveToBookings();
                  } else if(move.matches == true){
                    moveToMatches();
                  }
                  else if(move.revenue == true){
                    moveToMatches();
                  }
                  else
                  {
                    null;
                  }
                });
                return Container(
                  height: 9.h,
                  padding: EdgeInsets.symmetric(
                    horizontal: 3.w,
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
                          onTap:() { _onItemTapped(0);
                          Provider.of<ProfileProvider>(context,
                              listen: false)
                              .removeBookings();
                          Provider.of<ProfileProvider>(context,
                              listen: false)
                              .removeMatches();
                          Provider.of<NavigationProvider>(context, listen: false).setCurrentIndex(0);
                            },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18.0),
                              color: _currentIndex == 0 ? AppColor.iconBgColor : Colors.transparent
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(Images.homeIcon, width: 6.w, color: _currentIndex == 0 ? AppColor.iconColour : AppColor.inactiveBottomNavText,),
                                MenuText("Home", _currentIndex == 0 ? AppColor.iconColour : AppColor.inactiveBottomNavText),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(width:3.w),
                      Expanded(
                        child: Bounceable(
                          onTap:(){
                            _onItemTapped(1);
                            Provider.of<ProfileProvider>(context,
                                listen: false)
                                .removeBookings();
                            Provider.of<ProfileProvider>(context,
                                listen: false)
                                .removeMatches();
                            Provider.of<NavigationProvider>(context, listen: false).setCurrentIndex(1);
                            },
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
                                SvgPicture.asset(Images.bookings, width: 6.w, color: _currentIndex == 1 ? AppColor.iconColour : AppColor.inactiveBottomNavText,),
                                MenuText("Bookings", _currentIndex == 1 ? AppColor.iconColour : AppColor.inactiveBottomNavText),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(width:3.w),
                      Expanded(
                        child: Bounceable(
                          onTap:() {
                            _onItemTapped(2);
                            Provider.of<ProfileProvider>(context,
                                listen: false)
                                .removeBookings();
                            Provider.of<ProfileProvider>(context,
                                listen: false)
                                .removeMatches();
                            Provider.of<NavigationProvider>(context, listen: false).setCurrentIndex(2);
                            },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18.0),
                                color: _currentIndex == 2 ? AppColor.iconBgColor : Colors.transparent
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(Images.matches, width: 6.w, color: _currentIndex == 2 ? AppColor.iconColour : AppColor.inactiveBottomNavText,),
                                MenuText("Matches", _currentIndex == 2 ? AppColor.iconColour : AppColor.inactiveBottomNavText),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(width:3.w),
                      Expanded(
                        child: Bounceable(
                          onTap:(){ _onItemTapped(3);
                          Provider.of<ProfileProvider>(context,
                              listen: false)
                              .removeBookings();
                          Provider.of<ProfileProvider>(context,
                              listen: false)
                              .removeMatches();
                          Provider.of<NavigationProvider>(context, listen: false).setCurrentIndex(3);
                            },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18.0),
                                color: _currentIndex == 3 ? AppColor.iconBgColor : Colors.transparent
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                SvgPicture.asset(Images.revenue, width: 6.w, color: _currentIndex == 3 ? AppColor.iconColour : AppColor.inactiveBottomNavText,),
                                MenuText("Revenue", _currentIndex == 3 ? AppColor.iconColour : AppColor.inactiveBottomNavText),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        child: Bounceable(
                          onTap:(){ _onItemTapped(4);
                          Provider.of<ProfileProvider>(context,
                              listen: false)
                              .removeBookings();
                          Provider.of<ProfileProvider>(context,
                              listen: false)
                              .removeMatches();
                          Provider.of<NavigationProvider>(context, listen: false).setCurrentIndex(4);
                            },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18.0),
                                color: _currentIndex == 4 ? AppColor.iconBgColor : Colors.transparent
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(Images.moreIcon, width: 6.w, color: _currentIndex == 4 ? AppColor.iconColour : AppColor.inactiveBottomNavText,),
                                MenuText("More", _currentIndex == 4 ? AppColor.iconColour : AppColor.inactiveBottomNavText),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            );
          }
        ),
      ),
    );
  }
}