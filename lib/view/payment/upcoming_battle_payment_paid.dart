import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/upcoming_matches_payment_model.dart';
import '../../utils/colours.dart';
import '../../utils/converter.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import 'organizer_battle_list_card.dart';

class UpcomingBattlePaymentPaid extends StatelessWidget {
  final List<UpcomingMatches> paidUpcomingList;
  final VoidCallback refresh;
  const UpcomingBattlePaymentPaid(this.paidUpcomingList, this.refresh, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return paidUpcomingList.isEmpty
        ? Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 4.h),
          Image.asset(Images.noMatches, width: 80.w, fit: BoxFit.cover,),
          SizedBox(height: 3.h),
          Text("You don’t have any paid list",
            style: fontMedium.copyWith(
                fontSize: 12.sp,
                color: AppColor.redColor
            ),),
        ],
      ),
    )
        : ListView.separated(
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (context, _){
        return SizedBox(height: 1.5.h);
      },
      itemCount: paidUpcomingList.length,
      itemBuilder: (context, index){
        return OrganizerBattleListCard(
          paidUpcomingList[index].logo,
          paidUpcomingList[index].paidPrice.toString(),
          paidUpcomingList[index].totalPrice.toString(),
          paidUpcomingList[index].bookingDate.toString(),
          Converter().convertTo12HourFormat(paidUpcomingList[index].bookingSlotStart.toString()),
          paidUpcomingList[index].teamName.toString(),
          paidUpcomingList[index].paidStatus.toString(),
          paidUpcomingList[index].matchId.toString(),
          paidUpcomingList[index].teamId.toString(),
          refresh
        );
      },
    );
  }
}
