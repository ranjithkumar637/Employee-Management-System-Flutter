import 'package:elevens_organizer/utils/images.dart';
import 'package:elevens_organizer/view/toss/toss_summary_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/styles.dart';

class TossResultDialog extends StatefulWidget {
  const TossResultDialog({Key? key}) : super(key: key);

  @override
  State<TossResultDialog> createState() => _TossResultDialogState();
}

class _TossResultDialogState extends State<TossResultDialog> {

  bool selectedTeamA = false;
  bool selectedTeamB = false;

  bool batting = false;
  bool bowling = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(BuildContext context){
    return Container(
      height: 70.h,
      padding: EdgeInsets.symmetric(
        horizontal: 4.w,
        vertical: 3.h,
      ),
      decoration: BoxDecoration(
        color: AppColor.lightColor,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Column(
        children: [
          Text("Who won the Toss?",
            style: fontMedium.copyWith(
                fontSize: 16.sp,
                color: AppColor.textColor
            ),),
          SizedBox(height: 2.h),
          Row(
            children: [
              Expanded(
                  child: Bounceable(
                    onTap: (){
                      setState(() {
                        selectedTeamB = false;
                        selectedTeamA = true;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                        vertical: 1.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: selectedTeamA ? AppColor.primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: AppColor.primaryColor)
                ),
                      child: Column(
                        children: [
                          ClipOval(child: Image.asset(Images.groundListImage1, width: 24.w, height: 12.h, fit: BoxFit.cover,)),
                          SizedBox(height: 2.h),
                          Text("Toss & Tails",
                            style: fontMedium.copyWith(
                                fontSize: 14.sp,
                                color: AppColor.textColor
                            ),),
                        ],
                      ),
                    ),
                  )),
              SizedBox(width: 3.w),
              Expanded(
                  child: Bounceable(
                    onTap: (){
                      setState(() {
                        selectedTeamA = false;
                        selectedTeamB = true;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                        vertical: 1.5.h,
                      ),
                      decoration: BoxDecoration(
                          color: selectedTeamB ? AppColor.primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: AppColor.primaryColor)
                      ),
                      child: Column(
                        children: [
                          ClipOval(child: Image.asset(Images.groundListImage2, width: 24.w, height: 12.h, fit: BoxFit.cover,)),
                          SizedBox(height: 2.h),
                          Text("Dhoni CC",
                            style: fontMedium.copyWith(
                                fontSize: 14.sp,
                                color: AppColor.textColor
                            ),),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
          SizedBox(height: 4.h),
          Text("Choose to?",
            style: fontMedium.copyWith(
                fontSize: 16.sp,
                color: AppColor.textColor
            ),),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Bounceable(
                onTap: (){
                  setState(() {
                    batting = true;
                    bowling = false;
                  });
                },
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 25.w, height: 12.5.h,
                          padding: EdgeInsets.symmetric(
                            horizontal: 2.w,
                            vertical: 1.h,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColor.primaryColor)
                          ),
                          child: SvgPicture.asset(Images.battingImage),
                        ),
                        Positioned(
                          top: 0.0,
                          right: 0.0,
                          child: batting ? Icon(Icons.check_circle, color: AppColor.primaryColor, size: 7.w,) : const SizedBox(),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Text("Batting",
                      style: fontMedium.copyWith(
                          fontSize: 14.sp,
                          color: AppColor.textColor
                      ),),
                  ],
                ),
              ),
              Bounceable(
                onTap: (){
                  setState(() {
                    batting = false;
                    bowling = true;
                  });
                },
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 25.w, height: 12.5.h,
                          padding: EdgeInsets.symmetric(
                            horizontal: 2.w,
                            vertical: 1.h,
                          ),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColor.primaryColor)
                          ),
                          child: SvgPicture.asset(Images.bowlingImage),
                        ),
                        Positioned(
                          top: 0.0,
                          right: 0.0,
                          child: bowling ? Icon(Icons.check_circle, color: AppColor.primaryColor, size: 7.w,) : const SizedBox(),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Text("Bowling",
                      style: fontMedium.copyWith(
                          fontSize: 14.sp,
                          color: AppColor.textColor
                      ),),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Bounceable(
                onTap: (){
                  Navigator.pop(context);
                  showDialog(context: context,
                      builder: (BuildContext context){
                        return const TossSummaryDialog(
                        );
                      });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 7.w,
                    vertical: 1.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.textColor,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Center(
                    child: Text("Save",
                      style: fontRegular.copyWith(
                          color: AppColor.lightColor,
                          fontSize: 11.sp
                      ),),
                  ),
                ),
              ),
              SizedBox(width: 5.w),
            ],
          ),
        ],
      ),
    );
  }

}
