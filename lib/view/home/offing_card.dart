import 'package:cached_network_image/cached_network_image.dart';
import 'package:elevens_organizer/models/total_revenue-model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../utils/app_constants.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';

class OffingCard extends StatelessWidget {
  final Offings offing;
  const OffingCard(this.offing, {
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
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: "${
                        AppConstants.imageBaseUrl
                    }${AppConstants.imageBaseUrlTeam}${offing.teamALogo}",
                    errorWidget: (context, url, error) => Image.asset(Images.groundImage, width: 4.w, fit: BoxFit.cover,),
                    width: 17.w,
                    height: 8.5.h,
                    fit: BoxFit.cover,
                  ),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: '${offing.teamAName}\n',
                      style: fontBold.copyWith(
                        color: AppColor.textColor,
                        fontSize: 11.sp,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: 'vs\n',
                            style: fontMedium.copyWith(
                              color: AppColor.redColor,
                              fontSize: 11.sp,
                            )),
                        TextSpan(text: offing.teamBName,
                          style: fontBold.copyWith(
                            color: AppColor.textColor,
                            fontSize: 11.sp,
                          ),)
                      ]
                  ),
                ),
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: "${
                        AppConstants.imageBaseUrl
                    }${AppConstants.imageBaseUrlTeam}${offing.teamBLogo}",
                    errorWidget: (context, url, error) => Image.asset(Images.groundImage, width: 4.w, fit: BoxFit.cover,),
                    width: 17.w,
                    height: 8.5.h,
                    fit: BoxFit.cover,
                  ),
                ),
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
                              child: Text(offing.bookingDate.toString(),
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
                            Text(offing.bookingSlotStart.toString(),
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
                            Text(offing.cityName.toString(),
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
