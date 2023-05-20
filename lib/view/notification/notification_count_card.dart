import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/styles.dart';

class NotificationCountCard extends StatelessWidget {
  const NotificationCountCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 3.w,
        vertical: 1.h,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 5.w,
      ),
      decoration: BoxDecoration(
        color: AppColor.lightColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Text.rich(
        TextSpan(
          text: 'You have ',
          style: fontRegular.copyWith(fontSize: 11.sp,
              color: AppColor.textMildColor),
          children: [
            TextSpan(
              text: '1 Notification',
              style: fontRegular.copyWith(color: AppColor.redColor, fontSize: 11.sp,
              ),
            ),
            TextSpan(
              text: ' today.',
              style: fontRegular.copyWith(color: AppColor.textMildColor, fontSize: 11.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}