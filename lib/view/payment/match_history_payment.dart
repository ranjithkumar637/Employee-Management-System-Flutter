import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/styles.dart';
import 'match_history_payment_paid.dart';
import 'match_history_payment_unpaid.dart';

class MatchHistoryPayment extends StatefulWidget {
  const MatchHistoryPayment({Key? key}) : super(key: key);

  @override
  State<MatchHistoryPayment> createState() => _MatchHistoryPaymentState();
}

class _MatchHistoryPaymentState extends State<MatchHistoryPayment> with SingleTickerProviderStateMixin{

  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 1.h),
        Center(
          child: TabBar(
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
                  text: "Paid",
                ),
                Tab(
                  text: "Unpaid",
                ),
              ]),
        ),
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
                MatchHistoryPaymentPaid(),
                MatchHistoryPaymentUnPaid(),
              ]),
        ),
      ],
    );
  }
}