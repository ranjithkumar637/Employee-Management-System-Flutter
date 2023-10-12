import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/styles.dart';

class EmptyListCard extends StatelessWidget {
  final String title, errorText;
  const EmptyListCard(this.title, this.errorText, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: fontMedium.copyWith(
                fontSize: 12.sp, color: AppColor.textColor),
          ),
          SizedBox(height: 2.h),
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
                vertical: 2.h,
                horizontal: 4.w
            ),
            decoration: BoxDecoration(
              color: AppColor.redColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Text(errorText,
              style: fontMedium.copyWith(
                  color: AppColor.redColor,
                  fontSize: 11.sp
              ),),
          ),
        ],
      ),
    );
  }
}
