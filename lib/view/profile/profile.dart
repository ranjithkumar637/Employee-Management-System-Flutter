import 'package:elevens_organizer/view/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final TextEditingController groundNameController = TextEditingController();
  final TextEditingController groundMobileController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();

  DateTime date = DateTime.now();

  String removeTime(DateTime dateTime) {
    DateFormat dateFormat = DateFormat('dd-MM-yyyy');
    String formattedDate = dateFormat.format(dateTime);

    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.bgColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 2.h,
                    ),
                    child: Text("Ground Information",
                      style: fontMedium.copyWith(
                          color: AppColor.textColor,
                          fontSize: 13.sp
                      ),),
                  ),
                  const Divider(
                    height: 0.5,
                  ),
                  SizedBox(height: 2.h),
                  //ground name
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 5.w
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Ground Name *",
                          style: fontRegular.copyWith(
                              fontSize: 11.sp,
                              color: AppColor.textMildColor
                          ),),
                        SizedBox(height:1.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                            vertical: 1.5.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.lightColor,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Center(
                            child: TextFormField(
                              controller: groundNameController,
                              cursorColor: AppColor.secondaryColor,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter ground name';
                                }
                                return null;
                              },
                              style: fontRegular.copyWith(
                                  fontSize: 10.sp,
                                  color: AppColor.textColor
                              ),
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                hintText: "Ex: Square out fighters",
                                hintStyle: fontRegular.copyWith(
                                    fontSize: 10.sp,
                                    color: AppColor.hintColour
                                ),),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),
                  //ground mobile number
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 5.w
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Mobile Number *",
                          style: fontRegular.copyWith(
                              fontSize: 11.sp,
                              color: AppColor.textMildColor
                          ),),
                        SizedBox(height:1.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                            vertical: 1.5.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.lightColor,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Center(
                            child: TextFormField(
                              controller: groundMobileController,
                              cursorColor: AppColor.secondaryColor,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter mobile number';
                                }
                                return null;
                              },
                              style: fontRegular.copyWith(
                                  fontSize: 10.sp,
                                  color: AppColor.textColor
                              ),
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                hintText: "Ex: 9876546576",
                                hintStyle: fontRegular.copyWith(
                                    fontSize: 10.sp,
                                    color: AppColor.hintColour
                                ),),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 2.h,
                    ),
                    child: Text("Personal Information",
                      style: fontMedium.copyWith(
                          color: AppColor.textColor,
                          fontSize: 13.sp
                      ),),
                  ),
                  const Divider(
                    height: 0.5,
                  ),
                  SizedBox(height: 2.h),
                  //organizer name
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 5.w
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Name *",
                          style: fontRegular.copyWith(
                              fontSize: 11.sp,
                              color: AppColor.textMildColor
                          ),),
                        SizedBox(height:1.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                            vertical: 1.5.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.lightColor,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Center(
                            child: TextFormField(
                              controller: nameController,
                              cursorColor: AppColor.secondaryColor,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter your name';
                                }
                                return null;
                              },
                              style: fontRegular.copyWith(
                                  fontSize: 10.sp,
                                  color: AppColor.textColor
                              ),
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                hintText: "Ex: John Doe",
                                hintStyle: fontRegular.copyWith(
                                    fontSize: 10.sp,
                                    color: AppColor.hintColour
                                ),),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),
                  //organizer mobile number
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 5.w
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Mobile Number *",
                          style: fontRegular.copyWith(
                              fontSize: 11.sp,
                              color: AppColor.textMildColor
                          ),),
                        SizedBox(height:1.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                            vertical: 1.5.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.lightColor,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Center(
                            child: TextFormField(
                              controller: mobileNumberController,
                              cursorColor: AppColor.secondaryColor,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter mobile number';
                                }
                                return null;
                              },
                              style: fontRegular.copyWith(
                                  fontSize: 10.sp,
                                  color: AppColor.textColor
                              ),
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                hintText: "Ex: 9876546576",
                                hintStyle: fontRegular.copyWith(
                                    fontSize: 10.sp,
                                    color: AppColor.hintColour
                                ),),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),
                  //date of birth
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 5.w
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Date of Birth",
                          style: fontRegular.copyWith(
                              fontSize: 11.sp,
                              color: AppColor.textMildColor
                          ),),
                        SizedBox(height:1.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                            vertical: 1.6.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.lightColor,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  removeTime(date),
                                  style: fontRegular.copyWith(
                                      color: AppColor.textColor,
                                      fontSize: 11.sp
                                  ),
                                ),
                              ),
                              SvgPicture.asset(Images.calendarIcon, color: AppColor.textColor, width: 5.5.w,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),
                  //location
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 5.w
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Location",
                          style: fontRegular.copyWith(
                              fontSize: 11.sp,
                              color: AppColor.textMildColor
                          ),),
                        SizedBox(height:1.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                            vertical: 1.6.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.lightColor,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  removeTime(date),
                                  style: fontRegular.copyWith(
                                      color: AppColor.textColor,
                                      fontSize: 11.sp
                                  ),
                                ),
                              ),
                              Icon(Icons.keyboard_arrow_down_sharp, color: AppColor.textMildColor, size: 5.w,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5.w,
              vertical: 3.h,
            ),
            child: const CustomButton(AppColor.textColor, "Save Profile", AppColor.lightColor),
          ),
        ],
      ),
    );
  }
}
