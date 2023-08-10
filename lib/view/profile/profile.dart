import 'package:elevens_organizer/providers/profile_provider.dart';
import 'package:elevens_organizer/view/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/team_provider.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import '../my_team/city_list_dialog.dart';
import '../my_team/create_team.dart';
import '../my_team/state_list_dialog.dart';
import '../widgets/snackbar.dart';
import 'location_data.dart';

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
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController orgPinCodeController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  String date = "";
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String? location;
  bool editCity = false, editState = false;

  String removeTime(DateTime dateTime) {
    DateFormat dateFormat = DateFormat('dd-MM-yyyy');
    String formattedDate = dateFormat.format(dateTime);

    return formattedDate;
  }

  getCityList(){
    Provider.of<TeamProvider>(context, listen: false).getCityList();
  }

  void openCitySheet(String stateBasedCityId) {
    Provider.of<TeamProvider>(context, listen: false).getStateBasedCityList(stateBasedCityId);
    showDialog(context: context,
        builder: (BuildContext context){
          return const CityListDialog(fromOrganizer: true);
        }
    );
  }

  getStateList(){
    Provider.of<TeamProvider>(context, listen: false).getStateList();
  }

  void openStateSheet() {
    showDialog(context: context,
        builder: (BuildContext context){
          return const StateListDialog(fromOrganizer: true);
        }
    );
  }

  getData(){
    final profile = Provider.of<ProfileProvider>(context, listen: false);
    groundNameController.text = profile.organizerDetails.groundName.toString();
    groundMobileController.text = profile.organizerDetails.groundContactNumber.toString();
    nameController.text = profile.organizerDetails.name.toString();
    mobileNumberController.text = profile.organizerDetails.mobile.toString();
    companyNameController.text = profile.organizerDetails.companyName.toString();
    orgPinCodeController.text = profile.organizerDetails.orgPincode.toString();
    date = profile.getDob();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCityList();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Container(
        color: AppColor.bgColor,
        child: Form(
          key: _formKey,
          child: Consumer<ProfileProvider>(
            builder: (context, profile, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                      readOnly: groundNameController.text.isEmpty ? false : true,
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
                                Text("Ground Mobile Number *",
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
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(10),
                                      ],
                                      controller: groundMobileController,
                                      readOnly: groundMobileController.text.isEmpty ? false : true,
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
                          //company name
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Company Name *",
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
                                      controller: companyNameController,
                                      cursorColor: AppColor.secondaryColor,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Enter company name';
                                        }
                                        return null;
                                      },
                                      style: fontRegular.copyWith(
                                          fontSize: 10.sp,
                                          color: AppColor.textColor
                                      ),
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.done,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        border: InputBorder.none,
                                        hintText: "Ex: ABC Organizers",
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
                          LocationData(widget.ground.groundDetails, profile.organizerDetails, true),
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
                                      readOnly: true,
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
                                      readOnly: true,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(10),
                                      ],
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
                                          date == "" ? "Select Date" : date,
                                          style: fontRegular.copyWith(
                                              color: date == "" ? AppColor.textMildColor : AppColor.textColor,
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
                                                date = DateFormat("yyyy-MM-dd").format(picked);
                                              });
                                              print(date);
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
                                const FieldHeading("State"),
                                SizedBox(height:1.h),
                                Consumer<TeamProvider>(
                                    builder: (context, team, child) {
                                      return InkWell(
                                        onTap: (){
                                          getStateList();
                                          openStateSheet();
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.w,
                                              vertical: 1.4.h
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColor.lightColor,
                                            borderRadius: BorderRadius.circular(30.0),
                                          ),
                                          child: profile.organizerDetails.state.toString() != "" && !editState
                                              ? Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(profile.organizerDetails.state.toString(),
                                                      style: fontRegular.copyWith(
                                                          color: AppColor.textColor
                                                      ),),
                                                  ),
                                                  profile.organizerDetails.state.toString() != ""
                                                      ? InkWell(
                                                      onTap: (){
                                                        setState(() {
                                                          editState = true;
                                                        });
                                                      },
                                                      child: Icon(Icons.edit, color: AppColor.secondaryColor, size: 4.w,))
                                                      : const SizedBox()
                                                ],
                                              )
                                          : Row(
                                            children: [
                                              Text(team.state,
                                                style: fontRegular.copyWith(
                                                    color: AppColor.textColor
                                                ),),
                                              const Spacer(),
                                              const Icon(Icons.arrow_drop_down_sharp, color: AppColor.textColor,)
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                ),
                                SizedBox(height: 2.h),
                                const FieldHeading("City"),
                                SizedBox(height:1.h),
                                Consumer<TeamProvider>(
                                    builder: (context, team, child) {
                                      return InkWell(
                                        onTap: (){
                                          openCitySheet(team.stateId);
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.w,
                                              vertical: 1.4.h
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColor.lightColor,
                                            borderRadius: BorderRadius.circular(30.0),
                                          ),
                                          child: profile.organizerDetails.city.toString() != "" && !editCity
                                          ? Row(
                                            children: [
                                              Expanded(
                                                child: Text(profile.organizerDetails.city.toString(),
                                                  style: fontRegular.copyWith(
                                                      color: AppColor.textColor
                                                  ),),
                                              ),
                                              profile.organizerDetails.city.toString() != ""
                                                  ? InkWell(
                                                  onTap: (){
                                                    setState(() {
                                                      editCity = true;
                                                    });
                                                  },
                                                  child: Icon(Icons.edit, color: AppColor.secondaryColor, size: 4.w,))
                                                  : const SizedBox()
                                            ],
                                          )
                                          : Row(
                                            children: [
                                              Text(team.stateBasedCity,
                                                style: fontRegular.copyWith(
                                                    color: AppColor.textColor
                                                ),),
                                              const Spacer(),
                                              const Icon(Icons.arrow_drop_down_sharp, color: AppColor.textColor,)
                                            ],
                                          ),
                                        ),
                                      );
                                    }
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
                                Text("Pin Code *",
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
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(6),
                                      ],
                                      controller: orgPinCodeController,
                                      cursorColor: AppColor.secondaryColor,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Enter pin code';
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
                                        hintText: "Ex: 600001",
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
      ),
    );
  }

  validate(){
    String address = Provider.of<ProfileProvider>(context, listen: false).address;
    String houseNo = Provider.of<ProfileProvider>(context, listen: false).houseNo;
    String pinCode = Provider.of<ProfileProvider>(context, listen: false).pinCode;
    String street = Provider.of<ProfileProvider>(context, listen: false).street;
    String latitude = Provider.of<ProfileProvider>(context, listen: false).latitude;
    String longitude = Provider.of<ProfileProvider>(context, listen: false).longitude;

    String cityId = Provider.of<TeamProvider>(context, listen: false).stateBasedCityId;
    String stateId = Provider.of<TeamProvider>(context, listen: false).stateId;

    String groundCityId = Provider.of<ProfileProvider>(context, listen: false).cityIdGround;
    String groundStateId = Provider.of<ProfileProvider>(context, listen: false).stateIdGround;

    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      ProfileProvider().updateProfile(
          groundNameController.text.toString(),
          groundMobileController.text.toString(),
          nameController.text.toString(),
          date == "" ? "" : date,
          location.toString() == "null" ? "" : location.toString(),
          companyNameController.text, latitude, longitude, address, houseNo, pinCode, street, cityId, stateId, groundCityId, groundStateId, orgPinCodeController.text)
      .then((value) {
        if(value.status == true){
          Dialogs.snackbar("Profile updated successfully", context, isError: false);
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
    } else{
      _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

}
