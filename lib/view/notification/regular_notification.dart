import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';

class RegularNotification extends StatefulWidget {
  final String title, body;
  final bool old;
  const RegularNotification(this.title, this.body, this.old, {Key? key}) : super(key: key);

  @override
  State<RegularNotification> createState() => _RegularNotificationState();
}

class _RegularNotificationState extends State<RegularNotification> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 3.w,
        vertical: 1.5.h
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 5.w,
      ),
      decoration: BoxDecoration(
        color: widget.old ? AppColor.oldNotificationBgColor : AppColor.lightColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 6.h,
            width: 12.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(Images.groundImage))
            ),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title,
                  style: fontMedium.copyWith(
                      fontSize: 11.sp,
                      color: AppColor.redColor
                  ),),
                SizedBox(height: 0.5.h),
                Text(widget.body,
                  style: fontRegular.copyWith(
                      fontSize: 11.sp,
                      color: AppColor.textColor
                  ),),
              ],
            ),
          ),
          widget.old ? const SizedBox() : const CircleAvatar(
            radius: 4,
            backgroundColor: AppColor.primaryColor,
          ),
        ],
      ),
    );
  }
}
