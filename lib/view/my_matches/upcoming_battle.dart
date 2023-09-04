import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:elevens_organizer/utils/app_constants.dart';
import 'package:elevens_organizer/view/my_matches/upcoming_match_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../models/upcoming_match_list_model.dart';
import '../../providers/booking_provider.dart';
import '../../providers/profile_provider.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import '../widgets/loader.dart';
import 'battles_list.dart';
import 'match_info_screen.dart';

class UpcomingBattle extends StatefulWidget {
  const UpcomingBattle({Key? key}) : super(key: key);

  @override
  State<UpcomingBattle> createState() => _UpcomingBattleState();
}

class _UpcomingBattleState extends State<UpcomingBattle> {
  Future<List<UpcomingMatch>>? futureData;
  List<UpcomingMatch> upcomingMatchList = [];
  String firstDate = "";
  String lastDate = "";
  bool loading = false;

  getUpcomingMatchList() {
    futureData =
        ProfileProvider().getOrganizerUpcomingMatchList().then((value) {
      if (mounted) {
        setState(() {
          upcomingMatchList = [];
          upcomingMatchList.addAll(value);
        });
      }
      print(upcomingMatchList);
      return upcomingMatchList;
    });
  }

  setDelay() async {
    if (mounted) {
      setState(() {
        loading = true;
      });
    }
    getUpcomingMatchList();
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          upcomingMatchList.isEmpty
          ? const SizedBox()
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.5.h),
              child: Text(
                "This week upcoming matches",
                style: fontMedium.copyWith(
                    fontSize: 12.sp, color: AppColor.textColor),
              ),
            ),
          Expanded(
              child: loading
                  ? const Loader()
              : upcomingMatchList.isEmpty
                  ? Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 16.h),
                    Image.asset(
                      Images.noMatches,
                      width: 80.w,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      "You don’t have any upcoming matches",
                      style: fontMedium.copyWith(
                          fontSize: 12.sp, color: AppColor.redColor),
                    ),
                  ],
                ),
              )
                  : MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                    separatorBuilder: (context, _) {
                      return SizedBox(height: 2.h);
                    },
                    itemCount: upcomingMatchList.length,
                    itemBuilder: (context, index) {
                      final match = upcomingMatchList[index];
                      return UpcomingMatchCard(match);
                    }),
              ),

            ) // ),
    ]);
  }
}



