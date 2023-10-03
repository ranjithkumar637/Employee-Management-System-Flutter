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
import '../my_matches/match_info_screen.dart';
import '../widgets/dot.dart';

class UpcomingCard extends StatelessWidget {
  final UpcomingMatch match;
  final int length;
  const UpcomingCard(this.match, this.length, {super.key});

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: (){
        if(match.matchStatus.toString() == "Cancelled"){

        } else {
          Provider.of<BookingProvider>(context, listen: false).removeMatchTeamData();
          Provider.of<BookingProvider>(context, listen: false).clearMatchInfo();
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) {
                  return MatchInfoScreen(matchId: match.matchId.toString(), matchNumber: match.matchNumber.toString(),);
                }),
          );
        }
      },
      child: Container(
        width: length == 1 ? 90.w : 80.w,
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
                        child: Image.asset(Images.createTeamBg, fit: BoxFit.cover, width: 20.w,
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
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: '${match.teamAName}\n',
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
                            TextSpan(text: match.teamBName == "" ? "TBA" : match.teamBName,
                              style: fontBold.copyWith(
                                color: AppColor.textColor,
                                fontSize: 11.sp,
                              ),)
                          ]
                      ),
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
                        child: Image.asset(Images.createTeamBg, fit: BoxFit.cover, width: 20.w,
                          height: 9.h,),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3.h,
            ),
            DottedLine(
              dashColor: AppColor.hintColour.withOpacity(0.4),
            ),
            const Spacer(),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    match.matchNumber == ""
                        ? const SizedBox()
                        : Text("#${match.matchNumber}",
                      style: fontBold.copyWith(
                          fontSize: 10.sp,
                          color: AppColor.matchNumberColor
                      ),),
                    match.live.toString() == "1" || match.matchStatus == "Cancelled"
                        ? SizedBox(
                        height: 1.h) : const SizedBox(),
                    match.live.toString() == "1" && match.matchStatus != "Cancelled"
                        ? Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 2.w,
                        vertical: 0.4.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.redColor,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Row(
                        children: [
                          const Dot(),
                          SizedBox(width: 1.w),
                          Text("Live",
                            style: fontMedium.copyWith(
                                fontSize: 8.sp,
                                color: AppColor.lightColor
                            ),),
                        ],
                      ),
                    ) : const SizedBox(),
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
