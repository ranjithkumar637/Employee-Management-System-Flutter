import 'package:elevens_organizer/providers/profile_provider.dart';
import 'package:elevens_organizer/view/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/team_provider.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import '../widgets/snackbar.dart';

class Profile extends StatefulWidget {
  final ProfileProvider ground;
  const Profile(this.ground, {Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final TextEditingController groundNameController = TextEditingController();
  final TextEditingController groundMobileController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();

  String date = "";
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String? location;

  String removeTime(DateTime dateTime) {
    DateFormat dateFormat = DateFormat('dd-MM-yyyy');
    String formattedDate = dateFormat.format(dateTime);

    return formattedDate;
  }

  getCityList(){
    Provider.of<TeamProvider>(context, listen: false).getCityList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCityList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.bgColor,
      child: Form(
        key: _formKey,
        child: Consumer<ProfileProvider>(
          builder: (context, profile, child) {
            groundNameController.text = profile.organizerDetails.groundName.toString();
            groundMobileController.text = profile.organizerDetails.groundContactNumber.toString();
            nameController.text = profile.organizerDetails.name.toString();
            mobileNumberController.text = profile.organizerDetails.mobile.toString();
            return Column(
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
                                    keyboardType: TextInputType.text,
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
                                    keyboardType: TextInputType.text,
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
                                    enabled: false,
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
                                        date,
                                        style: fontRegular.copyWith(
                                            color: AppColor.textColor,
                                            fontSize: 11.sp
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                        onTap: () async {
                                          final DateTime? picked = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1950),
                                            lastDate: DateTime(2100),
                                            builder: (context, child) {
                                              return Theme(
                                                data: Theme.of(context).copyWith(
                                                  useMaterial3: true,
                                                  colorScheme: const ColorScheme.light(
                                                    primary: AppColor.primaryColor,
                                                    onPrimary: AppColor.textColor,
                                                    onSurface: AppColor.textColor,
                                                  ),
                                                  textButtonTheme: TextButtonThemeData(
                                                    style: TextButton.styleFrom(
                                                      foregroundColor: AppColor.secondaryColor,
                                                    ),
                                                  ),
                                                ),
                                                child: child!,
                                              );
                                            },
                                          );

                                          if (picked != null) {
                                            setState(() {
                                              date = DateFormat("dd-MM-yyyy").format(picked);
                                            });
                                          }
                                        },
                                        child: SvgPicture.asset(Images.calendarIcon, color: AppColor.textColor, width: 5.5.w,)),
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
                              Consumer<TeamProvider>(
                                  builder: (context, team, child) {
                                    return Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 5.w,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColor.lightColor,
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      child: DropdownButton<String>(
                                        underline: const SizedBox(),
                                        isExpanded: true,
                                        value: location,
                                        style: fontRegular.copyWith(
                                            color: AppColor.textColor
                                        ),
                                        items: team.cityList.map((date) {
                                          return DropdownMenuItem<String>(
                                            value: date.cityName,
                                            child: Text(date.cityName.toString(),
                                              style: fontRegular.copyWith(
                                                  color: AppColor.textColor
                                              ),),
                                          );
                                        }).toList(),
                                        onChanged: (selectedDateId) {
                                          // print(selectedDateId);
                                          setState(() {
                                            location = selectedDateId;
                                          });
                                        },
                                      ),
                                    );
                                  }
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
                    vertical: 2.h,
                  ),
                  child: loading
                    ? const Center(child: CircularProgressIndicator(),)
                  : Bounceable(
                      onTap: (){
                        validate();
                      },
                      child: const CustomButton(AppColor.textColor, "Save Profile", AppColor.lightColor)),
                ),
              ],
            );
          }
        ),
      ),
    );
  }

  validate(){
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      ProfileProvider().updateProfile(
          groundNameController.text.toString(),
          groundMobileController.text.toString(),
          nameController.text.toString(),
          date == "" ? "" : date,
          location.toString() == "null" ? "" : location.toString())
      .then((value) {
        if(value.status == true){
          Dialogs.snackbar(value.message.toString(), context, isError: false);
          Navigator.pop(context);
          setState(() {
            loading = false;
          });
        } else if(value.status == false){
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

}
