import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/colours.dart';
import '../../../utils/styles.dart';

class GridItem extends StatelessWidget {
  final String name, image;
  final Color color;
  const GridItem(this.name, this.image, this.color, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 13.h,
      padding: EdgeInsets.symmetric(
          horizontal: 3.w, vertical: 1.5.h
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            color,
            AppColor.bgColor,
          ],
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 5.w, vertical: 1.h
              ),
              decoration: const BoxDecoration(
                  color: AppColor.textColor,
                  shape: BoxShape.circle
              ),
              child: SvgPicture.asset(image, width: 7.w,)),
          const Spacer(),
          Text(name,
            textAlign: TextAlign.center,
            style: fontMedium.copyWith(
                fontSize: 8.5.sp,
                color: AppColor.textColor
            ),),
        ],
      ),
    );
  }
}
