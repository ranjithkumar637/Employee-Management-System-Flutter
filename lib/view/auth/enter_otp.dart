import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../providers/auth_provider.dart';
import '../../utils/colours.dart';
import '../../utils/connectivity_status.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/no_internet_view.dart';
import '../widgets/snackbar.dart';

class EnterOtpScreen extends StatefulWidget {
  final bool login, register;
  final String otp, userTempId, mobileNumber;
  const EnterOtpScreen(this.login, this.register, this.otp, this.userTempId, this.mobileNumber, {Key? key}) : super(key: key);

  @override
  State<EnterOtpScreen> createState() => _EnterOtpScreenState();
}

class _EnterOtpScreenState extends State<EnterOtpScreen> {

  int _seconds = 120;
  Timer? _timer;
  bool loading = false;
  bool enableButton = false;
  String otp = "";
  bool incomplete = true;
  String yourOtp = "";

  setOtp(String otp){
    setState(() {
      yourOtp = otp;
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    setOtp(widget.otp);
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          _timer!.cancel();
          onTimerEnd();
        }
      });
    });
  }

  onTimerEnd(){
    print('Timer Ended!');
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
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    if (connectionStatus == ConnectivityStatus.offline) {
      return const NoInternetView();
    }
    return WillPopScope(
      onWillPop: () {
        return openExitSheet();
      },
      child: Scaffold(
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
                  const SizedBox(),
                  Text(widget.login ? "Enter your OTP" : "Verify your mobile number",
                  style: fontSemiBold.copyWith(
                    color: AppColor.textColor,
                    fontSize: widget.login ? 16.sp : 14.sp
                  ),),
                  const SizedBox(),
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
              child: Text("Please enter the 4 digit code sent to ${widget.mobileNumber}",
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
              onSubmit: (value){
                setState((){
                  otp = value;
                });
                setState((){
                  incomplete = false;
                });
              },
              onCodeChanged: (value){
                setState((){
                  otp = value;
                });
                if(value.length < 4){
                  setState((){
                    incomplete = true;
                  });
                } else{
                  setState((){
                    incomplete = false;
                  });
                }
              },
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
                          color: _seconds > 0 ? AppColor.textMildColor : AppColor.textColor,
                          fontSize: 11.sp,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            if(_seconds > 0){

                            } else {
                              resendOtp(widget.userTempId);
                            }
                          }
                    )
                  ]
              ),
            ),
            SizedBox(height: 5.h),
            if(loading)...[
              const Center(
                child: CircularProgressIndicator(
                  color: AppColor.primaryColor,
                ),
              )
            ] else...[
              incomplete
                  ? Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.w,
                ),
                child: CustomButton(AppColor.hintColour.withOpacity(0.2), "Verify", AppColor.textColor),
              )
                  : Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.w,
                ),
                child: Bounceable(
                    onTap: () async {
                      SharedPreferences preferences = await SharedPreferences.getInstance();
                      String? userId = preferences.getString("user_temp_id");
                      if(widget.login){
                        verifyLogin(userId);
                      } else if(widget.register){
                        verifyRegister(userId);
                      }
                    },
                    child: const CustomButton(AppColor.primaryColor, "Verify", AppColor.textColor)),
              ),
            ]
          ],
        ),
      ),
    );
  }

  resendOtp(String id){
    if(widget.login){
      AuthProvider().resendOtpLogin(id)
          .then((value) {
        if(value.status == true){
          Dialogs.snackbar(value.message.toString(), context, isError: false);
          setOtp(value.otp.toString());
          setState(() {
            _seconds = 120;
          });
          startTimer();
        } else if(value.status == false){
          Dialogs.snackbar(value.message.toString(), context, isError: true);
        } else {
          Dialogs.snackbar(value.message.toString(), context, isError: true);
        }
      });
    }
    else if(widget.register){
      AuthProvider().resendOtpRegister(id)
          .then((value) {
        if(value.status == true){
          Dialogs.snackbar(value.message.toString(), context, isError: false);
          setOtp(value.otp.toString());
          setState(() {
            _seconds = 120;
          });
          startTimer();
        } else if(value.status == false){
          Dialogs.snackbar(value.message.toString(), context, isError: true);
        } else {
          Dialogs.snackbar(value.message.toString(), context, isError: true);
        }
      });
    }
  }


  verifyLogin(String? userId) async {
    if(otp == ""){
      Dialogs.snackbar("Enter the OTP", context, isError: true);
    } else{
      String? token = await FirebaseMessaging.instance.getToken();
      print(token);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("device_token" , token.toString());
      setState(() {
        loading = true;
      });
      AuthProvider().loginOtpVerify(userId.toString(), otp)
          .then((value) {
        if(value.status == true){
          Dialogs.snackbar(value.message.toString(), context, isError: false);
          Navigator.pushNamed(context, 'menu_screen');
          setState(() {
            loading = false;
          });
        } else if(value.status == false){
          Dialogs.snackbar(value.message.toString(), context, isError: true);
          setState(() {
            loading = false;
          });
        } else{
          Dialogs.snackbar("Something Went Wrong. Please try again.", context, isError: true);
          setState(() {
            loading = false;
          });
        }
      });
    }
  }

  verifyRegister(String? userId) async {
    if(otp == ""){
      Dialogs.snackbar("Enter the OTP", context, isError: true);
    } else{
      String? token = await FirebaseMessaging.instance.getToken();
      print(token);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("device_token" , token.toString());
      setState(() {
        loading = true;
      });
      AuthProvider().registerOtpVerify(userId.toString(), otp)
          .then((value) {
        if(value.status == true){
          print(value.token.toString());
          Dialogs.snackbar(value.message.toString(), context, isError: false);
          Navigator.pushNamed(context, 'menu_screen');
          setState(() {
            loading = false;
          });
        } else if(value.status == false){
          Dialogs.snackbar(value.message.toString(), context, isError: true);
          setState(() {
            loading = false;
          });
        } else{
          Dialogs.snackbar("Something Went Wrong. Please try again.", context, isError: true);
          setState(() {
            loading = false;
          });
        }
      });
    }
  }

  openExitSheet() {
    var platform = Theme.of(context).platform;
    return showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: false,
        builder: (BuildContext context) {
          return Padding(
            padding: platform == TargetPlatform.iOS
                ? EdgeInsets.symmetric(
                vertical: 5.h,
                horizontal: 2.w)
                : EdgeInsets.symmetric(
                vertical: 1.h,
                horizontal: 2.w),
            child: Container(
                height: 22.h,
                padding: EdgeInsets.symmetric(
                    vertical: 2.h,
                    horizontal: 5.w),
                decoration: BoxDecoration(
                  color: AppColor.lightColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Verify OTP and register yourself",
                      style: fontSemiBold.copyWith(
                          color: AppColor.textColor,
                          fontSize: 14.sp),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      "Would you still want to close the app?",
                      style: fontRegular.copyWith(
                          color: AppColor.textMildColor,
                          fontSize: 12.sp),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        //don't close the app
                        Expanded(
                          child: InkWell(
                            splashColor: Colors.grey,
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColor.secondaryColor, width: 0.5),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                      1.5.h),
                                  child: Text(
                                    "No",
                                    style: fontMedium.copyWith(
                                      color: AppColor.secondaryColor,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        //close the app
                        Expanded(
                          child: InkWell(
                            splashColor: Colors.grey,
                            onTap: () async {
                              exit(0);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColor.secondaryColor,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                      1.5.h),
                                  child: Text(
                                    "Yes",
                                    style: fontMedium.copyWith(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          );
        });
  }

}
