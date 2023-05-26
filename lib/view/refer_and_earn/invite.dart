import 'package:elevens_organizer/view/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';

class InviteScreen extends StatelessWidget {
  const InviteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: 5.w,
            vertical: 2.h,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
            vertical: 2.h,
          ),
          decoration: BoxDecoration(
            color: AppColor.lightColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              Text("Refer friends and earn points while they signup",
                style: fontMedium.copyWith(
                    fontSize: 12.sp,
                    color: AppColor.textColor
                ),),
              SizedBox(height: 2.h),
              const Steps(Images.inviteImage1, "1", "Share your code to your friends"),
              SizedBox(height: 2.h),
              const Steps(Images.inviteImage2, "2", "Your friends successfully signup"),
              SizedBox(height: 2.h),
              const Steps(Images.inviteImage3, "3", "Earn points easily"),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 5.h
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 1.h,
                  ),
                  decoration: BoxDecoration(
                      color: const Color(0xffFAEDD0),
                      borderRadius: BorderRadius.circular(5.0),
                      border: RDottedLineBorder.all(color: AppColor.primaryColor)
                  ),
                  child: Text("GHYYH1900UI",
                    textAlign: TextAlign.center,
                    style: fontMedium.copyWith(
                        fontSize: 14.sp,
                        color: AppColor.secondaryColor
                    ),),
                ),
              ),
              SizedBox(width: 10.w),
              InkWell(
                onTap: (){
                  Share.share('BHFHDF9800M', subject: 'Share your referral code');
                },
                  child: SvgPicture.asset(Images.share, color: AppColor.secondaryColor, width: 6.w,))
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
          ),
          child: const CustomButton(AppColor.textColor, "Invite Now", AppColor.lightColor),
        ),
      ],
    );
  }
}

class Steps extends StatelessWidget {
  final String image, step, content;
  const Steps(this.image, this.step, this.content, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(image, fit: BoxFit.cover, width: 14.w,),
        SizedBox(width: 3.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Step $step:",
                style: fontRegular.copyWith(
                    fontSize: 11.sp,
                    color: AppColor.textColor
                ),),
              SizedBox(height: 0.5.h),
              Text(content,
                style: fontRegular.copyWith(
                    fontSize: 11.sp,
                    color: AppColor.textColor
                ),),
            ],
          ),
        ),
      ],
    );
  }
}

