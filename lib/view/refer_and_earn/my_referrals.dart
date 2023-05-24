import 'package:flutter/material.dart';
import 'package:flutter_animator/animation/animation_preferences.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_up.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';

class MyReferrals extends StatelessWidget {
  const MyReferrals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      preferences: const AnimationPreferences(
          duration: Duration(milliseconds: 400)
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 1.5.h,
              crossAxisSpacing: 3.w,
              childAspectRatio: 2.6
          ),
          itemCount: 27,
          itemBuilder: (BuildContext context, int index) {
            return const ReferralsCard("15", "Priyan");
          },
        ),
      ),
    );
  }
}

class ReferralsCard extends StatelessWidget {
  final String points, referral;
  const ReferralsCard(this.points, this.referral, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffFAC713),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topRight,
        children: [
          Padding(
            padding: EdgeInsets.only(
                right: 2.w, bottom: 1.h
            ),
            child: SvgPicture.asset(Images.refPointsImage, width: 23.w,),
          ),
          Positioned(
            left: 2.w,
            top: 0.8.h,
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 3.w,
                    vertical: 1.5.h,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColor.textColor,
                    shape: BoxShape.circle
                  ),
                  child: RichText(
                       text: TextSpan(
                       text: 'You got',
                       style: fontRegular.copyWith(
                          color: AppColor.lightColor,
                          fontSize: 8.sp,
                         ),
                       children: <TextSpan>[
                           TextSpan(text: '\n$points Points',
                            style: fontRegular.copyWith(
                            color: AppColor.primaryColor,
                            fontSize: 8.sp,
                          ),
                      )
                      ]
                     ),
                    ),
                ),
                SizedBox(width: 3.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Invited",
                      style: fontRegular.copyWith(
                          fontSize: 10.sp,
                          color: AppColor.textColor
                      ),),
                    Text(referral,
                      style: fontMedium.copyWith(
                          fontSize: 10.sp,
                          color: AppColor.textColor
                      ),),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

