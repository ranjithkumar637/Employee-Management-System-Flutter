import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/styles.dart';

class ResetButton extends StatelessWidget {
  const ResetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 7.w,
        vertical: 1.h,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: AppColor.textColor)
      ),
      child: Center(
        child: Text("Reset",
          style: fontMedium.copyWith(
              color: AppColor.textColor,
              fontSize: 12.sp
          ),),
      ),
    );
  }
}