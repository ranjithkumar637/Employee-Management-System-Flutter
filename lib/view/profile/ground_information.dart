import 'package:elevens_organizer/providers/profile_provider.dart';
import 'package:elevens_organizer/utils/images.dart';
import 'package:elevens_organizer/view/profile/update_ground_info_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/styles.dart';

class GroundInformation extends StatelessWidget {
  final ProfileProvider ground;
  const GroundInformation(this.ground, {Key? key}) : super(key: key);

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
              Text("Ground Information",
                style: fontMedium.copyWith(
                    color: AppColor.textColor,
                    fontSize: 12.sp
                ),),
              InkWell(
                  onTap: (){
                    showDialog(context: context,
                        builder: (BuildContext context){
                          return UpdateGroundInfoDialog(
                              ground.pitch,
                              ground.boundaryLine,
                              ground.floodLight);
                        }
                    );
                  },
                  child: SvgPicture.asset(Images.editIcon, color: AppColor.iconColour, width: 4.w,)),
            ],
          ),
          SizedBox(height: 2.h),
          GroundInfoRow("Pitch", ground.pitch),
          SizedBox(height: 2.h),
          GroundInfoRow("Boundary Line", ground.boundaryLine),
          SizedBox(height: 2.h),
          GroundInfoRow("Flood light", ground.floodLight == 1 ? "Yes" : "No"),
        ],
      ),
    );
  }
}

class GroundInfoRow extends StatelessWidget {
  final String heading, value;
  const GroundInfoRow(this.heading, this.value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(heading,
          style: fontRegular.copyWith(
              color: AppColor.textMildColor,
              fontSize: 11.sp
          ),),
        Text(value == "" ? '-' : value,
          style: fontRegular.copyWith(
              color: AppColor.textColor,
              fontSize: 11.sp
          ),),
      ],
    );
  }
}

