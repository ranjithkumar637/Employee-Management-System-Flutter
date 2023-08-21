import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/booking_provider.dart';
import '../../providers/team_provider.dart';
import '../../utils/colours.dart';
import '../../utils/styles.dart';
import 'match_information.dart';

class YourMatchInfo extends StatefulWidget {
  const YourMatchInfo({Key? key}) : super(key: key);

  @override
  State<YourMatchInfo> createState() => _YourMatchInfoState();
}

class _YourMatchInfoState extends State<YourMatchInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 2.h),
        Expanded(
          child: Container(
            width: double.maxFinite,
            decoration: const BoxDecoration(
              color: AppColor.lightColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                topLeft: Radius.circular(20.0),
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 2.h),
                Consumer<BookingProvider>(
                    builder: (context, match, child) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.w,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Match Information",
                              style: fontMedium.copyWith(
                                  fontSize: 11.sp,
                                  color: AppColor.textColor
                              ),),
                            SizedBox(height: 2.h),
                            MatchInformation(
                              match.ground.mainImage.toString(),
                              match.ground.city.toString(),
                              match.ground.groundName.toString(),
                              match.teamAData.teamName.toString(),
                              match.teamBData.teamName.toString(),
                            ),
                          ],
                        ),
                      );
                    }
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
