import 'package:elevens_organizer/view/payment/upcoming_battle_payment_paid.dart';
import 'package:elevens_organizer/view/payment/upcoming_battle_payment_unpaid.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/upcoming_matches_payment_model.dart';
import '../../providers/payment_info_provider.dart';
import '../../utils/colours.dart';
import '../../utils/styles.dart';
import '../widgets/loader.dart';

class UpcomingBattlePayment extends StatefulWidget {
  const UpcomingBattlePayment({Key? key}) : super(key: key);

  @override
  State<UpcomingBattlePayment> createState() => _UpcomingBattlePaymentState();
}

class _UpcomingBattlePaymentState extends State<UpcomingBattlePayment> with SingleTickerProviderStateMixin{

  late TabController tabController;

  Future<List<UpcomingMatches>>? futureData ;
  bool loading = false;


  List<UpcomingMatches> upcomingMatchespayments = [];

  List<UpcomingMatches> paidUpcomingList = [];
  List<UpcomingMatches> unpaidUpcomingList = [];

  getUpcomingMatchesList(){
    futureData = PaymentInfoProvider().getUpcomingMatchesPayment().then((value) {
      setState(() {
        upcomingMatchespayments = [];
        upcomingMatchespayments.addAll(value);
      });
      filterList();
      print(upcomingMatchespayments);
      return upcomingMatchespayments;
    });
  }

  filterList(){
    setState(() {
      paidUpcomingList = upcomingMatchespayments.where((match) => match.paidStatus.toString() == "1").toList();
      unpaidUpcomingList = upcomingMatchespayments.where((match) => match.paidStatus.toString() == "0").toList();
    });
    print("paid list $paidUpcomingList");
    print("unpaid list $unpaidUpcomingList");
  }

  setDelay() async {
    setState(() {
      loading = true;
    });
    getUpcomingMatchesList();
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    setDelay();
  }

  @override
  Widget build(BuildContext context) {
    return loading
    ? const Loader()
    : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 5.w,
          ) + EdgeInsets.only(
            top: 2.5.h,
            bottom: 2.h
          ),
          child: Text("This week upcoming matches",
            style: fontMedium.copyWith(
                fontSize: 12.sp,
                color: AppColor.textColor
            ),),
        ),
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
              children: [
                UpcomingBattlePaymentPaid(paidUpcomingList, setDelay),
                UpcomingBattlePaymentUnPaid(unpaidUpcomingList, setDelay),
              ]),
        ),
      ],
    );
  }
}
