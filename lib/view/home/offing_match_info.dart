import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/profile_provider.dart';
import '../../providers/team_provider.dart';
import '../../utils/app_constants.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';

class OffingMatchInfo extends StatefulWidget {
  const OffingMatchInfo({Key? key}) : super(key: key);

  @override
  State<OffingMatchInfo> createState() => _OffingMatchInfoState();
}

class _OffingMatchInfoState extends State<OffingMatchInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 3.h,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 2.5.h,
      ),
      decoration: const BoxDecoration(
          color: AppColor.lightColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0)
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Match Information",
            style: fontMedium.copyWith(
                fontSize: 13.sp,
                color: AppColor.textColor
            ),),
          SizedBox(height: 2.h),
          Expanded(
            child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Consumer<ProfileProvider>(
                      builder: (context, match, child) {
                        return MatchInformation(
                            match.matchDetails.bookingDate.toString(),
                            match.matchDetails.bookingSlotStart.toString(),
                            match.matchDetails.teamAName.toString(),
                            match.matchDetails.groundName.toString(),
                            match.matchDetails.cityName.toString(),
                            match.matchDetails.teamBName.toString(),
                            false,
                            match.matchDetails.mainImage.toString(),
                            match.matchDetails.organizerName.toString(),
                            match.matchDetails.latitude.toString(),
                            match.matchDetails.longitude.toString());
                      }
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

class MatchInformation extends StatefulWidget {
  final String date, slot, team, ground, location, opponent, groundImage, organizer, latitude, longitude;
  final bool confirmed;
  const MatchInformation(this.date, this.slot, this.team, this.ground, this.location, this.opponent, this.confirmed, this.groundImage, this.organizer, this.latitude, this.longitude, {Key? key}) : super(key: key);

  @override
  State<MatchInformation> createState() => _MatchInformationState();
}

class _MatchInformationState extends State<MatchInformation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.textFieldBg1,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          InfoRow(Icons.date_range_outlined, "Date", widget.date),
          InfoRow(Icons.access_time, "Slot", widget.slot),
          InfoRow(
              Icons.people_alt_outlined,
              widget.opponent == '' ? "Team" : "Teams",
              widget.opponent == ''
                  ? widget.team
                  : "${widget.team} vs ${widget.opponent}"),
          // widget.opponent == "" ? const SizedBox() : InfoRow(Icons.people_alt_outlined, "Opponent Team", widget.opponent),
          InfoRow(Icons.gps_not_fixed_rounded, "Organizer &\nGround", '${widget.organizer}\n${widget.ground}'),
          InfoRow(Icons.location_on_outlined, "Location", widget.location),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 4.w,
              vertical: 2.h,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network('${AppConstants.imageBaseUrl}${AppConstants.imageBaseUrlGallery}${widget.groundImage}', width: double.infinity, height: 16.h, fit: BoxFit.cover,)),
                Container(
                  width: double.infinity, height: 16.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    gradient: const LinearGradient(
                      begin: Alignment.bottomRight,
                      end: Alignment.topCenter,
                      colors: [
                        Color(0xff000000),
                        Color(0x4C000000),
                      ],
                    ),
                  ),
                ),
                widget.confirmed
                    ? Positioned(
                  child: Center(
                    child: Bounceable(
                      onTap: (){
                        openMaps(widget.latitude.toString(), widget.longitude.toString());
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 3.w,
                          vertical: 1.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.lightColor,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(Images.mapIcon, color: AppColor.primaryColor, width: 5.w,),
                            SizedBox(width: 2.w),
                            Text("Get Directions",
                              style: fontMedium.copyWith(
                                  fontSize: 11.sp,
                                  color: AppColor.textColor
                              ),),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                    : Positioned(
                  right: 3.w,
                  top: 1.5.h,
                  child: Bounceable(
                    onTap: (){
                      openMaps(widget.latitude.toString(), widget.longitude.toString());
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                        vertical: 1.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.lightColor,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(Images.mapIcon, color: AppColor.primaryColor, width: 5.w,),
                          SizedBox(width: 2.w),
                          Text("Map",
                            style: fontMedium.copyWith(
                                fontSize: 11.sp,
                                color: AppColor.textColor
                            ),),
                        ],
                      ),
                    ),
                  ),
                ),
                widget.confirmed ? const SizedBox() : Positioned(
                  right: 3.w,
                  bottom: 1.5.h,
                  child: Text("5+ Photos",
                    style: fontRegular.copyWith(
                        fontSize: 10.sp,
                        color: AppColor.lightColor
                    ),),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  openMaps(String latitude, String longitude) async {
    MapsLauncher.launchCoordinates(double.parse(latitude), double.parse(longitude));
  }

}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label, data;
  const InfoRow( this.icon, this.label, this.data, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 1.h),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
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
                            color: AppColor.iconBgColor,
                            shape: BoxShape.circle
                        ),
                        child: Icon(icon, color: AppColor.iconColour, size: 4.w,),
                      ),
                      SizedBox(width: 3.w),
                      Text(label,
                        style: fontRegular.copyWith(
                            fontSize: 10.5.sp,
                            color: AppColor.textMildColor
                        ),),
                    ],
                  ),
                ),
                SizedBox(width: 7.w),
                Expanded(
                  child: Text(data,
                    textAlign: TextAlign.start,
                    style: fontMedium.copyWith(
                        fontSize: 11.sp,
                        color: AppColor.textColor
                    ),),
                ),
              ],
            ),
          ),
          SizedBox(height: 1.h),
          const DottedLine(dashColor: Color(0xffD6D6D6), lineThickness: 0.5,),
        ],
      ),
    );
  }
}
