import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/styles.dart';

class PlayerStyle extends StatelessWidget {
  final String playerStyle;
  const PlayerStyle(this.playerStyle, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(radius: 3, backgroundColor: AppColor.primaryColor,),
        SizedBox(width: 2.w),
        Text(playerStyle,
          style: fontRegular.copyWith(
              fontSize: 9.5.sp,
              color: AppColor.textMildColor
          ),),
      ],
    );
  }
}
