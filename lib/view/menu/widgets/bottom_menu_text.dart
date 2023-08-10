import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/styles.dart';

class MenuText extends StatelessWidget {
  final String tabName;
  final Color color;
  const MenuText(this.tabName, this.color, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(tabName,
        style: fontMedium.copyWith(
            fontSize: 9.sp,
          color: color
        ));
  }
}
