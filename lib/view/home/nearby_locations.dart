import 'package:flutter/material.dart';
import 'package:flutter_animator/animation/animation_preferences.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_up.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/colours.dart';
import '../../../utils/images.dart';
import '../../../utils/styles.dart';

class NearbyLocations extends StatelessWidget {
  final String location;
  const NearbyLocations(this.location, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      preferences: const AnimationPreferences(
          duration: Duration(milliseconds: 600)
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 5.w,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Text(location,
                style: fontRegular.copyWith(
                    fontSize: 11.5.sp,
                    color: AppColor.textMildColor
                ),),
            ),
            SvgPicture.asset(Images.mapIcon, width: 5.w, color: AppColor.datePickerColor,),
          ],
        ),
      ),
    );
  }
}
