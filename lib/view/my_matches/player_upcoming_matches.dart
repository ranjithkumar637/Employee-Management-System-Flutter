
import 'package:elevens_organizer/view/my_matches/player_match_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/colours.dart';
import '../../../utils/images.dart';
import '../../../utils/styles.dart';
import '../../models/player_upcoming_match_list_model.dart';
import '../../providers/profile_provider.dart';
import '../widgets/loader.dart';

class PlayerUpcomingMatches extends StatefulWidget {
  final String playerId;
  const PlayerUpcomingMatches(this.playerId, {Key? key}) : super(key: key);

  @override
  State<PlayerUpcomingMatches> createState() => _PlayerUpcomingMatchesState();
}

class _PlayerUpcomingMatchesState extends State<PlayerUpcomingMatches> {

  bool loading = false;

  Future<List<PlayerUpcomingMatch>>? futureData;
  List<PlayerUpcomingMatch> upcomingMatchList = [];

  getPlayerUpcomingMatchesList(){
    futureData = ProfileProvider().getPlayerUpcomingMatchList(widget.playerId).then((value) {
      if(mounted){
        setState(() {
          upcomingMatchList = [];
          upcomingMatchList.addAll(value);
          loading = false;
        });
      }
      print(upcomingMatchList);
      return upcomingMatchList;
    });
  }

  setDelay(){
    setState(() {
      loading = true;
    });
    getPlayerUpcomingMatchesList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 2.h
      ),
      child: upcomingMatchList.isEmpty
        ? Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 4.h),
            Image.asset(Images.noMatches, width: 60.w, fit: BoxFit.cover,),
            SizedBox(height: 3.h),
            Text("No upcoming matches",
              style: fontMedium.copyWith(
                  fontSize: 12.sp,
                  color: AppColor.redColor
              ),),
          ],
        ),
      )
      : MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: FutureBuilder(
              future: futureData,
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Loader();
                }
                if(snapshot.connectionState == ConnectionState.done){
                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (context, _){
                      return SizedBox(height: 1.5.h);
                    },
                    itemCount: upcomingMatchList.length,
                    itemBuilder: (context, index){
                      return Bounceable(
                        onTap:(){

                        },
                        child: PlayerMatchCard(
                          upcomingMatchList[index].teamAName.toString(),
                          upcomingMatchList[index].teamBName.toString(),
                          upcomingMatchList[index].bookingDate.toString(),
                          upcomingMatchList[index].bookingSlotStart.toString(),
                          upcomingMatchList[index].groundName.toString(),
                          upcomingMatchList[index].mainImage.toString(),
                        ),
                      );
                    },
                  );
                } else{
                  return const Loader();
                }

              }
          )),
    );
  }
}
