import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/images.dart';
import 'organizer_battle_list_card.dart';

class UpcomingBattlePaymentPaid extends StatelessWidget {
  const UpcomingBattlePaymentPaid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<Map<String, dynamic>> organizerBattlePaidList = [
      {
        "image": Images.groundListImage1,
        "paid_price": "5000",
        "total_price": "5000",
        "date": "Aug 21, 2023",
        "time": "07:00 AM",
        'team': "Toss & Tails",
        "status": "Paid"
      },
      {
        "image": Images.groundListImage2,
        "paid_price": "5000",
        "total_price": "5000",
        "date": "Aug 21, 2023",
        "time": "07:00 PM",
        'team': "Dhoni CC",
        "status": "Paid"
      },
      {
        "image": Images.groundListImage3,
        "paid_price": "5000",
        "total_price": "5000",
        "date": "Aug 21, 2023",
        "time": "07:00 AM",
        'team': "Toss & Tails",
        "status": "Paid"
      },
      {
        "image": Images.groundListImage4,
        "paid_price": "5000",
        "total_price": "5000",
        "date": "Aug 21, 2023",
        "time": "07:00 PM",
        'team': "Dhoni CC",
        "status": "Paid"
      }
    ];


    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (context, _){
        return SizedBox(height: 1.5.h);
      },
      itemCount: organizerBattlePaidList.length,
      itemBuilder: (context, index){
        return OrganizerBattleListCard(
          organizerBattlePaidList[index]["image"],
          organizerBattlePaidList[index]["paid_price"],
          organizerBattlePaidList[index]["total_price"],
          organizerBattlePaidList[index]["date"],
          organizerBattlePaidList[index]["time"],
          organizerBattlePaidList[index]["team"],
          organizerBattlePaidList[index]["status"],
        );
      },
    );
  }
}
