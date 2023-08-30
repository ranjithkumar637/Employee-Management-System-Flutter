import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/styles.dart';

class NoInternetView extends StatelessWidget {
  const NoInternetView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.signal_wifi_off_outlined, size: 7.w,),
              SizedBox(width: 5.w),
              Icon(Icons.signal_cellular_connected_no_internet_0_bar, size: 7.w,),
            ],
          ),
          SizedBox(height: 4.h),
          Center(
            child:  Text(
                'No internet connection\nTurn on your WiFi / Mobile data',
                textAlign: TextAlign.center,
                style: fontMedium.copyWith(
                    fontSize: 12.sp,
                    color: AppColor.redColor
                )
            ),
          ),
        ],
      ),
    );
  }
}
