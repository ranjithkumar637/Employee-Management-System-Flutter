import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/styles.dart';

class VersusText extends StatelessWidget {
  final String teamAName, teamBName;
  const VersusText(this.teamAName, this.teamBName, {super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: teamAName,
          style: fontMedium.copyWith(
            color: AppColor.textColor,
            fontSize: 12.sp,
          ),
          children: <TextSpan>[
            TextSpan(text: " vs ",
              style: fontMedium.copyWith(
                color: AppColor.redColor,
                fontSize: 12.sp,
              ),
            ),
            TextSpan(text: teamBName,
              style: fontMedium.copyWith(
                color: AppColor.textColor,
                fontSize: 12.sp,
              ),
            ),
          ]
      ),
    );
  }
}
