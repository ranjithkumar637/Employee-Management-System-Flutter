import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import '../widgets/custom_button.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {

  bool showFirst = true;
  bool loading = false;
  double initHeight = 75.h;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController houseController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              AnimatedContainer(
                width: double.maxFinite,
                height: initHeight,
                decoration: const BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    )
                ), duration: const Duration(milliseconds: 300),
              ),
              Positioned(
                top: 5.h,
                left: 5.w,
                child: GestureDetector(
                    onTap:(){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back, color: AppColor.textColor, size: 7.w,)),
              ),
              Positioned(
                top: 5.h,
                child: Text("Add Address",
                  style: fontMedium.copyWith(
                      fontSize: 16.sp,
                      color: AppColor.textColor
                  ),),
              ),
            ],
          ),
          Expanded(
            child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  final scaleAnimation = Tween<double>(
                    begin: 0.0,
                    end: 1.0,
                  ).animate(animation);

                  return ScaleTransition(
                    scale: scaleAnimation,
                    child: child,
                  );
                },
                child: showFirst
                    ? MediaQuery.removePadding(
                      removeTop: true,
                      context: context,
                      child: ListView(
                  children: [
                      Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.symmetric(
                          horizontal: 5.w,
                          vertical: 3.h,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 4.w,
                          vertical: 1.5.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 3.w,
                                vertical: 1.5.h,
                              ),
                              decoration: const BoxDecoration(
                                  color: Color(0xff333333),
                                  shape: BoxShape.circle
                              ),
                              child: SvgPicture.asset(Images.currentLocationImage, color: AppColor.primaryColor, width: 6.w,),
                            ),
                            SizedBox(width: 3.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Use my current location",
                                    style: fontMedium.copyWith(
                                        fontSize: 12.sp,
                                        color: AppColor.textColor
                                    ),),
                                  SizedBox(height: 0.5.h),
                                  Text("Aspace gems, Madipakkam, Chennai",
                                    style: fontRegular.copyWith(
                                        fontSize: 10.sp,
                                        color: AppColor.textColor
                                    ),),
                                ],
                              ),
                            ),
                            SizedBox(width: 3.w),
                            Icon(Icons.arrow_forward_ios_rounded, color: AppColor.textColor, size: 4.w,)
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w
                        ),
                        child: Bounceable(
                            onTap: (){
                              setState(() {
                                showFirst = !showFirst;
                                initHeight = 45.h;
                              });
                            },
                            child: const CustomButton(AppColor.textColor, 'Confirm Location', AppColor.lightColor)),
                      ),
                  ],
                ),
                    )
                    : Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 5.w
                  ),
                  child: Form(
                    key: _formKey,
                    child: MediaQuery.removePadding(
                      removeTop: true,
                      context: context,
                      child: ListView(
                        children: [
                          SizedBox(height: 3.h),
                          Text("Add Address details",
                            style: fontMedium.copyWith(
                                color: AppColor.textColor,
                                fontSize: 15.sp
                            ),),
                          SizedBox(height: 4.h),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("House No / Flat No",
                                style: fontRegular.copyWith(
                                    fontSize: 9.sp,
                                    color: AppColor.textColor
                                ),),
                              SizedBox(height:1.h),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5.w,
                                  vertical: 1.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColor.lightColor,
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: Center(
                                  child: TextFormField(
                                    controller: houseController,
                                    cursorColor: AppColor.secondaryColor,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter house/flat no';
                                      }
                                      return null;
                                    },
                                    style: fontRegular.copyWith(
                                        fontSize: 10.sp,
                                        color: AppColor.textColor
                                    ),
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      border: InputBorder.none,
                                      hintText: "14/s1",
                                      hintStyle: fontRegular.copyWith(
                                          fontSize: 10.sp,
                                          color: AppColor.textMildColor
                                      ),),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Street name",
                                style: fontRegular.copyWith(
                                    fontSize: 9.sp,
                                    color: AppColor.textColor
                                ),),
                              SizedBox(height:1.h),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5.w,
                                  vertical: 1.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColor.lightColor,
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: Center(
                                  child: TextFormField(
                                    controller: streetController,
                                    cursorColor: AppColor.secondaryColor,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter street name';
                                      }
                                      return null;
                                    },
                                    style: fontRegular.copyWith(
                                        fontSize: 10.sp,
                                        color: AppColor.textColor
                                    ),
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      border: InputBorder.none,
                                      hintText: "Sakthi nagar",
                                      hintStyle: fontRegular.copyWith(
                                          fontSize: 10.sp,
                                          color: AppColor.textMildColor
                                      ),),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Pincode",
                                style: fontRegular.copyWith(
                                    fontSize: 9.sp,
                                    color: AppColor.textColor
                                ),),
                              SizedBox(height:1.h),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5.w,
                                  vertical: 1.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColor.lightColor,
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: Center(
                                  child: TextFormField(
                                    controller: pinCodeController,
                                    cursorColor: AppColor.secondaryColor,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter pincode';
                                      }
                                      return null;
                                    },
                                    style: fontRegular.copyWith(
                                        fontSize: 10.sp,
                                        color: AppColor.textColor
                                    ),
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      border: InputBorder.none,
                                      hintText: "630606",
                                      hintStyle: fontRegular.copyWith(
                                          fontSize: 10.sp,
                                          color: AppColor.textMildColor
                                      ),),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Bounceable(
                              onTap: (){
                                setState(() {
                                  showFirst = !showFirst;
                                  initHeight = 75.h;
                                });
                              },
                              child: const CustomButton(AppColor.textColor, 'Save', AppColor.lightColor)),
                        ],
                      ),
                    ),
                  ),
                )
            ),
          ),

        ],
      ),
    );
  }
}
