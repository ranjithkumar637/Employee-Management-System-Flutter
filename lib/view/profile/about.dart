import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 2.h,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 1.5.h,
      ),
      decoration: BoxDecoration(
        color: AppColor.lightColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("About",
                style: fontMedium.copyWith(
                    color: AppColor.textColor,
                    fontSize: 12.sp
                ),),
              SvgPicture.asset(Images.editIcon, color: AppColor.iconColour, width: 4.w,),
            ],
          ),
          SizedBox(height: 2.h),
          Text("Description",
            style: fontRegular.copyWith(
                color: AppColor.textColor,
                fontSize: 11.sp
            ),),
          SizedBox(height: 1.h),
          Text("Lorem ipsum dolor sit amet consectetur. Quisque suscipit facilisi in fusce et. Ornare augue neque lorem iaculis nullam tempus sit dignissim cum. ",
            style: fontRegular.copyWith(
                color: AppColor.textColor,
                fontSize: 11.sp
            ),),
          const Dash(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Photos",
                style: fontMedium.copyWith(
                    color: AppColor.textColor,
                    fontSize: 12.sp
                ),),
              SvgPicture.asset(Images.editIcon, color: AppColor.iconColour, width: 4.w,),
            ],
          ),
          SizedBox(height: 2.h),
          Wrap(
            spacing: 2.h,
            runSpacing: 2.h,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image.asset(Images.groundImage, width: 20.w, height: 10.h, fit: BoxFit.cover,)),
              ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image.asset(Images.groundImage, width: 20.w, height: 10.h, fit: BoxFit.cover,)),
              ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image.asset(Images.groundImage, width: 20.w, height: 10.h, fit: BoxFit.cover,)),
              ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image.asset(Images.groundImage, width: 20.w, height: 10.h, fit: BoxFit.cover,)),
            ],
          ),
        ],
      ),
    );
  }
}

class Dash extends StatelessWidget {
  const Dash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 2.5.h,
      ),
      child: const DottedLine(
        dashColor: Color(0xffEFEAEA),
      ),
    );
  }
}
