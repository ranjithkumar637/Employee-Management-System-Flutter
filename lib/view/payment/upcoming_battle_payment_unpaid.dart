import 'package:elevens_organizer/utils/converter.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/upcoming_matches_payment_model.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import 'organizer_battle_list_card.dart';

class UpcomingBattlePaymentUnPaid extends StatelessWidget {
  final List<UpcomingMatches> unpaidUpcomingList;
  final VoidCallback refresh;
  const UpcomingBattlePaymentUnPaid(this.unpaidUpcomingList, this.refresh,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 2.h
      ),
      child: Column(
        children: [
          unpaidUpcomingList.isEmpty
              ? Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 16.h),
                Image.asset(Images.noMatches, width: 80.w, fit: BoxFit.cover,),
                SizedBox(height: 3.h),
                Text("You don’t have any unpaid list",
                  style: fontMedium.copyWith(
                      fontSize: 12.sp,
                      color: AppColor.redColor
                  ),),
              ],
            ),
          )
              : Expanded(
            child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, _){
                  return SizedBox(height: 1.5.h);
                },
                itemCount: unpaidUpcomingList.length,
                itemBuilder: (context, index){
                  print(unpaidUpcomingList[index].paidPrice.toString());
                  return OrganizerBattleListCard(
                    unpaidUpcomingList[index].logo,
                    unpaidUpcomingList[index].paidPrice.toString(),
                    unpaidUpcomingList[index].totalPrice.toString(),
                    unpaidUpcomingList[index].bookingDate.toString(),
                    unpaidUpcomingList[index].bookingSlotStart.toString(),
                    unpaidUpcomingList[index].teamName,
                    unpaidUpcomingList[index].paidStatus.toString(),
                    unpaidUpcomingList[index].matchId.toString(),
                    unpaidUpcomingList[index].teamId.toString(),
                    refresh,
                    unpaidUpcomingList[index].matchNumber.toString()
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
