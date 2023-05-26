import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import '../widgets/team_code.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, description, code;
  const CustomDialogBox(this.title, this.description, this.code, {Key? key}) : super(key: key);

  @override
  State<CustomDialogBox> createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(BuildContext context){
    return Container(
      height: 55.h,
      // width: 90.w,
      padding: EdgeInsets.symmetric(
        horizontal: 3.w,
        vertical: 3.h,
      ),
      decoration: BoxDecoration(
        color: AppColor.lightColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        children: [
          Text(widget.title,
            style: fontMedium.copyWith(
                fontSize: 20.sp,
                color: AppColor.textColor
            ),),
          SizedBox(height: 2.h),
          Image.asset(Images.createTeamImg, width: 40.w,),
          SizedBox(height: 2.h),
          Text(widget.description,
            textAlign: TextAlign.center,
            style: fontRegular.copyWith(
                fontSize: 11.sp,
                color: AppColor.textMildColor
            ),),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TeamCode(widget.code, false),
              SizedBox(width: 5.w),
              SvgPicture.asset(Images.share, color: AppColor.secondaryColor, width: 6.w,),
            ],
          ),
          const Spacer(),
          Bounceable(
            onTap: (){
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_back, color: AppColor.secondaryColor, size: 5.w,),
                      SizedBox(width: 2.w),
                      Text("Go back",
                        style: fontMedium.copyWith(
                            fontSize: 11.sp,
                            color: AppColor.secondaryColor
                        ),),
                    ],
                  ),
                  SizedBox(width: 2.w),
                  Text("(Add players to playable teams) ",
                    style: fontRegular.copyWith(
                        fontSize: 8.sp,
                        color: AppColor.textMildColor
                    ),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
