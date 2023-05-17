import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/styles.dart';

class CustomButton extends StatelessWidget {
  final Color btnColor, buttonTextColor;
  final String buttonText;
  const CustomButton(this.btnColor, this.buttonText, this.buttonTextColor, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 2.h,
      ),
      decoration: BoxDecoration(
        color: btnColor,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Center(
        child: Text(buttonText,
        style: fontRegular.copyWith(
          color: buttonTextColor,
          fontSize: 13.sp
        ),),
      ),
    );
  }
}
