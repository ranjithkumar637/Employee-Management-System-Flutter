import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';

class LocationData extends StatefulWidget {
  const LocationData({Key? key}) : super(key: key);

  @override
  State<LocationData> createState() => _LocationDataState();
}

class _LocationDataState extends State<LocationData> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 2.h,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 1.5.h,
      ),
      decoration: BoxDecoration(
        color: AppColor.lightColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Location",
                style: fontMedium.copyWith(
                    color: AppColor.textColor,
                    fontSize: 12.sp
                ),),
              InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, "add_address");
                  },
                  child: SvgPicture.asset(Images.editIcon, color: AppColor.iconColour, width: 4.w,)),
            ],
          ),
          SizedBox(height: 2.h),
          SizedBox(
              width: double.maxFinite,
              height: 14.h,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: ColoredBox(color: Colors.lightBlueAccent.withOpacity(0.2),))
          ),
        ],
      ),
    );
  }
}
