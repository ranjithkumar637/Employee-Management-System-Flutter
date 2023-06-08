import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/styles.dart';

class PlayerName extends StatelessWidget {
  final String playerName;
  const PlayerName(this.playerName, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(playerName,
      style: fontMedium.copyWith(
          fontSize: 10.sp,
          color: AppColor.textColor
      ),);
  }
}
