import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../models/match_history_list_model.dart';
import '../../utils/app_constants.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';

class MatchHistoryCard extends StatelessWidget {
  final MatchHistoryList match;
  const MatchHistoryCard(this.match, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Container(
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
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: "${
                          AppConstants.imageBaseUrl
                      }${AppConstants.imageBaseUrlTeam}${match.teamALogo}",
                      errorWidget: (context, url, error) => Image.asset(Images.groundImage, width: 5.w, fit: BoxFit.cover,),
                      width: 20.w,
                      height: 9.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 1.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("${match.teamAName}",
                            textAlign: TextAlign.center,
                            style: fontBold.copyWith(
                              color: AppColor.textColor,
                              fontSize: 11.sp,
                            ),),
                          SizedBox(height: 0.5.h),
                          Text('vs',
                              style:
                              fontMedium.copyWith(
                                color: AppColor
                                    .redColor,
                                fontSize: 11.sp,
                              )),
                          SizedBox(height: 0.5.h),
                          Text(match.teamBName == "" ? "TBA" : "${match.teamBName}",
                            textAlign: TextAlign.center,
                            style: fontBold.copyWith(
                              color: AppColor.textColor,
                              fontSize: 11.sp,
                            ),),
                        ],
                      ),
                    ),
                  ),
                  ClipOval(
                    child: CachedNetworkImage(imageUrl: "${
                        AppConstants.imageBaseUrl
                    }${AppConstants.imageBaseUrlTeam}${match.teamBLogo}",
                      errorWidget: (context, url, error) => Image.asset(Images.groundImage, width: 5.w, fit: BoxFit.cover,),
                      width: 20.w,
                      height: 9.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            DottedLine(
              dashColor: AppColor.hintColour.withOpacity(0.4),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 3.w,
                  vertical: 1.5.h
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("#${match.matchNumber}",
                        style: fontBold.copyWith(
                            fontSize: 9.5.sp,
                            color: const Color(0xff6495ED)
                        ),),
                      SizedBox(height: 1.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 2.w,
                          vertical: 0.4.h,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: match.matchStatus == "Abandoned"
                                ? AppColor.redColor
                                : match.matchStatus == "Closed"
                                ? AppColor.availableSlot
                                : match.matchStatus == "Cancelled"
                                ? AppColor.redColor
                                : null
                        ),
                        child: Text(match.matchStatus,
                          style: fontMedium.copyWith(
                              fontSize: 8.sp,
                              color: AppColor.lightColor
                          ),),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding:
                            EdgeInsets.symmetric(
                              horizontal: 1.w,
                              vertical: 0.5.h,
                            ),
                            decoration: BoxDecoration(
                                color: AppColor
                                    .iconBgColor,
                                shape: BoxShape.circle),
                            child: Icon(
                              Icons.access_time,
                              color: AppColor
                                  .iconColour,
                              size: 3.w,
                            ),
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            match.bookingSlotStart.toString(),
                            style: fontMedium
                                .copyWith(
                                fontSize:
                                9.sp,
                                color: AppColor
                                    .textColor),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding:
                            EdgeInsets.symmetric(
                              horizontal: 1.w,
                              vertical: 0.5.h,
                            ),
                            decoration: BoxDecoration(
                                color: AppColor
                                    .iconBgColor,
                                shape: BoxShape.circle),
                            child: SvgPicture.asset(
                              Images.calendarIcon,
                              color: AppColor
                                  .iconColour,
                              width: 3.w,
                            ),
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            match.bookingDate.toString(),
                            style: fontMedium.copyWith(
                                fontSize: 9.sp,
                                color: AppColor
                                    .textColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
