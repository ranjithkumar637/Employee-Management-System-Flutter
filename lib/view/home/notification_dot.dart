import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/colours.dart';

class NotificationDot extends StatelessWidget {
  const NotificationDot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2.w,
      height: 1.h,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColor.redColor
      ),
    );
  }
}
