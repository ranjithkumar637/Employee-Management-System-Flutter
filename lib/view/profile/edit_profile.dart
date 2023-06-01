import 'package:elevens_organizer/utils/styles.dart';
import 'package:elevens_organizer/view/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/images.dart';
import 'information.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> with SingleTickerProviderStateMixin{

  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Image.asset(Images.offingImage, width: double.maxFinite, fit: BoxFit.cover, height: 34.h,),
              Positioned(
                child: Container(
                  width: double.maxFinite,
                  height: 34.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xff333334),
                        const Color(0xff333334).withOpacity(0.5),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 5.h,
                left: 5.w,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_back_ios_new, color: AppColor.lightColor, size: 4.5.w,),
                    SizedBox(width: 3.w),
                    Text("Back",
                    style: fontMedium.copyWith(
                      color: AppColor.lightColor,
                      fontSize: 12.sp
                    ),),
                  ],
                ),
              ),
              Positioned(
                top: 5.h,
                right: 5.w,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite_border_rounded, color: AppColor.lightColor, size: 6.w,),
                    SizedBox(width: 5.w),
                    SvgPicture.asset(Images.share, color: AppColor.lightColor, width: 6.w,)
                  ],
                ),
              ),
              Positioned(
                bottom: 1.h,
                child: Text("SQUARE OUT FIGHTERS",
                  style: fontMedium.copyWith(
                      color: AppColor.lightColor,
                      fontSize: 16.sp
                  ),),
              ),
              Positioned(
                top: 10.h,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.asset(Images.groundImage, width: 90.w, fit: BoxFit.cover, height: 18.h,)),
                    Positioned(
                      child: Container(
                        width: 90.w,
                        height: 18.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              const Color(0xff333334).withOpacity(0.1),
                              const Color(0xff333334).withOpacity(0.01),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      child: Bounceable(
                        onTap: (){

                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 0.6.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Text("Add",
                            style: fontMedium.copyWith(
                                fontSize: 10.sp,
                                color: AppColor.textColor
                            ),),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 1.h,
                      right: 2.w,
                      child: Text("5+ photos",
                        style: fontMedium.copyWith(
                            fontSize: 10.sp,
                            color: AppColor.lightColor
                        ),),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          TabBar(
              indicatorColor: AppColor.secondaryColor,
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: fontMedium.copyWith(
                  fontSize: 12.sp
              ),
              unselectedLabelColor: AppColor.unselectedTabColor,
              labelColor: AppColor.secondaryColor,
              controller: tabController,
              tabs: const [
                Tab(
                  text: "Profile",
                ),
                Tab(
                  text: "Information",
                ),
              ]),
          Theme(
              data: ThemeData(
                dividerTheme: const DividerThemeData(
                  space: 0,
                  thickness: 0.5,
                  indent: 0,
                  endIndent: 0,
                ),
              ),
              child: const Divider()),
          Expanded(
            child: TabBarView(
                controller: tabController,
                children: const [
                  Profile(),
                  Information(),
                ]),
          ),
        ],
      ),
    );
  }
}
