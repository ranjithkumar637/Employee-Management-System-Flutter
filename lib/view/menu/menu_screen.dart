import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elevens_organizer/providers/profile_provider.dart';
import 'package:elevens_organizer/view/menu/widgets/bottom_menu_text.dart';
import 'package:elevens_organizer/view/more/more_screen.dart';
import 'package:elevens_organizer/view/my_matches/my_matches.dart';
import 'package:elevens_organizer/view/revenue/revenue_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/navigation_provider.dart';
import '../../utils/colours.dart';
import '../../utils/connectivity_status.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import '../home/home_screen.dart';
import '../my_bookings/bookings.dart';
import '../widgets/no_internet_view.dart';
import '../widgets/snackbar.dart';
import 'new_update_bottom_sheet.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with WidgetsBindingObserver{

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

  // checkForUpdate(){
  //   InAppUpdate.checkForUpdate().then((updateInfo) {
  //     if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
  //       if (updateInfo.immediateUpdateAllowed) {
  //         // Perform immediate update
  //         InAppUpdate.performImmediateUpdate().then((appUpdateResult) {
  //           if (appUpdateResult == AppUpdateResult.success) {
  //             //App Update successful
  //             Dialogs.snackbar("Enjoy the latest version !!", context, isError: false, isLong: true);
  //           }
  //         });
  //       } else if (updateInfo.flexibleUpdateAllowed) {
  //         //Perform flexible update
  //         InAppUpdate.startFlexibleUpdate().then((appUpdateResult) {
  //           if (appUpdateResult == AppUpdateResult.success) {
  //             //App Update successful
  //             InAppUpdate.completeFlexibleUpdate();
  //             Dialogs.snackbar("Enjoy the latest version !!", context, isError: false, isLong: true);
  //           }
  //         });
  //       }
  //     }
  //   });
  // }

  bool sheetOpen = false;

  setSheetOpenValue(){
    setState(() {
      sheetOpen = false;
    });
    print("method trigerred");
  }

  checkForUpdate() async {
    debugPrint("checking for any new update");
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    debugPrint(appName);
    debugPrint(packageName);
    debugPrint(version);
    debugPrint(buildNumber);
    FirebaseFirestore fireStore = FirebaseFirestore.instance;

    // Get the reference to the "version" collection and document "1"
    DocumentReference docRef = fireStore.collection('version').doc('1');

    // Fetch the document
    DocumentSnapshot snapshot = await docRef.get();

    String versionName = "";
    String versionNumber = "";
    String versionReleaseNotes = "";
    bool versionPriority = false;
    String versionType = "";
    String buildNo = "";

    if (snapshot.exists) {
      // Access the data in the snapshot
      versionName = snapshot['version_name'].toString();
      versionNumber = snapshot['version'].toString();
      versionReleaseNotes = snapshot['release_notes'].toString();
      versionPriority = snapshot['priority'];
      versionType = snapshot['type'].toString();
      buildNo = snapshot['build_number'].toString();

      // Print or use the retrieved data
      debugPrint('Version Name: $versionName');
      debugPrint('Version number: $versionNumber');
      debugPrint('Build number: $buildNo');
      debugPrint('Release Notes: $versionReleaseNotes');
      debugPrint('Release priority: $versionPriority');
      debugPrint('Release type: $versionType');
    } else {
      debugPrint('Document does not exist');
    }

    int versionCheck = compareVersions(version, versionNumber.toString(), buildNumber, buildNo);
    print("version check value $versionCheck");
    if(versionCheck == -1){
      setState(() {
        sheetOpen = true;
      });
      showUpdateBottomSheet(versionName, versionReleaseNotes, versionPriority, versionType, versionNumber, buildNo);
    } else if(versionCheck == 1){
      setState(() {
        sheetOpen = false;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Dialogs.snackbar("You already have the latest version. That's good !", context);
      });
      debugPrint("You are already up to date");
    }
  }

  // Function to compare version strings
  int compareVersions(String installedVersion, String latestVersion, String installedBuildNo, String latestBuildNo) {
    List<String> v1 = installedVersion.split('.');
    List<String> v2 = latestVersion.split('.');

    int length = v1.length > v2.length ? v1.length : v2.length;

    for (int i = 0; i < length; i++) {
      int ver1 = i < v1.length ? int.parse(v1[i]) : 0;
      int ver2 = i < v2.length ? int.parse(v2[i]) : 0;

      if (ver1 < ver2) {
        return -1; // Version 1 is less than version 2
      } else if (ver1 > ver2) {
        return 1; // Version 1 is greater than version 2
      }

      // If version numbers are the same, compare build numbers
      if (int.parse(installedBuildNo) < int.parse(latestBuildNo)) {
        return -1; // Version 1 is less than version 2
      } else if (int.parse(installedBuildNo) > int.parse(latestBuildNo)) {
        return 1; // Version 1 is greater than version 2
      }
    }

    return 0; // Versions are equal
  }

  showUpdateBottomSheet(String versionHeading, String releaseNotes, bool priority, String type, String versionNumber, String buildNo){
    showModalBottomSheet(context: context,
        isScrollControlled: true,
        enableDrag: false,
        isDismissible: false,
        backgroundColor: Colors.transparent,
        builder: (context)=> NewUpdateBottomSheet(versionHeading, releaseNotes, priority, type, versionNumber, buildNo, setSheetOpenValue)
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // if(!kDebugMode){
      checkForUpdate();
    // }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);

    if(state == AppLifecycleState.inactive || state == AppLifecycleState.detached){
      return;
    }

    final isBackground = state == AppLifecycleState.paused;
    final isResumed = state == AppLifecycleState.resumed;
    final isInactive = state == AppLifecycleState.inactive;
    final isDetached = state == AppLifecycleState.detached;

    if(isBackground){
      print("app went background");
    } else if(isInactive){
      print("app partially visible");
    } else if(isDetached){
      print("app destroyed");
    }
    else if(!sheetOpen && isResumed){
      checkForUpdate();
      print("app is live again");
    }
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