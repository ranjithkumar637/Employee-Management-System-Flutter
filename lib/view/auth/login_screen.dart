import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../providers/auth_provider.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/snackbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible = false;
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Text("Mobile Number",
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
                          cursorColor: AppColor.secondaryColor,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
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
              SizedBox(height: 2.h),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 5.w
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Password",
                      style: fontRegular.copyWith(
                          fontSize: 10.sp,
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
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: passwordController,
                                obscureText: !passwordVisible,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                cursorColor: AppColor.secondaryColor,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter password';
                                  }
                                  return null;
                                },
                                style: fontRegular.copyWith(
                                    fontSize: 10.sp,
                                    color: AppColor.textColor
                                ),
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none,
                                  hintText: "Opklnm@123",
                                  hintStyle: fontRegular.copyWith(
                                      fontSize: 10.sp,
                                      color: AppColor.textMildColor
                                  ),),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                passwordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                size: 5.w,
                                color: AppColor.textColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  passwordVisible = !passwordVisible;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 3.h),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, "forgot_password");
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                    ),
                    child: Text("Forgot Password?",
                      style: fontMedium.copyWith(
                          fontSize: 10.sp,
                          color: AppColor.redColor
                      ),),
                  ),
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
    );
  }

  void validate() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      AuthProvider().login(mobileController.text, passwordController.text)
          .then((value) {
        if(value.status == true){
          setState(() {
            loading = false;
          });
          print(value.message.toString());
          Navigator.pushNamed(context, 'menu_screen');
          Dialogs.snackbar(value.message.toString(), context, isError: false);
        } else if(value.status == false){
          print(value.message.toString());
          Dialogs.snackbar(value.message.toString(), context, isError: true);
          setState(() {
            loading = false;
          });
        }
      });
    }
  }
}
