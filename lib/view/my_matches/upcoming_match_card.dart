import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/upcoming_match_list_model.dart';
import '../../providers/booking_provider.dart';
import '../../utils/app_constants.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import 'match_info_screen.dart';

class UpcomingMatchCard extends StatelessWidget {
  final UpcomingMatch match;
  const UpcomingMatchCard(this.match, {super.key});

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: (){
        if(match.matchStatus == "Cancelled"){

        } else {
          Provider.of<BookingProvider>(context, listen: false).removeMatchTeamData();
          Provider.of<BookingProvider>(context, listen: false).clearMatchInfo();
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) {
                  return MatchInfoScreen(matchId: match.matchId.toString());
                }),
          );
        }
      },
      child: Container(
        width: double.maxFinite,
        margin: EdgeInsets.symmetric(
            horizontal: 5.w),
        padding: EdgeInsets.symmetric(
            horizontal: 4.w, vertical: 2.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white),
        child: Column(
          children: [
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: "${AppConstants.imageBaseUrl}${AppConstants.imageBaseUrlTeam}${match.teamALogo}",
                    fit: BoxFit.cover,
                    width: 20.w,
                    height: 9.h,
                    errorWidget: (context, url, widget){
                      return ClipOval(
                        child: Image.asset(Images.groundImage, fit: BoxFit.cover, width: 20.w,
                          height: 9.h,),
                      );
                    },
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
                        Text(
                          match.teamAName.toString(),
                          textAlign: TextAlign.center,
                          style: fontMedium.copyWith(
                            fontSize: 11.5.sp,
                            color: AppColor.textColor,
                          ),
                        ),
                        Text(
                          "vs",
                          style: fontMedium.copyWith(
                            fontSize: 11.sp,
                            color: AppColor.redColor,
                          ),
                        ),
                        Text(
                          match.teamBName.toString() == "" ? "TBA" : match.teamBName.toString(),
                          textAlign: TextAlign.center,
                          style: fontMedium.copyWith(
                            fontSize: 11.5.sp,
                            color: AppColor.textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: "${AppConstants.imageBaseUrl}${AppConstants.imageBaseUrlTeam}${match.teamBLogo}",
                    fit: BoxFit.cover,
                    width: 20.w,
                    height: 9.h,
                    errorWidget: (context, url, widget){
                      return ClipOval(
                        child: Image.asset(Images.groundImage, fit: BoxFit.cover, width: 20.w,
                          height: 9.h,),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            DottedLine(
              dashColor: AppColor.hintColour.withOpacity(0.4),
            ),
            SizedBox(
              height: 2.h,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("#${match.matchNumber}",
                          style: fontBold.copyWith(
                              fontSize: 9.5.sp,
                              color: const Color(0xff6495ED)
                          ),),
                        match.matchStatus == "Booked"
                            ? const SizedBox()
                            : SizedBox(height: 1.h),
                        match.matchStatus == "Booked"
                            ? const SizedBox()
                            : Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 2.w,
                            vertical: 0.4.h,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: match.matchStatus == "Cancelled"
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0.6.w,
                                    vertical: 0.3.h),
                                decoration: BoxDecoration(
                                    color: AppColor.iconBgColor,
                                    borderRadius:
                                    BorderRadius.circular(20)),
                                child: Icon(
                                  Icons.access_time,
                                  color: AppColor.iconColour,
                                  size: 3.w,
                                )),
                            SizedBox(
                              width: 2.w,
                            ),
                            Text(
                              match
                                  .bookingSlotStart
                                  .toString(),
                              style: fontMedium.copyWith(
                                fontSize: 9.sp,
                                color: AppColor.textColor,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 1.h),
                        Row(
                          children: [
                            Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0.6.w,
                                    vertical: 0.3.h),
                                decoration: BoxDecoration(
                                    color: AppColor.iconBgColor,
                                    borderRadius:
                                    BorderRadius.circular(20)),
                                child: SvgPicture.asset(
                                  Images.calendarIcon,
                                  color: AppColor.iconColour,
                                  width: 3.w,
                                )),
                            SizedBox(
                              width: 2.w,
                            ),
                            Text(
                              match
                                  .bookingDate
                                  .toString(),
                              style: fontMedium.copyWith(
                                fontSize: 9.sp,
                                color: AppColor.textColor,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),

                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}