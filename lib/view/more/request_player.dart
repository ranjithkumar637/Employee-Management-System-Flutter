import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/styles.dart';


class RequestPlayer extends StatefulWidget {
  const RequestPlayer({Key? key}) : super(key: key);

  @override
  State<RequestPlayer> createState() => _RequestPlayerState();
}

class _RequestPlayerState extends State<RequestPlayer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: Column(
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
                    child: Icon(Icons.arrow_back_rounded, color: AppColor.textColor, size: 7.w,)),
                Text("Request Player/Team",
                  style: fontMedium.copyWith(
                      fontSize: 16.sp,
                      color: AppColor.textColor
                  ),),
                SizedBox(width: 7.w,),
              ],
            ),
          ),
          Expanded(
            child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                      vertical: 2.h,
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: 5.w,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.lightColor,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Request",
                              style: fontMedium.copyWith(
                                  fontSize: 13.sp,
                                  color: AppColor.textColor
                              ),),
                            GestureDetector(
                                onTap:(){
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.delete_outline_outlined, color: AppColor.secondaryColor, size: 6.w,)),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        Text("Choose Organizer Team",
                          style: fontRegular.copyWith(
                              fontSize: 11.sp,
                              color: AppColor.textColor
                          ),),
                        SizedBox(height: 1.5.h),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 4.w,
                            vertical: 1.4.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xffFBFAF7),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text("Toss & Tails",
                                  style: fontRegular.copyWith(
                                      color: AppColor.textColor,
                                      fontSize: 11.sp
                                  ),),
                              ),
                              Icon(Icons.keyboard_arrow_down, color: AppColor.textMildColor, size: 5.w,),
                            ],
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text("Ground Name",
                          style: fontRegular.copyWith(
                              fontSize: 11.sp,
                              color: AppColor.textColor
                          ),),
                        SizedBox(height: 1.h),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 4.w,
                            vertical: 1.4.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xffFBFAF7),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text("Square Out Fighters",
                                  style: fontRegular.copyWith(
                                      color: AppColor.textColor,
                                      fontSize: 11.sp
                                  ),),
                              ),
                              Icon(Icons.keyboard_arrow_down, color: AppColor.textMildColor, size: 5.w,),
                            ],
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Text("Date",
                                style: fontRegular.copyWith(
                                    fontSize: 11.sp,
                                    color: AppColor.textColor
                                ),),
                            ),
                            SizedBox(width: 4.w),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Text("Slot time",
                                style: fontRegular.copyWith(
                                    fontSize: 11.sp,
                                    color: AppColor.textColor
                                ),),
                            ),
                            SizedBox(width: 4.w),
                            Expanded(
                              child: Text("Date",
                                style: fontRegular.copyWith(
                                    fontSize: 12.sp,
                                    color: Colors.transparent
                                ),),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              padding: EdgeInsets.symmetric(
                                horizontal: 5.w,
                                vertical: 1.5.h,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xffFBFAF7),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Center(
                                child: Text("20/02/2023",
                                  style: fontRegular.copyWith(
                                      color: AppColor.textColor,
                                      fontSize: 11.sp
                                  ),),
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              padding: EdgeInsets.symmetric(
                                horizontal: 2.w,
                                vertical: 1.5.h,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xffFBFAF7),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Center(
                                child: Text("07.00",
                                  style: fontRegular.copyWith(
                                      color: AppColor.textColor,
                                      fontSize: 11.sp
                                  ),),
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 3.w,
                                vertical: 1.5.h,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xffFBFAF7),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Row(
                                children: [
                                  Text("AM",
                                    style: fontRegular.copyWith(
                                        color: AppColor.textColor,
                                        fontSize: 11.sp
                                    ),),
                                  SizedBox(width: 2.w),
                                  Icon(Icons.keyboard_arrow_down, color: AppColor.textMildColor, size: 5.w,),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 3.h),
                        Text("Role",
                          style: fontMedium.copyWith(
                              fontSize: 11.sp,
                              color: AppColor.textColor
                          ),),
                        SizedBox(height: 1.5.h),
                        Row(
                          children: [
                            Text("Batsman",
                              style: fontRegular.copyWith(
                                  fontSize: 11.sp,
                                  color: AppColor.textColor
                              ),),
                            const Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 4.w,
                                vertical: 1.4.h,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xffFBFAF7),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.remove, color: AppColor.textMildColor, size: 4.5.w,),
                                  SizedBox(width: 4.w),
                                  Text("1",
                                    style: fontRegular.copyWith(
                                        color: AppColor.textColor,
                                        fontSize: 11.sp
                                    ),),
                                  SizedBox(width: 4.w),
                                  Icon(Icons.add, color: AppColor.textMildColor, size: 4.5.w,),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.5.h),
                        Row(
                          children: [
                            Text("Bowler",
                              style: fontRegular.copyWith(
                                  fontSize: 11.sp,
                                  color: AppColor.textColor
                              ),),
                            const Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 4.w,
                                vertical: 1.4.h,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xffFBFAF7),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.remove, color: AppColor.textMildColor, size: 4.5.w,),
                                  SizedBox(width: 4.w),
                                  Text("1",
                                    style: fontRegular.copyWith(
                                        color: AppColor.textColor,
                                        fontSize: 11.sp
                                    ),),
                                  SizedBox(width: 4.w),
                                  Icon(Icons.add, color: AppColor.textMildColor, size: 4.5.w,),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.5.h),
                        Row(
                          children: [
                            Text("Wicket-Keeper",
                              style: fontRegular.copyWith(
                                  fontSize: 11.sp,
                                  color: AppColor.textColor
                              ),),
                            const Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 4.w,
                                vertical: 1.4.h,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xffFBFAF7),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.remove, color: AppColor.textMildColor, size: 4.5.w,),
                                  SizedBox(width: 4.w),
                                  Text("1",
                                    style: fontRegular.copyWith(
                                        color: AppColor.textColor,
                                        fontSize: 11.sp
                                    ),),
                                  SizedBox(width: 4.w),
                                  Icon(Icons.add, color: AppColor.textMildColor, size: 4.5.w,),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.5.h),
                        Row(
                          children: [
                            Text("All-rounder",
                              style: fontRegular.copyWith(
                                  fontSize: 11.sp,
                                  color: AppColor.textColor
                              ),),
                            const Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 4.w,
                                vertical: 1.4.h,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xffFBFAF7),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.remove, color: AppColor.textMildColor, size: 4.5.w,),
                                  SizedBox(width: 4.w),
                                  Text("1",
                                    style: fontRegular.copyWith(
                                        color: AppColor.textColor,
                                        fontSize: 11.sp
                                    ),),
                                  SizedBox(width: 4.w),
                                  Icon(Icons.add, color: AppColor.textMildColor, size: 4.5.w,),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 3.h),
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
                        SizedBox(height: 1.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}
