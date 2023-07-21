import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import '../widgets/custom_button.dart';

class EnterOtpScreen extends StatefulWidget {
  final bool login, register;
  const EnterOtpScreen({Key? key, required this.login, required this.register}) : super(key: key);

  @override
  State<EnterOtpScreen> createState() => _EnterOtpScreenState();
}

class _EnterOtpScreenState extends State<EnterOtpScreen> {

  int _seconds = 120;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          _timer!.cancel();
        }
      });
    });
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5.w,
            ) + EdgeInsets.only(
              top: 7.h,
              bottom: 5.h
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap:(){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back, color: AppColor.textColor, size: 7.w,)),
                Text(widget.login ? "Enter your OTP" : "Verify your mobile number",
                style: fontSemiBold.copyWith(
                  color: AppColor.textColor,
                  fontSize: widget.login ? 16.sp : 14.sp
                ),),
                Icon(Icons.arrow_back, color: Colors.transparent, size: 7.w,),
              ],
            ),
          ),
          Center(
            child: SvgPicture.asset(Images.otpImage, width: 36.w,),
          ),
          SizedBox(height: 3.h),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
            ),
            child: Text("Please enter your the 4 digit code sent to 9925658895",
              textAlign: TextAlign.center,
              style: fontRegular.copyWith(
                  color: AppColor.textColor,
                  fontSize: 12.sp
              ),),
          ),
          SizedBox(height: 3.h),
          OtpTextField(
            keyboardType: TextInputType.number,
            showFieldAsBox: true,
            textStyle: fontMedium.copyWith(
              color: AppColor.textColor,
              fontSize: 14.sp
            ),
            showCursor: true,
            cursorColor: AppColor.textColor,
            numberOfFields: 4,
            fillColor: AppColor.lightColor,
            filled: true,
            borderColor: Colors.transparent,
            margin: EdgeInsets.symmetric(
              horizontal: 2.w
            ),
            focusedBorderColor: AppColor.primaryColor,
            enabledBorderColor: Colors.transparent,
            fieldWidth: 16.w,
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          ),
          SizedBox(height: 3.h),
          Text(
            "${formatTime(_seconds)} seconds",
            style: fontMedium.copyWith(
              color: AppColor.textColor,
                fontSize: 11.sp),
          ),
          SizedBox(height: 3.h),
          RichText(
            text: TextSpan(
                text: 'Didn\'t receive the code? ',
                style: fontRegular.copyWith(
                  color: AppColor.textColor,
                  fontSize: 11.sp,
                ),
                children: <TextSpan>[
                  TextSpan(text: ' Resend',
                      style: fontSemiBold.copyWith(
                        color: AppColor.textColor,
                        fontSize: 11.sp,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Navigator.pushNamed(context, 'register_screen');
                        }
                  )
                ]
            ),
          ),
          SizedBox(height: 5.h),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5.w,
            ),
            child: const CustomButton(AppColor.primaryColor, "Verify", AppColor.textColor),
          ),
        ],
      ),
    );
  }
}
