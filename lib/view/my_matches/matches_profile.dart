import 'package:elevens_organizer/view/my_matches/player_played_matches.dart';
import 'package:elevens_organizer/view/my_matches/player_upcoming_matches.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/colours.dart';
import '../../../utils/styles.dart';

class ProfileMatches extends StatefulWidget {
  final String playerId;
  const ProfileMatches(this.playerId, {Key? key}) : super(key: key);

  @override
  State<ProfileMatches> createState() => _ProfileMatchesState();
}

class _ProfileMatchesState extends State<ProfileMatches> with SingleTickerProviderStateMixin{

  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        top: 2.h
      ),
      decoration: const BoxDecoration(
        color: AppColor.lightColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0)
        ),
      ),
      child: Column(
        children: [
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
                  text: "Played Matches",
                ),
                Tab(
                  text: "Upcoming Matches",
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
                children: [
                  PlayerPlayedMatches(widget.playerId),
                  PlayerUpcomingMatches(widget.playerId),
                ]),
          ),
        ],
      ),
    );
  }
}
