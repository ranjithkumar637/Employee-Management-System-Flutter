import 'package:elevens_organizer/view/my_team/team_player_list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/animation/animation_preferences.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_up.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:sizer/sizer.dart';

import '../../providers/team_provider.dart';
import '../../utils/colours.dart';
import '../../utils/styles.dart';

class TeamDetailPlayerList extends StatefulWidget {
  final TeamProvider squad;
  final VoidCallback setDelay;
  const TeamDetailPlayerList(this.squad, this.setDelay, {Key? key}) : super(key: key);

  @override
  State<TeamDetailPlayerList> createState() => _TeamDetailPlayerListState();
}

class _TeamDetailPlayerListState extends State<TeamDetailPlayerList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 1.h,
      ),
      decoration: const BoxDecoration(
          color: AppColor.lightColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0)
          )
      ),
      child: FadeInUp(
        preferences: const AnimationPreferences(
            duration: Duration(milliseconds: 500)
        ),
        child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.w,
                  vertical: 1.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2.h),
                    Text("Captain",
                      style: fontMedium.copyWith(
                          fontSize: 12.sp,
                          color: AppColor.secondaryColor
                      ),),
                    SizedBox(height: 2.h),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.squad.captainData.length,
                        itemBuilder: (context, index) {
                          return TeamPlayerListCard(
                              widget.squad.captainData[index].captainName.toString(),
                              widget.squad.captainData[index].captainRole.toString(),
                              "https://bcciplayerimages.s3.ap-south-1.amazonaws.com/playerheadshot/bcci/1000x1280/164.png",
                              false,
                              "", "", "cap", widget.setDelay
                          );
                        }
                    ),
                    SizedBox(height: 2.h),
                    widget.squad.vcData.isEmpty
                        ? const SizedBox()
                        : Text("Vice Captain",
                      style: fontMedium.copyWith(
                          fontSize: 12.sp,
                          color: AppColor.secondaryColor
                      ),),
                    widget.squad.vcData.isEmpty
                        ? const SizedBox()
                        : SizedBox(height: 2.h),
                    widget.squad.vcData.isEmpty
                        ? const SizedBox()
                        : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.squad.vcData.length,
                        itemBuilder: (context, index) {
                          return TeamPlayerListCard(
                              widget.squad.vcData[index].viceCaptainName.toString(),
                              widget.squad.vcData[index].role.toString(),
                              "https://bcciplayerimages.s3.ap-south-1.amazonaws.com/playerheadshot/bcci/1000x1280/164.png",
                              true,
                              widget.squad.vcData[index].teamPlayerTableId.toString(),
                              widget.squad.vcData[index].teamId.toString(), "vc", widget.setDelay
                          );
                        }
                    ),
                    widget.squad.adminData.isEmpty
                        ? const SizedBox()
                        : SizedBox(height: 2.h),
                    widget.squad.adminData.isEmpty
                        ? const SizedBox()
                        : Text("Admin",
                      style: fontMedium.copyWith(
                          fontSize: 12.sp,
                          color: AppColor.secondaryColor
                      ),),
                    widget.squad.adminData.isEmpty
                        ? const SizedBox()
                        : SizedBox(height: 2.h),
                    widget.squad.adminData.isEmpty
                        ? const SizedBox()
                        : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.squad.adminData.length,
                        itemBuilder: (context, index) {
                          return TeamPlayerListCard(
                              widget.squad.adminData[index].adminName.toString(),
                              widget.squad.adminData[index].adminRole.toString(),
                              "https://bcciplayerimages.s3.ap-south-1.amazonaws.com/playerheadshot/bcci/1000x1280/164.png",
                              true,
                              widget.squad.adminData[index].teamPlayerTableId.toString(),
                              widget.squad.adminData[index].teamId.toString(), "admin", widget.setDelay
                          );
                        }
                    ),
                  ],
                ),
              ),
              const Divider(),
              widget.squad.teamPlayerList.isEmpty
                  ? const SizedBox()
                  : Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.w,
                ) + EdgeInsets.only(
                    top: 2.h
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("All Players",
                      style: fontMedium.copyWith(
                          fontSize: 12.sp,
                          color: AppColor.secondaryColor
                      ),),
                  ],
                ),
              ),
              widget.squad.teamPlayerList.isEmpty
                  ? const SizedBox()
                  : SizedBox(height: 2.h),
              widget.squad.teamPlayerList.isEmpty
                  ? const SizedBox()
                  : Expanded(
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: Scrollbar(
                    radius: const Radius.circular(3.0),
                    child: ListView.separated(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (context, _){
                          return const Divider();
                        },
                        itemCount: widget.squad.teamPlayerList.length,
                        itemBuilder: (context, index){
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5.w,
                              vertical: 1.h,
                            ),
                            child: Bounceable(
                                onTap: (){
                                  Navigator.pushNamed(context, 'profile_screen');
                                },
                                child: TeamPlayerListCard(
                                    widget.squad.teamPlayerList[index].playerName.toString(),
                                    widget.squad.teamPlayerList[index].playerRole.toString(),
                                    "https://bcciplayerimages.s3.ap-south-1.amazonaws.com/playerheadshot/bcci/1000x1280/164.png",
                                    true,
                                    widget.squad.teamPlayerList[index].teamPlayerTableId.toString(),
                                    widget.squad.teamPlayerList[index].teamId.toString(), "player",
                                    widget.setDelay
                                )),
                          );
                        }
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
