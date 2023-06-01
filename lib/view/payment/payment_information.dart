import 'package:elevens_organizer/view/payment/upcoming_battle_payment.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/styles.dart';
import 'match_history_payment.dart';

class PaymentInformation extends StatefulWidget {
  const PaymentInformation({Key? key}) : super(key: key);

  @override
  State<PaymentInformation> createState() => _PaymentInformationState();
}

class _PaymentInformationState extends State<PaymentInformation> with SingleTickerProviderStateMixin{

  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 5.w
            ) + EdgeInsets.only(
                top: 5.h, bottom: 2.h
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap:(){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back, color: AppColor.textColor, size: 7.w,)),
                Text("Payment Information",
                  style: fontMedium.copyWith(
                      fontSize: 16.sp,
                      color: AppColor.textColor
                  ),),
                SizedBox(width: 7.w,),
              ],
            ),
          ),
          TabBar(
              isScrollable: true,
              indicatorColor: AppColor.secondaryColor,
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: fontMedium.copyWith(
                  fontSize: 12.sp
              ),
              unselectedLabelColor: AppColor.unselectedTabColor,
              labelColor: AppColor.secondaryColor,
              controller: tabController,
              tabs: const [
                Tab(
                  text: "Upcoming Battle",
                ),
                Tab(
                  text: "Match History",
                ),
              ]),
          Theme(
              data: ThemeData(
                dividerTheme: const DividerThemeData(
                  space: 0,
                  thickness: 0.5,
                  indent: 0,
                  endIndent: 0,
                ),
              ),
              child: const Divider()),
          Expanded(
            child: TabBarView(
                controller: tabController,
                children: const [
                  UpcomingBattlePayment(),
                  MatchHistoryPayment(),
                ]),
          ),
        ],
      ),
    );
  }
}
