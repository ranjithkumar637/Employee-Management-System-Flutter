import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/colours.dart';
import '../../../utils/images.dart';
import '../../../utils/styles.dart';
import '../../utils/app_constants.dart';
import '../widgets/versus_text.dart';

class PlayerMatchCard extends StatelessWidget {
  final String teamA, teamB, date, time, ground, groundImage;
  const PlayerMatchCard(this.teamA, this.teamB, this.date, this.time, this.ground, this.groundImage, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(
        horizontal: 5.w,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 3.w,
        vertical: 1.5.h
      ),
      decoration: BoxDecoration(
          color: AppColor.textFieldBg1,
          borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: CachedNetworkImage(
              imageUrl: "${AppConstants.imageBaseUrl}${AppConstants.imageBaseUrlGallery}$groundImage",
              height: 12.h,
              width: 24.w,
              fit: BoxFit.cover,
              errorWidget:(context, url, error) =>
                  Image.asset(Images.groundImage, fit: BoxFit.cover, height: 12.h,
                    width: 24.w,),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 5.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VersusText(teamA, teamB),
                  SizedBox(height:1.h),
                  ground == ""
                  ? const SizedBox()
                  : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 0.8.w,
                          vertical: 0.4.h,
                        ),
                        decoration: BoxDecoration(
                            color: AppColor.iconBgColor,
                            shape: BoxShape.circle
                        ),
                        child: SvgPicture.asset(Images.groundIcon, color: AppColor.iconColour, width: 3.w,),
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: Text(ground,
                          style: fontMedium.copyWith(
                              fontSize: 9.sp,
                              color: AppColor.textColor
                          ),),
                      ),
                    ],
                  ),
                  ground == ""
                      ? const SizedBox()
                      : SizedBox(height:1.h),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 0.8.w,
                          vertical: 0.4.h,
                        ),
                        decoration: BoxDecoration(
                            color: AppColor.iconBgColor,
                            shape: BoxShape.circle
                        ),
                        child: Icon(Icons.access_time, color: AppColor.iconColour, size: 3.w,),
                      ),
                      SizedBox(width: 2.w),
                      Text(time,
                        style: fontMedium.copyWith(
                            fontSize: 9.sp,
                            color: AppColor.textColor
                        ),),
                    ],
                  ),
                  SizedBox(height:1.h),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 0.8.w,
                          vertical: 0.4.h,
                        ),
                        decoration: BoxDecoration(
                            color: AppColor.iconBgColor,
                            shape: BoxShape.circle
                        ),
                        child: SvgPicture.asset(Images.calendarIcon, color: AppColor.iconColour, width: 3.w,),
                      ),
                      SizedBox(width: 2.w),
                      Text(date,
                        style: fontMedium.copyWith(
                            fontSize: 9.sp,
                            color: AppColor.textColor
                        ),),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
