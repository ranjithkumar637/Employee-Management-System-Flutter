import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/styles.dart';

class AddAmountDialogBox extends StatefulWidget {
  const AddAmountDialogBox({Key? key}) : super(key: key);

  @override
  State<AddAmountDialogBox> createState() => _AddAmountDialogBoxState();
}

class _AddAmountDialogBoxState extends State<AddAmountDialogBox> {

  final TextEditingController amountController = TextEditingController();
  final TextEditingController splitController = TextEditingController();


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
      height: 50.h,
      padding: EdgeInsets.symmetric(
        horizontal: 3.w,
        vertical: 3.h,
      ),
      decoration: BoxDecoration(
        color: AppColor.lightColor,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Column(
        children: [
          Text("Toss and Tails",
            style: fontMedium.copyWith(
                fontSize: 12.sp,
                color: AppColor.textColor
            ),),
          SizedBox(height: 2.h),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 5.w
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Payment Status",
                  style: fontRegular.copyWith(
                      fontSize: 10.sp,
                      color: AppColor.textColor
                  ),),
                SizedBox(height:1.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.w,
                    vertical: 1.6.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xffFBFAF7),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Unpaid",
                          style: fontRegular.copyWith(
                              color: AppColor.textColor,
                              fontSize: 10.sp
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
          SizedBox(height: 2.h),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 5.w
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total amount",
                        style: fontRegular.copyWith(
                            fontSize: 10.sp,
                            color: AppColor.textColor
                        ),),
                      SizedBox(height:1.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.w,
                          vertical: 0.5.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xffFBFAF7),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Center(
                          child: TextField(
                            controller: amountController,
                            cursorColor: AppColor.secondaryColor,
                            style: fontRegular.copyWith(
                                fontSize: 10.sp,
                                color: AppColor.textColor
                            ),
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              hintText: "9999911111",
                              hintStyle: fontRegular.copyWith(
                                  fontSize: 10.sp,
                                  color: AppColor.textMildColor
                              ),),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Paid amount",
                        style: fontRegular.copyWith(
                            fontSize: 10.sp,
                            color: AppColor.textColor
                        ),),
                      SizedBox(height:1.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.w,
                          vertical: 0.5.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xffFBFAF7),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Center(
                          child: TextField(
                            controller: amountController,
                            cursorColor: AppColor.secondaryColor,
                            style: fontRegular.copyWith(
                                fontSize: 10.sp,
                                color: AppColor.textColor
                            ),
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              hintText: "9999911111",
                              hintStyle: fontRegular.copyWith(
                                  fontSize: 10.sp,
                                  color: AppColor.textMildColor
                              ),),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 2.h),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 5.w
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Balance",
                  style: fontRegular.copyWith(
                      fontSize: 10.sp,
                      color: AppColor.textColor
                  ),),
                SizedBox(height:1.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.w,
                    vertical: 0.5.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xffFBFAF7),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Center(
                    child: TextField(
                      controller: splitController,
                      cursorColor: AppColor.secondaryColor,
                      style: fontRegular.copyWith(
                          fontSize: 10.sp,
                          color: AppColor.textColor
                      ),
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: "10",
                        hintStyle: fontRegular.copyWith(
                            fontSize: 10.sp,
                            color: AppColor.textMildColor
                        ),),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 7.w,
                  vertical: 1.h,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.primaryColor, width: 1.2),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Center(
                  child: Text("Cancel",
                    style: fontRegular.copyWith(
                        color: AppColor.secondaryColor,
                        fontSize: 11.sp
                    ),),
                ),
              ),
              SizedBox(width: 5.w),
              Bounceable(
                onTap: (){
                  Navigator.pop(context);
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
