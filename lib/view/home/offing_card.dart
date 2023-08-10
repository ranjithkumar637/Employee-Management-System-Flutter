import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';

class OffingCard extends StatelessWidget {
  const OffingCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85.w,
      height: 25.h,
      decoration: BoxDecoration(
        color: AppColor.lightColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 3.w,
              vertical: 1.4.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(Images.team1, height: 8.5.h, width: 17.w,),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: 'Toss and Tails\n',
                      style: fontBold.copyWith(
                        color: AppColor.textColor,
                        fontSize: 11.sp,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: 'VS\n',
                            style: fontMedium.copyWith(
                              color: AppColor.textColor,
                              fontSize: 11.sp,
                            )),
                        TextSpan(text: 'Dhoni CC',
                          style: fontBold.copyWith(
                            color: AppColor.textColor,
                            fontSize: 11.sp,
                          ),)
                      ]
                  ),
                ),
                Image.asset(Images.team2, height: 8.5.h, width: 17.w,),
              ],
            ),
          ),
          const Divider(
            height: 0.5,
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 3.w,
            ) + EdgeInsets.only(
                top: 1.2.h, bottom: 2.h
            ),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 1.w,
                          vertical: 0.5.h,
                        ),
                        decoration: BoxDecoration(
                            color: AppColor.secondaryColor.withOpacity(0.2),
                            shape: BoxShape.circle
                        ),
                        child: SvgPicture.asset(Images.calendarIcon, color: AppColor.secondaryColor, width: 3.5.w,),
                      ),
                      SizedBox(width: 1.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Date",
                              style: fontMedium.copyWith(
                                  fontSize: 8.sp,
                                  color: AppColor.textMildColor
                              ),),
                            FittedBox(
                              child: Text("Aug 21, 2023",
                                style: fontMedium.copyWith(
                                    fontSize: 9.sp,
                                    color: AppColor.textColor
                                ),),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 1.w),
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 1.w,
                          vertical: 0.5.h,
                        ),
                        decoration: BoxDecoration(
                            color: AppColor.secondaryColor.withOpacity(0.2),
                            shape: BoxShape.circle
                        ),
                        child: Icon(Icons.access_time, color: AppColor.secondaryColor, size: 3.5.w,),
                      ),
                      SizedBox(width: 1.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Time",
                              style: fontMedium.copyWith(
                                  fontSize: 8.sp,
                                  color: AppColor.textMildColor
                              ),),
                            Text("06:00 AM",
                              style: fontMedium.copyWith(
                                  fontSize: 9.sp,
                                  color: AppColor.textColor
                              ),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 1.w),
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 1.w,
                          vertical: 0.5.h,
                        ),
                        decoration: BoxDecoration(
                            color: AppColor.secondaryColor.withOpacity(0.2),
                            shape: BoxShape.circle
                        ),
                        child: SvgPicture.asset(Images.location, color: AppColor.secondaryColor, width: 3.5.w,),
                      ),
                      SizedBox(width: 1.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Location",
                              style: fontMedium.copyWith(
                                  fontSize: 8.sp,
                                  color: AppColor.textMildColor
                              ),),
                            Text("Chrompet",
                              style: fontMedium.copyWith(
                                  fontSize: 9.sp,
                                  color: AppColor.textColor
                              ),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
