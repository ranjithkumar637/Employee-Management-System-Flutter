import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/colours.dart';
import '../../../../utils/images.dart';
import '../../../../utils/styles.dart';
import '../../utils/app_constants.dart';

class RevenueListCard extends StatelessWidget {
  final String image, paidPrice, totalPrice, date, time, organizer, status;
  const RevenueListCard(this.image, this.paidPrice, this.totalPrice, this.date, this.time, this.organizer, this.status,
      {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: (){
        // Navigator.pushNamed(context, "payment_info_detail_screen");
      },
      child: Container(
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
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CachedNetworkImage(
                  imageUrl: "${AppConstants.imageBaseUrl}${AppConstants.imageBaseUrlTeam}$image",
                  fit: BoxFit.cover,
                  height: 12.h,
                  width: 24.w,
                  errorWidget: (context, url, widget){
                    return Image.asset(Images.groundImage, fit: BoxFit.cover,
                        height: 12.h,
                        width: 24.w);
                  },
                )
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(organizer,
                    style: fontMedium.copyWith(
                        fontSize: 12.sp,
                        color: AppColor.textColor
                    ),),
                  SizedBox(height: 1.h),
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
                        child: SvgPicture.asset(Images.calendarIcon, color: AppColor.iconColour, width: 3.5.w,),
                      ),
                      SizedBox(width: 3.w),
                      Text(date,
                        style: fontMedium.copyWith(
                            fontSize: 9.sp,
                            color: AppColor.textColor
                        ),),
                    ],
                  ),
                  SizedBox(height: 0.5.h),
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
                        child: Icon(Icons.access_time, color: AppColor.iconColour, size: 3.5.w,),
                      ),
                      SizedBox(width: 3.w),
                      Text(time,
                        style: fontMedium.copyWith(
                            fontSize: 9.sp,
                            color: AppColor.textColor
                        ),),
                    ],
                  ),
                  SizedBox(height: 0.5.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("₹ ",
                        style: fontMedium.copyWith(
                            fontSize: 9.sp,
                            color: AppColor.textMildColor
                        ),),
                      Text("$paidPrice / $totalPrice",
                        style: fontMedium.copyWith(
                            fontSize: 12.sp,
                            color: AppColor.textColor
                        ),),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.w,
                            vertical: 0.4.h
                        ),
                        decoration: BoxDecoration(
                          color: status == "1" ? const Color(0xff57BB8A) : status == "0" ? const Color(0xffE67C73) : null,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Center(
                          child: Text(status == "0" ? "Unpaid" : "Paid",
                            style: fontRegular.copyWith(
                                color: AppColor.lightColor,
                                fontSize: 10.sp
                            ),),
                        ),
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
