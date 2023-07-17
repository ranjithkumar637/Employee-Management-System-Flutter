import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:sizer/sizer.dart';

import '../../models/upcoming_matches_list_model.dart';
import '../../providers/profile_provider.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import 'battles_list.dart';

class UpcomingBattle extends StatefulWidget {
  const UpcomingBattle({Key? key}) : super(key: key);

  @override
  State<UpcomingBattle> createState() => _UpcomingBattleState();
}

class _UpcomingBattleState extends State<UpcomingBattle> {

  Future<List<UpcomingMatch>>? futureData;
  List<UpcomingMatch> upcomingMatchList = [];
  String firstDate = "";
  String lastDate = "";
  bool loading = false;

  getUpcomingMatchList(){
    futureData = ProfileProvider().getOrganizerUpcomingMatchList().then((value) {
      if(mounted){
        setState(() {
          upcomingMatchList = [];
          upcomingMatchList.addAll(value);
        });
      }
      print(upcomingMatchList);
      return upcomingMatchList;
    });
  }

  setDelay() async {
    if(mounted){
      setState(() {
        loading = true;
      });
    }
    getUpcomingMatchList();
    await Future.delayed(const Duration(seconds: 1));
    if(mounted){
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        upcomingMatchList.isEmpty
            ? const SizedBox()
            : Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 5.w, vertical: 2.5.h
          ),
          child: Text("This week upcoming matches",
            style: fontMedium.copyWith(
                fontSize: 12.sp,
                color: AppColor.textColor
            ),),
        ),
        upcomingMatchList.isEmpty
            ? Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 16.h),
              Image.asset(Images.noMatches, width: 80.w, fit: BoxFit.cover,),
              SizedBox(height: 3.h),
              Text("You don’t have any upcoming matches",
                style: fontMedium.copyWith(
                    fontSize: 12.sp,
                    color: AppColor.redColor
                ),),
            ],
          ),
        )
            : Expanded(
          child: FutureBuilder(
              future: futureData,
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } if (snapshot.connectionState ==
                    ConnectionState.done) {
                  return MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (context, _){
                          return SizedBox(height: 1.5.h);
                        },
                        itemCount: upcomingMatchList.length,
                        itemBuilder: (context, index){
                          return Bounceable(
                            onTap: (){

                            },
                            child: BattlesList(
                              upcomingMatchList[index].mainImage.toString(),
                              '${upcomingMatchList[index].teamAName.toString()} vs ${upcomingMatchList[index].teamBName.toString() == "" ? "TBA" : upcomingMatchList[index].teamBName.toString()}',
                              upcomingMatchList[index].bookingDate.toString(),
                              upcomingMatchList[index].bookingSlotStart.toString(),
                              upcomingMatchList[index].groundName.toString(),
                              upcomingMatchList[index].organizerName.toString(),
                            ),
                          );
                        },
                      ));
                } else{
                  return const CircularProgressIndicator();
                }
              }
          ),
        ),
      ],
    );
  }
}
