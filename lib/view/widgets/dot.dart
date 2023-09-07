import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';

class Dot extends StatelessWidget {
  const Dot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.5.h,
      width: 1.w,
      decoration: const BoxDecoration(
        color: AppColor.lightColor,
        shape: BoxShape.circle
      ),
    );
  }
}
