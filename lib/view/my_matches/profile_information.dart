
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/colours.dart';
import '../../models/player_info_model.dart';
import '../../utils/styles.dart';

class ProfileInformation extends StatefulWidget {
  final PlayerInfo playerInfo;
  const ProfileInformation(this.playerInfo, {Key? key}) : super(key: key);

  @override
  State<ProfileInformation> createState() => _ProfileInformationState();
}

class _ProfileInformationState extends State<ProfileInformation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: EdgeInsets.only(
        top: 2.h,
      ),
      decoration: const BoxDecoration(
        color: AppColor.lightColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0)
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: 2.h,
                left: 5.w
            ),
            child: Text("Personal Information",
              style: fontMedium.copyWith(
                  fontSize: 13.sp,
                  color: AppColor.textColor
              ),),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: 1.h
            ),
            child: const Divider(thickness: 0.7,),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 5.w,
            ),
            padding: EdgeInsets.symmetric(
              vertical: 1.h,
            ),
            decoration: BoxDecoration(
              color: AppColor.textFieldBg1,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              children: [
                personalInfoRow("Name", widget.playerInfo.name.toString()),
                const Divider(),
                if(widget.playerInfo.battingRole.toString() == "0" && widget.playerInfo.bowlingRole.toString() == "0" && widget.playerInfo.wicketKeeper.toString() == "0" && widget.playerInfo.allRounder.toString() == "0")...[
                  const SizedBox(),
                ] else...[
                  if(widget.playerInfo.battingRole.toString() == "1")...[
                    personalInfoRow("Role", "Batting"),
                  ] else if(widget.playerInfo.bowlingRole.toString() == "1")...[
                    personalInfoRow("Role", "Bowling"),
                  ] else if(widget.playerInfo.wicketKeeper.toString() == "1")...[
                    personalInfoRow("Role", "Wicket Keeper"),
                  ] else if(widget.playerInfo.allRounder.toString() == "1")...[
                    personalInfoRow("Role", "All rounder"),
                  ],
                  const Divider(),
                ],
                if(widget.playerInfo.battingRole.toString() == "1")...[
                  personalInfoRow("Batting Style", widget.playerInfo.battingStyle.toString()),
                  const Divider(),
                  personalInfoRow("Batting Order", widget.playerInfo.battingOrder.toString()),
                  const Divider(),
                  personalInfoRow("Bowling Style", widget.playerInfo.bowlingStyle.toString()),
                  const Divider(),
                  personalInfoRow("Bowling Action", widget.playerInfo.bowlingAction.toString()),
                  const Divider(),
                  personalInfoRow("Bowling Proficiency", widget.playerInfo.bowlingProficiency.toString()),
                ] else if(widget.playerInfo.bowlingRole.toString() == "1")...[
                  personalInfoRow("Batting Style", widget.playerInfo.battingStyle.toString()),
                  const Divider(),
                  personalInfoRow("Batting Order", widget.playerInfo.battingOrder.toString()),
                  const Divider(),
                  personalInfoRow("Bowling Style", widget.playerInfo.bowlingStyle.toString()),
                  const Divider(),
                  personalInfoRow("Bowling Action", widget.playerInfo.bowlingAction.toString()),
                  const Divider(),
                  personalInfoRow("Bowling Proficiency", widget.playerInfo.bowlingProficiency.toString()),
                ] else if(widget.playerInfo.wicketKeeper.toString() == "1")...[
                  personalInfoRow("Batting Style", widget.playerInfo.battingStyle.toString()),
                  const Divider(),
                  personalInfoRow("Batting Order", widget.playerInfo.battingOrder.toString()),
                ] else if(widget.playerInfo.allRounder.toString() == "1")...[
                  personalInfoRow("Batting Style", widget.playerInfo.battingStyle.toString()),
                  const Divider(),
                  personalInfoRow("Batting Order", widget.playerInfo.battingOrder.toString()),
                  const Divider(),
                  personalInfoRow("Bowling Style", widget.playerInfo.bowlingStyle.toString()),
                  const Divider(),
                  personalInfoRow("Bowling Action", widget.playerInfo.bowlingAction.toString()),
                  const Divider(),
                  personalInfoRow("Bowling Proficiency", widget.playerInfo.bowlingProficiency.toString()),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

personalInfoRow(String title, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: 4.w,
      vertical: 1.h
    ),
    child: Row(
      children: [
        Expanded(
          child: Text(title,
            style: fontMedium.copyWith(
                fontSize: 11.sp,
                color: AppColor.textColor
            ),),
        ),
        Expanded(
          child: Text(value,
            style: fontMedium.copyWith(
                fontSize: 11.sp,
                color: AppColor.textMildColor
            ),),
        ),
      ],
    ),
  );
}
