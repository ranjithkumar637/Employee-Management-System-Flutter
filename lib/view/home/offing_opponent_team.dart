import 'package:flutter/material.dart';
import 'package:flutter_animator/animation/animation_preferences.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_up.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/match_team_player_list_model.dart';
import '../../providers/booking_provider.dart';
import '../../providers/profile_provider.dart';
import '../../providers/team_provider.dart';
import '../../utils/colours.dart';
import '../../utils/scale_route.dart';
import '../../utils/styles.dart';
import '../my_matches/player_list_card.dart';
import '../my_matches/profile.dart';
import '../widgets/loader.dart';

class OffingOpponentTeam extends StatefulWidget {
  final String matchId, teamId, teamBName;
  const OffingOpponentTeam(this.matchId, this.teamId, this.teamBName, {Key? key}) : super(key: key);

  @override
  State<OffingOpponentTeam> createState() => _OffingOpponentTeamState();
}

class _OffingOpponentTeamState extends State<OffingOpponentTeam> {

  bool loading = false;

  List<MatchTeamPlayerList> captainList = [];
  List<MatchTeamPlayerList> vcList = [];
  List<MatchTeamPlayerList> adminList = [];
  List<MatchTeamPlayerList> playerList = [];

  setDelay() async {
    if(mounted){
      setState(() {
        loading = true;
      });
    }
    getSquad();
    await Future.delayed(const Duration(seconds: 1));
    if(mounted){
      setState(() {
        loading = false;
      });
    }
  }

  filterList(){
    List<MatchTeamPlayerList> matchTeamPlayerList = Provider.of<BookingProvider>(context, listen: false).matchTeamPlayerList;
    setState(() {
      captainList = matchTeamPlayerList.where((player) => player.role.toString() == "Captain").toList();
      vcList = matchTeamPlayerList.where((player) => player.role.toString() == "Vice Captain").toList();
      adminList = matchTeamPlayerList.where((player) => player.role.toString() == "Admin").toList();
      playerList = matchTeamPlayerList.where((player) => player.role.toString() == "Player").toList();
    });
  }

  getSquad(){
    String teamId = Provider.of<ProfileProvider>(context, listen: false).matchDetails.teamBId.toString();
    print("offing team b id $teamId");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BookingProvider>(context, listen: false).getPlayersListOfTeamForMatch(teamId, widget.matchId.toString())
          .then((value){
        filterList();
      });
     });
  }

  @override
  void initState() {
    super.initState();
    if(widget.teamBName == "TBA"){
      print("To Be Announced");
    } else {
      setDelay();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(
        builder: (context, squad, child) {
          return Consumer<TeamProvider>(
              builder: (context, team, child) {
                return Container(
                  margin: EdgeInsets.only(
                    top: 2.h,
                  ),
                  decoration: const BoxDecoration(
                      color: AppColor.lightColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0)
                      )
                  ),
                  child: widget.teamBName == "TBA"
                    ? Center(
                    child: Text("To Be Announced",
                    style: fontMedium.copyWith(
                      color: AppColor.redColor,
                      fontSize: 12.sp
                    ),),
                  )
                  : FadeInUp(
                    preferences: const AnimationPreferences(
                        duration: Duration(milliseconds: 500)
                    ),
                    child: Column(
                      children: [
                        if(loading)...[
                          const Loader()
                        ] else if(squad.matchData.teamAFreeze.toString() == "0")...[
                          Center(
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
                          )
                        ] else...[
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5.w,
                              vertical: 2.h,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Captain",
                                  style: fontMedium.copyWith(
                                      fontSize: 13.sp,
                                      color: AppColor.secondaryColor
                                  ),),
                                SizedBox(height: 2.h),
                                MediaQuery.removePadding(
                                  removeTop: true,
                                  context: context,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: captainList.length,
                                      itemBuilder: (context, index) {
                                        final player = captainList[index];
                                        return InkWell(
                                          onTap: (){
                                            Navigator.push(context, ScaleRoute(page: PlayerProfile(captainList[index].playerId.toString())));
                                          },
                                          child: PlayerListCard(
                                            captainList[index].name.toString(),
                                            captainList[index].role.toString(),
                                            captainList[index].profilePhoto.toString(),
                                            false,
                                            "", "", "", player,
                                            captainList[index].playerId.toString(),),
                                        );
                                      }
                                  ),
                                ),
                                SizedBox(height: 1.h),
                                const Divider(),
                                SizedBox(height: 1.h),
                                Text("Players (${playerList.length})",
                                  style: fontMedium.copyWith(
                                      fontSize: 13.sp,
                                      color: AppColor.secondaryColor
                                  ),),
                              ],
                            ),
                          ),
                          Expanded(
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
                                    itemCount: playerList.length,
                                    itemBuilder: (context, index){
                                      final player = playerList[index];
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 5.w,
                                          vertical: 1.h,
                                        ),
                                        child: InkWell(
                                          onTap: (){
                                            Navigator.push(context, ScaleRoute(page: PlayerProfile(playerList[index].playerId.toString())));
                                          },
                                          child: PlayerListCard(
                                            playerList[index].name.toString(),
                                            playerList[index].role.toString(),
                                            playerList[index].profilePhoto.toString(),
                                            false,
                                            "", "", "", player,
                                            playerList[index].playerId.toString(),
                                          ),
                                        ),
                                      );
                                    }
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }
          );
        }
    );
  }
}
