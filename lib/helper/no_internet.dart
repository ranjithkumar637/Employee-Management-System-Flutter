import 'package:elevens_organizer/helper/size_config.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/styles.dart';

class NoInternet extends StatelessWidget {
  final Function checkUserConnection;
  const NoInternet(
    this.checkUserConnection, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset("assets/no-internet.json",
              width: 50 * SizeConfig.imageSizeMultiplier),
          SizedBox(height: 1.h),
          Text(
            "No internet connection",
            style: fontMedium.copyWith(
                color: AppColor.primaryColor,
                fontSize: 2.4 * SizeConfig.textMultiplier),
          ),
          SizedBox(
            height: 4 * SizeConfig.heightMultiplier,
          ),
          GestureDetector(
            onTap: () {
              checkUserConnection();
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 5 * SizeConfig.widthMultiplier,
                vertical: 1.5 * SizeConfig.heightMultiplier,
              ),
              decoration: BoxDecoration(
                color: AppColor.secondaryColor,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Try again",
                    style: fontRegular.copyWith(
                        color: const Color(0xffffffff),
                        fontSize: 1.8 * SizeConfig.textMultiplier),
                  ),
                  SizedBox(width: 5 * SizeConfig.widthMultiplier),
                  Icon(
                    Icons.arrow_forward,
                    color: const Color(0xffffffff),
                    size: 6 * SizeConfig.imageSizeMultiplier,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
