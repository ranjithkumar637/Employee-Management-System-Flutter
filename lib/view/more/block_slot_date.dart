import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';

class BlockSlotDate extends StatefulWidget {
  const BlockSlotDate({Key? key}) : super(key: key);

  @override
  State<BlockSlotDate> createState() => _BlockSlotDateState();
}

class _BlockSlotDateState extends State<BlockSlotDate> {

  final TextEditingController reasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 5.w
            ) + EdgeInsets.only(
                top: 5.h, bottom: 3.h
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap:(){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back, color: AppColor.textColor, size: 7.w,)),
                Text("Block Slot & Date",
                  style: fontMedium.copyWith(
                      fontSize: 16.sp,
                      color: AppColor.textColor
                  ),),
                SizedBox(width: 7.w,),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Date",
                        style: fontMedium.copyWith(
                            fontSize: 13.sp,
                            color: AppColor.textColor
                        ),),
                      SizedBox(height: 1.5.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 3.w,
                          vertical: 1.4.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.lightColor,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Select Date",
                              style: fontMedium.copyWith(
                                  fontSize: 10.sp,
                                  color: AppColor.textMildColor
                              ),),
                            SvgPicture.asset(Images.calendarIcon, color: AppColor.iconColour, width: 5.w,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Select slot",
                        style: fontMedium.copyWith(
                            fontSize: 13.sp,
                            color: AppColor.textColor
                        ),),
                      SizedBox(height: 1.5.h),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Reason",
                            style: fontMedium.copyWith(
                                fontSize: 13.sp,
                                color: AppColor.textColor
                            ),),
                          Text("Optional",
                            style: fontMedium.copyWith(
                                fontSize: 11.sp,
                                color: AppColor.textMildColor
                            ),),
                        ],
                      ),
                      SizedBox(height: 1.5.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 3.w,
                          vertical: 1.4.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.lightColor,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: TextFormField(
                          controller: reasonController,
                          cursorColor: AppColor.secondaryColor,
                          maxLines: 8,
                          style: fontRegular.copyWith(
                              fontSize: 10.sp,
                              color: AppColor.textColor
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText: "Ex: Lorem ipsum",
                            hintStyle: fontRegular.copyWith(
                                fontSize: 10.sp,
                                color: AppColor.hintColour
                            ),),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: 2.5.h
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 1.2.h,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.primaryColor, width: 1.2),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Center(
                    child: Text("Reset",
                      style: fontRegular.copyWith(
                          color: AppColor.secondaryColor,
                          fontSize: 12.sp
                      ),),
                  ),
                ),
                SizedBox(width: 5.w),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 1.2.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.textColor,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Center(
                    child: Text("Save",
                      style: fontRegular.copyWith(
                          color: AppColor.lightColor,
                          fontSize: 12.sp
                      ),),
                  ),
                ),
                SizedBox(width: 5.w),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
