import 'package:elevens_organizer/view/my_matches/player_list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/animation/animation_preferences.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/match_team_player_list_model.dart';
import '../../providers/booking_provider.dart';
import '../../providers/profile_provider.dart';
import '../../utils/colours.dart';
import '../../utils/styles.dart';
import '../widgets/loader.dart';

class YourOpponentTeam extends StatefulWidget {
  final String matchId, teamId;
  const YourOpponentTeam(this.matchId, this.teamId, {super.key});

  @override
  State<YourOpponentTeam> createState() => _YourOpponentTeamState();
}

class _YourOpponentTeamState extends State<YourOpponentTeam> {

  bool loading = false;
  List<MatchTeamPlayerList> matchTeamPlayerList = [];
  List<MatchTeamPlayerList> captainList = [];
  List<MatchTeamPlayerList> vcList = [];
  List<MatchTeamPlayerList> adminList = [];
  List<MatchTeamPlayerList> playerList = [];


  filterList(){
    setState(() {
      matchTeamPlayerList = Provider.of<BookingProvider>(context, listen: false).matchTeamPlayerList;
      captainList = matchTeamPlayerList.where((player) => player.role.toString() == "Captain").toList();
      vcList = matchTeamPlayerList.where((player) => player.role.toString() == "Vice Captain").toList();
      adminList = matchTeamPlayerList.where((player) => player.role.toString() == "Admin").toList();
      playerList = matchTeamPlayerList.where((player) => player.role.toString() == "Player").toList();
    });
    print(captainList);
    print(vcList);
    print(adminList);
    print(playerList);
  }

  setDelay() async{
    if(mounted){
      setState(() {
        loading = true;
      });
    }
    await Future.delayed(const Duration(seconds: 1));
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<BookingProvider>(context, listen: false)
          .getPlayersListOfTeamForMatch(widget.teamId, widget.matchId)
          .then((value) {
        filterList();
      });
    });
    if(mounted){
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(
      builder: (context, team, child) {
        return Consumer<ProfileProvider>(
            builder: (context, match, child) {
              return Container(
                margin: EdgeInsets.only(
                    top: 2.h
                ),
                decoration: const BoxDecoration(
                  color: AppColor.lightColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    topLeft: Radius.circular(20.0),
                  ),
                ),
                child: loading
                    ? const Loader()
                    : match.matchDetails.teamBName.toString() == "null" || match.matchDetails.teamBName.toString() == ""
                  ? Center(
                    child: Text("To be Announced",
                style: fontMedium.copyWith(
                    color: AppColor.redColor,
                    fontSize: 12.sp
                ),),
                  )
                : team.matchData.teamBFreeze.toString() == "0"
                    ? Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 2.h,
                    ),
                    child: Text("Team not yet frozen",
                      style: fontMedium.copyWith(
                          fontSize: 12.sp,
                          color: AppColor.redColor
                      ),),
                  ),
                ) : FadeIn(
                  preferences: const AnimationPreferences(
                      duration: Duration(milliseconds: 600)
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        captainList.isEmpty
                            ? const SizedBox()
                            : Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                            vertical: 2.h,
                          ),
                          child: Text("Captain",
                            style: fontMedium.copyWith(
                                fontSize: 12.sp,
                                color: AppColor.secondaryColor
                            ),),
                        ),
                        captainList.isEmpty
                            ? const SizedBox()
                            : MediaQuery.removePadding(
                          removeTop: true,
                          context: context,
                          child: ListView.separated(

                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              separatorBuilder: (context, _){
                                return const Divider();
                              },
                              itemCount: captainList.length,
                              itemBuilder: (context, index){
                                final player = captainList[index];
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5.w,
                                    vertical: 1.h,
                                  ),
                                  child: PlayerListCard(captainList[index].name.toString(),
                                      captainList[index].role.toString(),
                                      captainList[index].profilePhoto.toString(), false,
                                      "", '', "", player, captainList[index].playerId.toString()
                                  ),
                                );
                              }
                          ),
                        ),
                        vcList.isEmpty
                            ? const SizedBox()
                            : Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                            vertical: 2.h,
                          ),
                          child: Text("Vice Captain",
                            style: fontMedium.copyWith(
                                fontSize: 12.sp,
                                color: AppColor.secondaryColor
                            ),),
                        ),
                        vcList.isEmpty
                            ? const SizedBox()
                            : MediaQuery.removePadding(
                          removeTop: true,
                          context: context,
                          child: ListView.separated(

                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              separatorBuilder: (context, _){
                                return const Divider();
                              },
                              itemCount: vcList.length,
                              itemBuilder: (context, index){
                                final player = vcList[index];
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5.w,
                                    vertical: 1.h,
                                  ),
                                  child: PlayerListCard(vcList[index].name.toString(),
                                      vcList[index].role.toString(),
                                      vcList[index].profilePhoto.toString(), false,
                                      "", '', "", player, vcList[index].playerId.toString()
                                  ),
                                );
                              }
                          ),
                        ),
                        adminList.isEmpty
                            ? const SizedBox()
                            : Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                            vertical: 2.h,
                          ),
                          child: Text("Admin",
                            style: fontMedium.copyWith(
                                fontSize: 12.sp,
                                color: AppColor.secondaryColor
                            ),),
                        ),
                        adminList.isEmpty
                            ? const SizedBox()
                            : MediaQuery.removePadding(
                          removeTop: true,
                          context: context,
                          child: ListView.separated(

                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              separatorBuilder: (context, _){
                                return const Divider();
                              },
                              itemCount: adminList.length,
                              itemBuilder: (context, index){
                                final player = adminList[index];
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5.w,
                                    vertical: 1.h,
                                  ),
                                  child: PlayerListCard(adminList[index].name.toString(),
                                      adminList[index].role.toString(),
                                      adminList[index].profilePhoto.toString(), false,
                                      "", '', "", player, adminList[index].playerId.toString()
                                  ),
                                );
                              }
                          ),
                        ),
                        playerList.isEmpty
                            ? const SizedBox()
                            : Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                            vertical: 2.h,
                          ),
                          child: Text("Players (${playerList.length})",
                            style: fontMedium.copyWith(
                                fontSize: 12.sp,
                                color: AppColor.secondaryColor
                            ),),
                        ),
                        MediaQuery.removePadding(
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
                                itemCount: playerList.length,
                                itemBuilder: (context, index){
                                  final player = playerList[index];
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 5.w,
                                      vertical: 1.h,
                                    ),
                                    child: PlayerListCard(playerList[index].name.toString(),
                                        playerList[index].role.toString(),
                                        playerList[index].profilePhoto.toString(), false,
                                        "", '', "", player, playerList[index].playerId.toString()
                                    ),
                                  );
                                }
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
        );
      }
    );
  }
}
