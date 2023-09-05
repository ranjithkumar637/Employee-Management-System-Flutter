import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/strings.dart';
import '../../utils/styles.dart';

class RevenueReferDataBox extends StatelessWidget {
  final String value;
  final int id;
  const RevenueReferDataBox(this.value, this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 18.h,
      margin: EdgeInsets.symmetric(
        horizontal: 5.w,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColor.secondaryColor,
            AppColor.primaryColor,
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 1.5.h
        ),
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            SvgPicture.asset(Images.referImage, width: 90.w,),
            Positioned(
              right: 3.w,
              top: 1.5.h,
              bottom: 1.5.h,
              child: id == 1
                  ? Image.asset(Images.refDialogImage, fit: BoxFit.contain,)
                  : SvgPicture.asset(Images.revenueImage, width: 40.w, fit: BoxFit.contain,)
            ),
            Positioned(
              left: 5.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(id == 1 ? "Total Referral Points" : "Total Revenue",
                    style: fontRegular.copyWith(
                        fontSize: 12.sp,
                        color: AppColor.textColor
                    ),),
                  SizedBox(height: 1.h),
                  Text("${Strings.rupee} $value",
                    style: fontMedium.copyWith(
                        fontSize: 20.sp,
                        color: AppColor.textColor
                    ),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
