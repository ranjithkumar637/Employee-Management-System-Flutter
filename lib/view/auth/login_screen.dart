import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../providers/auth_provider.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/snackbar.dart';
import 'enter_otp.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return openExitSheet();
      },
      child: GestureDetector(
        onTap: (){
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          backgroundColor: AppColor.bgColor,
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset(Images.authCurveImg, width: 100.w,),
                      Positioned(
                        child: SvgPicture.asset(Images.loginTopImg, width: 100.w,),
                      ),
                      Positioned(
                        child: Column(
                          children: [
                            Text("Hello Again!",
                              style: fontBold.copyWith(
                                  fontSize: 20.sp,
                                  color: AppColor.textColor
                              ),),
                            SizedBox(height: 1.h),
                            Text("Welcome back. You’ve been missed!",
                              style: fontRegular.copyWith(
                                  fontSize: 11.sp,
                                  color: AppColor.textColor
                              ),),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 5.w,
                        bottom: 4.h,
                        child: Text("Login",
                          style: fontBold.copyWith(
                              fontSize: 20.sp,
                              color: AppColor.textColor
                          ),),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 5.w
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Mobile Number *",
                          style: fontRegular.copyWith(
                              fontSize: 10.sp,
                              color: AppColor.textColor
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
                              controller: mobileController,
                              autofillHints: const <String>[AutofillHints.telephoneNumberNational],
                              cursorColor: AppColor.secondaryColor,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter mobile number';
                                } else if (value.length < 10) {
                                  return 'Mobile Number must be 10 digits';
                                }
                                return null;
                              },
                              style: fontRegular.copyWith(
                                  fontSize: 10.sp,
                                  color: AppColor.textColor
                              ),
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.done,
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
                  SizedBox(height: 4.h),
                  loading
                      ? const Center( child: CircularProgressIndicator(),)
                      : Bounceable(
                      onTap:(){
                        validate();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: const CustomButton(AppColor.primaryColor, "Log in", AppColor.textColor),
                      )),
                  SizedBox(height: 3.h),
                  RichText(
                    text: TextSpan(
                        text: 'Don\'t have an account? ',
                        style: fontRegular.copyWith(
                          color: AppColor.textColor,
                          fontSize: 11.sp,
                        ),
                        children: <TextSpan>[
                          TextSpan(text: ' Sign Up',
                              style: fontMedium.copyWith(
                                color: AppColor.redColor,
                                fontSize: 11.sp,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(context, 'register_screen');
                                }
                          )
                        ]
                    ),
                  ),
                  SizedBox(height: 3.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void validate() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      AuthProvider().login(mobileController.text)
          .then((value) async {
        if(value.status == true){
          setState(() {
            loading = false;
          });
          Dialogs.snackbar(value.message.toString(), context, isError: false);
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setString(
              "user_temp_id", value.loginData!.userId.toString());
          preferences.setString(
              "mobile", mobileController.text);
          preferences.setBool("isLoginScreen", true);
          if(mounted){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return EnterOtpScreen(true, false, value.loginData!.otp.toString(),
                    value.loginData!.userId.toString(), mobileController.text);
              }),
            );
          }
        } else if(value.status == false){
          print(value.message.toString());
          Dialogs.snackbar(value.message.toString(), context, isError: true);
          setState(() {
            loading = false;
          });
        } else{
          setState(() {
            loading = false;
          });
        }
      });
    }
  }

  openExitSheet() {
    var platform = Theme
        .of(context)
        .platform;
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
                height: 20.h,
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
                      "Are you sure?",
                      style: fontMedium.copyWith(
                          color: AppColor.textColor,
                          fontSize: 14.sp),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      "Would you like to close the app?",
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
