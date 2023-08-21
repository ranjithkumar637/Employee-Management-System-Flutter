import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/styles.dart';

class RoleCircle extends StatelessWidget {
  final String role;
  const RoleCircle(this.role,{
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 1.4.w,
        vertical: 0.2.h,
      ),
      decoration: BoxDecoration(
        color: AppColor.roleBg,
        borderRadius:
        BorderRadius.circular(30.0),
      ),
      child: Text(role.toString(),
        style: fontMedium.copyWith(
            fontSize: 8.sp,
            color: AppColor.lightColor
        ),),
    );
  }
}
