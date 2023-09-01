import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:sizer/sizer.dart';

import '../../utils/app_constants.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';

class MatchInformation extends StatefulWidget {
  final String image, city, groundName, teamAName, teamBName, date, time;
  const MatchInformation(this.image, this.city, this.groundName, this.teamAName, this.teamBName, this.date, this.time, {Key? key}) : super(key: key);

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
          InfoRow(Images.calendarIcon, "Date", widget.date),
          InfoRow(Images.timeIcon, "Slot", widget.time),
          InfoRow(
              Images.myTeams,
              "Teams",
              "${widget.teamAName} vs ${widget.teamBName.toString() == "null" ? "TBA" : widget.teamBName.toString()}"),
          InfoRow(Images.groundIcon, "Ground", widget.groundName),
          // InfoRow(Icons.location_on_outlined, "Location", widget.location),
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
                    child: Image.network('${AppConstants.imageBaseUrl}${AppConstants.imageBaseUrlGallery}${widget.image}', width: double.infinity, height: 16.h, fit: BoxFit.cover,)),
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
                // InkWell(
                //   onTap: (){
                //     showGroundGalleryImages(ground.galleryImage);
                //   },
                //   child: Positioned(
                //     right: 3.w,
                //     bottom: 1.5.h,
                //     child: Text("5+ Photos",
                //       style: fontRegular.copyWith(
                //           fontSize: 10.sp,
                //           color: AppColor.lightColor
                //       ),),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // void showGroundGalleryImages(List<String> galleryImage) {
  //   showModalBottomSheet<void>(
  //       context: context,
  //       backgroundColor: Colors.transparent,
  //       isScrollControlled: true,
  //       builder: (BuildContext context) {
  //         return GalleryImageView(galleryImage);
  //       });
  // }

}

class InfoRow extends StatelessWidget {
  final String icon;
  final String label, data;
  const InfoRow( this.icon, this.label, this.data, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 1.h)
      ,
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
                        child: SvgPicture.asset(icon, color: AppColor.iconColour, width: 4.w,),
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
