import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/styles.dart';

class YourSlots extends StatelessWidget {
  const YourSlots({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 2.h,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 1.5.h,
      ),
      decoration: BoxDecoration(
        color: AppColor.lightColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Your Slots",
            style: fontMedium.copyWith(
                color: AppColor.textColor,
                fontSize: 12.sp
            ),),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Date",
                style: fontRegular.copyWith(
                    color: AppColor.textMildColor,
                    fontSize: 11.sp
                ),),
              Text("25 Feb, 2023",
                style: fontMedium.copyWith(
                    color: AppColor.textColor,
                    fontSize: 11.sp
                ),),
            ],
          ),
          const Dash(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              SlotRow("Slot 1", "06:00 AM"),
              SlotRow("Overs", "20"),
              SlotRow("Price", "5000"),
            ],
          ),
          const Dash(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              SlotRow("Slot 2", "09:00 AM"),
              SlotRow("Overs", "10"),
              SlotRow("Price", "4000"),
            ],
          ),
          const Dash(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              SlotRow("Slot 3", "01:00 PM"),
              SlotRow("Overs", "15"),
              SlotRow("Price", "6000"),
            ],
          ),
        ],
      ),
    );
  }
}

class Dash extends StatelessWidget {
  const Dash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 1.h,
      ),
      child: const DottedLine(
        dashColor: Color(0xffEFEAEA),
      ),
    );
  }
}


class SlotRow extends StatelessWidget {
  final String heading, value;
  const SlotRow(this.heading, this.value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(heading,
          style: fontRegular.copyWith(
              color: AppColor.textMildColor,
              fontSize: 11.sp
          ),),
        SizedBox(height: 0.5.h),
        Text(value,
          style: fontMedium.copyWith(
              color: AppColor.textColor,
              fontSize: 11.sp
          ),),
      ],
    );
  }
}

