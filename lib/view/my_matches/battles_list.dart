import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../utils/app_constants.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';

class BattlesList extends StatelessWidget {
  final String image, battleName, date, time, location, organizer;
  const BattlesList(this.image, this.battleName, this.date, this.time, this.location, this.organizer, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 5.w,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 3.w,
        vertical: 1.5.h,
      ),
      decoration: BoxDecoration(
        color: AppColor.lightColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: CachedNetworkImage(imageUrl: '${AppConstants.imageBaseUrl}/$image', fit: BoxFit.cover, width: 28.w, height: 14.h,
                errorWidget: (context, url, error) => Icon(Icons.gps_not_fixed_rounded, size: 4.w,),)),
          SizedBox(width: 4.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(battleName,
                  style: fontMedium.copyWith(
                      fontSize: 12.5.sp,
                      color: AppColor.textColor
                  ),),
                SizedBox(height: 0.6.h),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 1.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                          color: AppColor.iconBgColor,
                          shape: BoxShape.circle
                      ),
                      child: SvgPicture.asset(Images.calendarIcon, color: AppColor.iconColour, width: 3.w,),
                    ),
                    SizedBox(width: 3.w),
                    Text(date,
                      style: fontMedium.copyWith(
                          fontSize: 9.5.sp,
                          color: AppColor.textColor
                      ),),
                  ],
                ),
                SizedBox(height: 0.6.h),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 1.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                          color: AppColor.iconBgColor,
                          shape: BoxShape.circle
                      ),
                      child: Icon(Icons.access_time, color: AppColor.iconColour, size: 3.w,),
                    ),
                    SizedBox(width: 3.w),
                    Text(time,
                      style: fontMedium.copyWith(
                          fontSize: 9.5.sp,
                          color: AppColor.textColor
                      ),),
                  ],
                ),
                SizedBox(height: 0.6.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 1.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                          color: AppColor.iconBgColor,
                          shape: BoxShape.circle
                      ),
                      child: SvgPicture.asset(Images.groundIcon, color: AppColor.iconColour, width: 3.w,),
                    ),
                    SizedBox(width: 3.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(organizer,
                          style: fontMedium.copyWith(
                              fontSize: 9.5.sp,
                              color: AppColor.textColor
                          ),),
                        SizedBox(height: 0.5.h),
                        Text(location,
                          style: fontRegular.copyWith(
                              fontSize: 9.sp,
                              color: AppColor.textMildColor
                          ),),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
