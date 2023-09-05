
import 'package:elevens_organizer/view/my_matches/player_match_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/colours.dart';
import '../../../utils/images.dart';
import '../../../utils/styles.dart';
import '../../models/player_match_history_list_model.dart';
import '../../providers/profile_provider.dart';
import '../widgets/loader.dart';

class PlayerPlayedMatches extends StatefulWidget {
  final String playerId;
  const PlayerPlayedMatches(this.playerId, {Key? key}) : super(key: key);

  @override
  State<PlayerPlayedMatches> createState() => _PlayerPlayedMatchesState();
}

class _PlayerPlayedMatchesState extends State<PlayerPlayedMatches> {

  bool loading = false;

  Future<List<PlayerMatchHistory>>? futureData;
  List<PlayerMatchHistory> matchHistoryList = [];

  getPlayerMatchHistoryList(){
    futureData = ProfileProvider().getPlayerMatchHistoryList(widget.playerId).then((value) {
      if(mounted){
        setState(() {
          matchHistoryList = [];
          matchHistoryList.addAll(value);
          loading = false;
        });
      }
      print(matchHistoryList);
      return matchHistoryList;
    });
  }

  setDelay(){
    setState(() {
      loading = true;
    });
    getPlayerMatchHistoryList();
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
      child: matchHistoryList.isEmpty
          ? Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 4.h),
            Image.asset(Images.noMatches, width: 60.w, fit: BoxFit.cover,),
            SizedBox(height: 3.h),
            Text("No played matches",
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
                  itemCount: matchHistoryList.length,
                  itemBuilder: (context, index){
                    return Bounceable(
                      onTap:(){

                      },
                      child: PlayerMatchCard(
                        matchHistoryList[index].teamAName.toString(),
                          matchHistoryList[index].teamBName.toString() == "" ? "TBA" : matchHistoryList[index].teamBName.toString(),
                        matchHistoryList[index].formattedBookingDate.toString(),
                        matchHistoryList[index].bookingSlotStart.toString(),
                        matchHistoryList[index].groundName.toString(),
                        matchHistoryList[index].mainImage.toString(),
                        matchHistoryList[index].matchNumber.toString(),
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
