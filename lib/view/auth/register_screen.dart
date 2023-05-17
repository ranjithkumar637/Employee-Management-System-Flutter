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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  bool loading = false;
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.bgColor,
        body: Column(
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
                      Text("Create Account",
                        style: fontBold.copyWith(
                            fontSize: 20.sp,
                            color: AppColor.textColor
                        ),),
                      SizedBox(height: 1.h),
                      Text("Let's cricket together",
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
                  child: Text("Sign Up",
                    style: fontBold.copyWith(
                        fontSize: 20.sp,
                        color: AppColor.textColor
                    ),),
                ),
                Positioned(
                  left: 5.w,
                  top: 5.h,
                  child: GestureDetector(
                      onTap:(){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_rounded, color: AppColor.textColor, size: 7.w,)),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Expanded(
              child: Form(
                key: _formKey,
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Your Name",
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
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    border: InputBorder.none,
                                    hintText: "John Doe",
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
                            Row(
                              children: [
                                Text("Email",
                                  style: fontRegular.copyWith(
                                      fontSize: 10.sp,
                                      color: AppColor.textColor
                                  ),),
                                const Spacer(),
                                Text("(Optional)",
                                  style: fontRegular.copyWith(
                                      fontSize: 8.sp,
                                      color: AppColor.textMildColor
                                  ),),
                              ],
                            ),
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
                                  controller: emailController,
                                  cursorColor: AppColor.secondaryColor,
                                  style: fontRegular.copyWith(
                                      fontSize: 10.sp,
                                      color: AppColor.textColor
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    border: InputBorder.none,
                                    hintText: "johndoe@gmail.com",
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
                                        textInputAction: TextInputAction.next,
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
                                Text("Company Name",
                                  style: fontRegular.copyWith(
                                      fontSize: 10.sp,
                                      color: AppColor.textColor
                                  ),),
                                const Spacer(),
                                Text("(Optional)",
                                  style: fontRegular.copyWith(
                                      fontSize: 8.sp,
                                      color: AppColor.textMildColor
                                  ),),
                              ],
                            ),
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
                                  controller: companyNameController,
                                  cursorColor: AppColor.secondaryColor,
                                  style: fontRegular.copyWith(
                                      fontSize: 10.sp,
                                      color: AppColor.textColor
                                  ),
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    border: InputBorder.none,
                                    hintText: "Chennai Super Kings",
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
                      SizedBox(height: 5.h),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 2.h),
            loading
            ? const Center( child: CircularProgressIndicator(),)
                : Bounceable(
                onTap:(){
                  validate();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: const CustomButton(AppColor.primaryColor, "Sign Up", AppColor.textColor),
                )),
            SizedBox(height: 2.h),
            RichText(
              text: TextSpan(
                  text: 'Already have an account? ',
                  style: fontRegular.copyWith(
                    color: AppColor.textColor,
                    fontSize: 11.sp,
                  ),
                  children: <TextSpan>[
                    TextSpan(text: ' Log in',
                        style: fontMedium.copyWith(
                          color: AppColor.redColor,
                          fontSize: 11.sp,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pop(context);
                          }
                    )
                  ]
              ),
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  void validate() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      AuthProvider().register(nameController.text, emailController.text, mobileController.text, passwordController.text, companyNameController.text)
      .then((value) {
        if(value.status == true){
          setState(() {
            loading = false;
          });
          print("registered successfully");
          Dialogs.snackbar(value.message.toString(), context, isError: false);
          // Navigator.pushNamed(context, 'menu_screen');
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
