import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/styles.dart';

class SlotColourInfo extends StatelessWidget {
  const SlotColourInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 4.0,
              backgroundColor: AppColor.availableSlot,
            ),
            SizedBox(width: 2.w),
            Text("Available",
              style: fontRegular.copyWith(
                  fontSize: 9.sp,
                  color: AppColor.textMildColor
              ),),
          ],
        ),
        SizedBox(width: 4.w),
        Row(
          children: [
            const CircleAvatar(
              radius: 4.0,
              backgroundColor: AppColor.selectedSlot,
            ),
            SizedBox(width: 2.w),
            Text("Selected by you",
              style: fontRegular.copyWith(
                  fontSize: 9.sp,
                  color: AppColor.textMildColor
              ),),
          ],
        ),
        SizedBox(width: 4.w),
        Row(
          children: [
            const CircleAvatar(
              radius: 4.0,
              backgroundColor: AppColor.bookedSlot,
            ),
            SizedBox(width: 2.w),
            Text("Booked by others",
              style: fontRegular.copyWith(
                  fontSize: 9.sp,
                  color: AppColor.textMildColor
              ),),
          ],
        ),
      ],
    );
  }
}