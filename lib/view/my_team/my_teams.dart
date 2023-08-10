import 'package:cached_network_image/cached_network_image.dart';
import 'package:elevens_organizer/view/my_team/team_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/animation/animation_preferences.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_up.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/team_provider.dart';
import '../../utils/app_constants.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';

class MyTeams extends StatefulWidget {
  const MyTeams({Key? key}) : super(key: key);

  @override
  State<MyTeams> createState() => _MyTeamsState();
}

class _MyTeamsState extends State<MyTeams> {

  getTeams(){
    Provider.of<TeamProvider>(context, listen: false).getTeamList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTeams();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 5.w
            ) + EdgeInsets.only(
                top: 5.h, bottom: 3.h
            ),
            child: Center(
              child: Text("Teams",
                style: fontMedium.copyWith(
                    fontSize: 16.sp,
                    color: AppColor.textColor
                ),),
            ),
          ),
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.w
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(Images.createTeamBg, fit: BoxFit.cover, width: 100.w, height: 20.h,)),
              ),
              Container(
                height: 20.h,
                width: 100.w,
                margin: EdgeInsets.symmetric(
                  horizontal: 5.w,
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Color(0xff222222),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 12.w,
                top: 6.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Create Team",
                      style: fontMedium.copyWith(
                          fontSize: 16.sp,
                          color: AppColor.lightColor
                      ),),
                    SizedBox(height: 2.h),
                    Bounceable(
                      onTap: (){
                        Navigator.pushNamed(context, 'create_team')
                        .then((value){
                          getTeams();
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 1.w,
                          vertical: 0.5.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.lightColor,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 1.w,
                                vertical: 0.5.h,
                              ),
                              decoration: const BoxDecoration(
                                color: AppColor.secondaryColor,
                                shape: BoxShape.circle
                              ),
                              child: Icon(Icons.add_rounded, color: AppColor.lightColor, size: 5.w,),
                            ),
                            SizedBox(width: 5.w),
                            Text("Add",
                              style: fontMedium.copyWith(
                                  fontSize: 12.sp,
                                  color: AppColor.textColor
                              ),),
                            SizedBox(width: 2.w),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Expanded(
            child: FadeInUp(
              preferences: const AnimationPreferences(
                  duration: Duration(milliseconds: 400)
              ),
              child: Consumer<TeamProvider>(
                  builder: (context, team, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        team.teamList.isEmpty
                        ? Text("You have not created your team yet. Start creating your first team now",
                          style: fontMedium.copyWith(
                              fontSize: 14.sp,
                              color: AppColor.redColor
                          ),)
                        : Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("All Teams",
                                style: fontMedium.copyWith(
                                    fontSize: 14.sp,
                                    color: AppColor.textColor
                                ),),
                              SizedBox(height: 1.h),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: MediaQuery.removePadding(
                              removeTop: true,
                              context: context,
                              child: GridView.builder(
                                physics: const BouncingScrollPhysics(),
                                addRepaintBoundaries: false,
                                addAutomaticKeepAlives: false,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 6.h,
                                    crossAxisSpacing: 4.w,
                                    childAspectRatio: 1.2
                                ),
                                itemCount: team.teamList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Bounceable(
                                      onTap: (){
                                        Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) {
                                        return TeamDetail(team.teamList[index].id.toString(), team.teamList[index].teamName.toString(), team.teamList[index].logo.toString());
                                      }),
                                    );
                                  },
                                      child: AllTeams(team.teamList[index].logo.toString(), team.teamList[index].teamName.toString()));
                                },

                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 1.h),
                      ],
                    );
                  }
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AllTeams extends StatelessWidget {
  final String image, name;
  const AllTeams(this.image, this.name, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10.0),
          topLeft: Radius.circular(10.0)
        ),
        boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0,0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0
                  ),
                ]
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              child: CachedNetworkImage(imageUrl: "${AppConstants.imageBaseUrl}${AppConstants.imageBaseUrlTeam}$image",
                fit: BoxFit.cover, width: double.maxFinite, height: double.maxFinite,
                errorWidget:(context, url, error) =>
                    Image.asset(Images.createTeamBg, fit: BoxFit.cover, width: double.maxFinite, height: double.maxFinite,),
              )
          ),
          Positioned(
            top: 1.5.h,
            right: 3.w,
            child: Bounceable(
              onTap: (){
                // Navigator.pushNamed(context, 'edit_team');
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 0.6.w,
                  vertical: 0.3.h,
                ),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.lightColor
                ),
                child: Icon(Icons.more_vert_rounded, color: AppColor.secondaryColor, size: 5.w,),
              ),
            ),
          ),
          Positioned(
            bottom: -3.5.h,
            right: 0.0,
            left: 0.0,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 2.w,
                vertical: 1.h,
              ),
              decoration: const BoxDecoration(
                  color: AppColor.lightColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0,0),
                        blurRadius: 2.0,
                        spreadRadius: 0.0
                    ),
                  ]
              ),
              child: Center(
                child: Text(name,
                  style: fontMedium.copyWith(
                      color: AppColor.textColor,
                      fontSize: 12.sp
                  ),),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
