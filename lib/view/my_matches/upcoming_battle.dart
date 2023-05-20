import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:sizer/sizer.dart';

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

  bool noMatches = false;

  List<Map<String, dynamic>> battles = [
    {
      "image": Images.groundImage,
      "battle_name": "Toss & Tails vs TBA",
      "date": "Aug 21, 2023",
      "time": "07:00 AM",
      'organizer': "JK Organizers",
      "ground_location": "Square out fighters"
    },
    {
      "image": Images.groundImage,
      "battle_name": "Toss & Tails vs Dhoni CC",
      "date": "Aug 21, 2023",
      "time": "07:00 PM",
      'organizer': "JK Organizers",
      "ground_location": "Square out fighters"
    },
    {
      "image": Images.groundImage,
      "battle_name": "Toss & Tails vs TBA",
      "date": "Aug 21, 2023",
      "time": "07:00 AM",
      'organizer': "JK Organizers",
      "ground_location": "Square out fighters"
    },
    {
      "image": Images.groundImage,
      "battle_name": "Toss & Tails vs Dhoni CC",
      "date": "Aug 21, 2023",
      "time": "07:00 PM",
      'organizer': "JK Organizers",
      "ground_location": "Square out fighters"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        noMatches
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
        noMatches
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
          child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, _){
                  return SizedBox(height: 1.5.h);
                },
                itemCount: battles.length,
                itemBuilder: (context, index){
                  return Bounceable(
                    onTap: (){
                      // Navigator.push(
                      //         context,
                      //         MaterialPageRoute(builder: (context) {
                      //           return const UpcomingBattleDetail();
                      //         }),
                      //       );
                          },
                    child: BattlesList(
                      battles[index]["image"],
                      battles[index]["battle_name"],
                      battles[index]["date"],
                      battles[index]["time"],
                      battles[index]["ground_location"],
                        battles[index]["organizer"]
                    ),
                  );
                },
              )),
        ),
      ],
    );
  }
}
