import 'package:flutter/material.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/styles.dart';

class TeamCode extends StatelessWidget {
  final String code;
  final bool fromHome;
  const TeamCode(this.code, this.fromHome, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 1.h,
      ),
      decoration: BoxDecoration(
          color: const Color(0xffFAEDD0),
          borderRadius: BorderRadius.circular(fromHome ? 5.0 : 0.0),
          border: RDottedLineBorder.all(color: AppColor.primaryColor)
      ),
      child: Text(code,
        textAlign: TextAlign.center,
        style: fontMedium.copyWith(
            fontSize: fromHome ? 11.sp : 16.sp,
            color: AppColor.secondaryColor
        ),),
    );
  }
}
