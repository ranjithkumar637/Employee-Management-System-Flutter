import 'package:elevens_organizer/providers/payment_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/styles.dart';
import '../widgets/snackbar.dart';

class AddAmountDialogBox extends StatefulWidget {
  final String paidPrice, totalPrice, team, matchId, teamId;
  final VoidCallback refresh;
  const AddAmountDialogBox(this.paidPrice, this.totalPrice, this.team, this.matchId, this.teamId, this.refresh, {Key? key}) : super(key: key);

  @override
  State<AddAmountDialogBox> createState() => _AddAmountDialogBoxState();
}

class _AddAmountDialogBoxState extends State<AddAmountDialogBox> {

  final TextEditingController totalAmountController = TextEditingController();
  final TextEditingController paidAmountController = TextEditingController();
  final TextEditingController balanceController = TextEditingController();
  bool invalidPaidAmount = false;

  calculateBalanceAmount(){
    int balance = int.parse(totalAmountController.text.toString()) - int.parse(paidAmountController.text.toString());
    if(balance < 0){
      Dialogs.snackbar("Enter a valid paid amount", context, isError: true);
    } else {
      balanceController.text = balance.toString();
    }
  }

  checkPaidGreaterThanTotalAmount(int paidAmount){
    int totalAmount = int.parse(widget.totalPrice.toString());
    if(paidAmount > totalAmount){
      setState(() {
        invalidPaidAmount = true;
      });
    } else {
      setState(() {
        invalidPaidAmount = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    totalAmountController.text = widget.totalPrice;
    paidAmountController.text = widget.paidPrice;
    calculateBalanceAmount();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 5.w),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(BuildContext context){
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Container(
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
            Text(widget.team,
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
                children: [
                  Row(
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
                                  controller: totalAmountController,
                                  readOnly: true,
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
                                    hintText: "Total amount",
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
                                child: TextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  controller: paidAmountController,
                                  cursorColor: AppColor.secondaryColor,
                                  style: fontRegular.copyWith(
                                      fontSize: 10.sp,
                                      color: AppColor.textColor
                                  ),
                                  onChanged: (value){
                                    checkPaidGreaterThanTotalAmount(int.parse(value.toString()));
                                  },
                                  keyboardType: TextInputType.phone,
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    border: InputBorder.none,
                                    hintText: "Paid amount",
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
                  !invalidPaidAmount
                      ? const SizedBox()
                      : Padding(
                    padding: EdgeInsets.only(
                        top: 1.h
                    ),
                    child: Text("Paid amount must be less than total amount",
                      style: fontRegular.copyWith(
                          fontSize: 9.sp,
                          color: AppColor.redColor
                      ),),
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
                  Row(
                    children: [
                      Text("Balance",
                        style: fontRegular.copyWith(
                            fontSize: 10.sp,
                            color: AppColor.textColor
                        ),),
                      const Spacer(),
                      InkWell(
                        onTap: (){
                          calculateBalanceAmount();
                        },
                        child: Text("Calculate Balance",
                          style: fontRegular.copyWith(
                              fontSize: 10.sp,
                              color: AppColor.secondaryColor,
                            decoration: TextDecoration.underline
                          ),),
                      ),

                    ],
                  ),
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
                      child: TextFormField(
                        controller: balanceController,
                        readOnly: true,
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
                          hintText: "Balance amount",
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
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 7.w,
                      vertical: 1.h,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.textColor, width: 1.2),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Center(
                      child: Text("Cancel",
                        style: fontRegular.copyWith(
                            color: AppColor.textColor,
                            fontSize: 11.sp
                        ),),
                    ),
                  ),
                ),
                invalidPaidAmount
                    ? const SizedBox()
                    : SizedBox(width: 5.w),
                invalidPaidAmount
                    ? const SizedBox()
                    : Bounceable(
                  onTap: (){
                    PaymentInfoProvider().paymentUpdate(widget.matchId, widget.teamId, paidAmountController.text.toString(), totalAmountController.text.toString())
                        .then((value) {
                      if(value.status == true){
                        Navigator.pop(context);
                        Navigator.pop(context);
                        widget.refresh();
                        Dialogs.snackbar(value.message.toString(), context, isError: false);
                      } else if(value.status == false){
                        Navigator.pop(context);
                        Dialogs.snackbar(value.message.toString(), context, isError: true);
                      } else {
                        Navigator.pop(context);
                        Dialogs.snackbar("Something Went Wrong. Please try again.", context, isError: true);
                      }
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
      ),
    );
  }

}
