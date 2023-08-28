import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../models/total_revenue-model.dart';
import '../../utils/app_constants.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';

class OffingsList extends StatelessWidget {
  final String image, date, time, location, teamAName, teamBName;
  final Offings offing;
  const OffingsList(this.image, this.date, this.time, this.location, this.teamAName, this.teamBName, this.offing,  {Key? key}) : super(key: key);

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
              child: CachedNetworkImage(
                imageUrl: '${AppConstants.imageBaseUrl}${AppConstants.imageBaseUrlGallery}${image}',
                fit: BoxFit.cover,
                width: 28.w,
                height: 14.h,
                errorWidget:(context, url, error) =>
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(Images.groundImage, fit: BoxFit.cover, width: 20.w,
                          height: 10.h,)),
              )),
          SizedBox(width: 4.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                      text: teamAName,
                      style: fontMedium.copyWith(
                          fontSize: 12.5.sp,
                          color: AppColor.textColor
                      ),
                      children: <TextSpan>[
                        TextSpan(text: ' vs ',
                          style: fontMedium.copyWith(
                              fontSize: 12.5.sp,
                              color: AppColor.redColor
                          ),
                        ),
                        TextSpan(text: teamBName == "" ? "TBA" : teamBName,
                          style: fontMedium.copyWith(
                              fontSize: 12.5.sp,
                              color: AppColor.textColor
                          ),
                        ),
                      ]
                  ),
                ),
                SizedBox(height: 1.h),
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
                // SizedBox(height: 0.6.h),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Container(
                //       padding: EdgeInsets.symmetric(
                //         horizontal: 1.w,
                //         vertical: 0.5.h,
                //       ),
                //       decoration: BoxDecoration(
                //           color: AppColor.iconBgColor,
                //           shape: BoxShape.circle
                //       ),
                //       child: SvgPicture.asset(Images.groundIcon, color: AppColor.iconColour, width: 3.w,),
                //     ),
                //     SizedBox(width: 3.w),
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(groundName,
                //           style: fontMedium.copyWith(
                //               fontSize: 9.5.sp,
                //               color: AppColor.textColor
                //           ),),
                //         SizedBox(height: 0.5.h),
                //         Text(location,
                //           style: fontRegular.copyWith(
                //               fontSize: 9.sp,
                //               color: AppColor.textMildColor
                //           ),),
                //       ],
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
