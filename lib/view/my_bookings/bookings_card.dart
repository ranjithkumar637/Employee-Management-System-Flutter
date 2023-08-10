import 'package:cached_network_image/cached_network_image.dart';
import 'package:elevens_organizer/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';

class BookingsCard extends StatelessWidget {
  final String time, date, location, teamImage, team, teamId, matchId;
  const BookingsCard(this.time, this.date, this.location,this.teamImage, this.team, this.teamId, this.matchId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: (){
        // Navigator.pushNamed(context, 'play_vs_opponent_team', arguments: PlayVSBookingData(matchId, date, time, ground, team));
      },
      child: Container(
        width: double.maxFinite,
        margin: EdgeInsets.symmetric(
          horizontal: 5.w,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 2.w,
          vertical: 1.h
        ),
        decoration: BoxDecoration(
            color: AppColor.lightColor,
            borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: CachedNetworkImage(
                imageUrl: "${AppConstants.imageBaseUrl}${AppConstants.imageBaseUrlTeam}$teamImage",
                height: 14.h,
                width: 28.w,
                fit: BoxFit.cover,
                errorWidget: (context, error, url) =>
                    Image.asset(Images.groundListImage1, width: 90.w,
                      fit: BoxFit.cover,
                      height: 12.h,),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 5.w,
                    vertical: 1.4.h
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(team,
                      style: fontMedium.copyWith(
                          fontSize: 12.sp,
                          color: AppColor.textColor
                      ),),
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
                          child: SvgPicture.asset(Images.location, color: AppColor.iconColour, width: 3.w,),
                        ),
                        SizedBox(width: 2.w),
                        Text(location,
                          style: fontMedium.copyWith(
                              fontSize: 9.sp,
                              color: AppColor.textColor
                          ),),
                      ],
                    ),
                    SizedBox(height:0.5.h),
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
                    SizedBox(height:0.5.h),
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
      ),
    );
  }
}
