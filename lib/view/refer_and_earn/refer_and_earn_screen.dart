import 'package:elevens_organizer/view/refer_and_earn/invite.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/connectivity_status.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import '../widgets/no_internet_view.dart';
import '../widgets/revenue_refer_data_box.dart';
import 'my_referrals.dart';

class ReferAndEarnScreen extends StatefulWidget {
  final String value;
  const ReferAndEarnScreen(this.value, {Key? key}) : super(key: key);

  @override
  State<ReferAndEarnScreen> createState() => _ReferAndEarnScreenState();
}

class _ReferAndEarnScreenState extends State<ReferAndEarnScreen> with SingleTickerProviderStateMixin{

  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    var platform = Theme.of(context).platform;
    bool isIOS = platform == TargetPlatform.iOS;
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    if (connectionStatus == ConnectivityStatus.offline) {
      return const NoInternetView();
    }
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 5.w
            ) + EdgeInsets.only(
                top: isIOS ? statusBarHeight : 2.h + statusBarHeight,
                bottom: 3.h
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap:(){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back, color: AppColor.textColor, size: 7.w,)),
                Text("Refer & Earn",
                  style: fontMedium.copyWith(
                      fontSize: 16.sp,
                      color: AppColor.textColor
                  ),),
                SizedBox(width: 7.w,),
              ],
            ),
          ),
          RevenueReferDataBox(widget.value, 1),
          SizedBox(height: 1.h),
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
                  text: "My Referrals",
                ),
                Tab(
                  text: "Invite",
                ),
              ]),
          Theme(
              data: ThemeData(
                dividerTheme: const DividerThemeData(
                  space: 0, // Set space to 0 to remove top and bottom padding
                  thickness: 0.5, // Set thickness to desired value
                  indent: 0, // Set indent to desired value
                  endIndent: 0, // Set endIndent to desired value
                ),
              ),
              child: const Divider()),
          Expanded(
            child: TabBarView(
                controller: tabController,
                children: const [
                  MyReferrals(),
                  InviteScreen(),
                ]),
          ),
        ],
      ),
    );
  }
}
