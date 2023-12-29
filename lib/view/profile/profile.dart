import 'package:elevens_organizer/providers/profile_provider.dart';
import 'package:elevens_organizer/view/widgets/custom_button.dart';
import 'package:email_validator/email_validator.dart';
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
import '../my_team/state_list_dialog.dart';
import '../my_team/team_detail_data.dart';
import '../widgets/snackbar.dart';
import 'location_data.dart';

class Profile extends StatefulWidget {
  final ProfileProvider ground;
  final List<String> profilePath;
  const Profile(this.ground, this.profilePath, {Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  final TextEditingController nameController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController orgPinCodeController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController emailController = TextEditingController();

  bool isValid = true;
  bool hasValue = false;

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

  void openCitySheet(String stateBasedCityId, bool value) {
    Provider.of<TeamProvider>(context, listen: false).getStateBasedCityList(stateBasedCityId);
    showDialog(context: context,
        builder: (BuildContext context){
          return CityListDialog(fromOrganizer: true, orgCity: value);
        }
    );
  }

  getStateList(){
    Provider.of<TeamProvider>(context, listen: false).getStateList();
  }

  void openStateSheet(bool value) {
    showDialog(context: context,
        builder: (BuildContext context){
          return StateListDialog(fromOrganizer: true, orgCity : value);
        }
    );
  }

  String groundName = "", groundMobile = "", companyName = "";

  getData(){
    final profile = Provider.of<ProfileProvider>(context, listen: false);
    nameController.text = profile.organizerDetails.name.toString();
    mobileNumberController.text = profile.organizerDetails.mobile.toString();
    companyNameController.text = profile.organizerDetails.companyName.toString();
    companyName = profile.organizerDetails.companyName.toString();
    orgPinCodeController.text = profile.organizerDetails.orgPincode.toString();
    emailController.text = profile.organizerDetails.email.toString();
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
                            // SizedBox(height: 2.h),
                            // LocationData(widget.ground.groundDetails, profile.organizerDetails, true),
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
                                      color: AppColor.textFieldBg,
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
                                          hintText: "Enter your name",
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
                                      color: AppColor.textFieldBg,
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    child: Center(
                                      child: TextFormField(
                                        readOnly: true,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(10),
                                          FilteringTextInputFormatter.digitsOnly
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
                                          hintText: "Enter mobile number",
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
                            //organizer email
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
                                            fontSize: 11.sp,
                                            color: AppColor.textMildColor
                                        ),),
                                      const Spacer(),
                                      Text("(Optional)",
                                        style: fontRegular.copyWith(
                                            fontSize: 9.sp,
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
                                        onChanged: (value) {
                                          if (value.isEmpty) {
                                            setState(() {
                                              hasValue = false;
                                              isValid = false;
                                            });
                                          } else {
                                            setState(() {
                                              hasValue = true;
                                              isValid =
                                                  EmailValidator.validate(value);
                                            });
                                          }
                                        },
                                        keyboardType: TextInputType.emailAddress,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          border: InputBorder.none,
                                          hintText: "Enter email address",
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
                                          hintText: "Enter company name",
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
                                      vertical: 2.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColor.lightColor,
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            date == "" ? "Select Date of birth" : date,
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
                                                initialEntryMode: DatePickerEntryMode.calendarOnly,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(1950),
                                                lastDate: DateTime.now(),
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
                            profile.organizerDetails.state.toString() != ""
                                ? Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.w
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const FieldHeading("State *", false),
                                  SizedBox(height:1.h),
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5.w,
                                        vertical: 2.5.h
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColor.lightColor,
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    child: Text(profile.organizerDetails.state.toString(),
                                      style: fontRegular.copyWith(
                                          color: AppColor.textColor
                                      ),),
                                  ),
                                  SizedBox(height: 2.h),
                                  const FieldHeading("City *", false),
                                  SizedBox(height:1.h),
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5.w,
                                        vertical: 2.5.h
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColor.lightColor,
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    child: Text(profile.organizerDetails.city.toString(),
                                      style: fontRegular.copyWith(
                                          color: AppColor.textColor
                                      ),),
                                  ),
                                ],
                              ),
                            )
                                : Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.w
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const FieldHeading("State *", false),
                                  SizedBox(height:1.h),
                                  Consumer<TeamProvider>(
                                      builder: (context, team, child) {
                                        return InkWell(
                                          onTap: (){
                                            getStateList();
                                            openStateSheet(true);
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5.w,
                                                vertical: 2.5.h
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColor.lightColor,
                                              borderRadius: BorderRadius.circular(30.0),
                                            ),
                                            child: Row(
                                              children: [
                                                Text(team.organizerState == "" ? "Choose state" : team.organizerState,
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
                                  const FieldHeading("City *", false),
                                  SizedBox(height:1.h),
                                  Consumer<TeamProvider>(
                                      builder: (context, team, child) {
                                        return InkWell(
                                          onTap: (){
                                            if(team.organizerStateId == ""){
                                              Dialogs.snackbar("Choose state first", context, isError: true);
                                            } else {
                                              openCitySheet(team.organizerStateId, true);
                                            }
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5.w,
                                                vertical: 2.5.h
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColor.lightColor,
                                              borderRadius: BorderRadius.circular(30.0),
                                            ),
                                            child: Row(
                                              children: [
                                                Text(team.organizerStateBasedCity == "" ? "Choose city" : team.organizerStateBasedCity,
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
                                        readOnly: orgPinCodeController.text.isEmpty ? false : true,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(6),
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        controller: orgPinCodeController,
                                        cursorColor: AppColor.secondaryColor,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Enter pin code';
                                          } else if(value.length < 6){
                                            return 'Pin code must contain 6 digits';
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
                                          hintText: "Enter pin code",
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
                              child: loading
                                  ? const Center(child: CircularProgressIndicator(),)
                                  : Bounceable(
                                  onTap: (){
                                    validate();
                                  },
                                  child: const CustomButton(AppColor.textColor, "Save Profile", AppColor.lightColor)),
                            ),
                          ],
                        ),
                      ),
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
    final profile = Provider.of<ProfileProvider>(context, listen: false);
    String address = "", houseNo = "", pinCode = "", street = "", latitude = "", longitude = "";
    String cityIdG = "", stateIdG = "";

    //profile
    String cityId = Provider.of<TeamProvider>(context, listen: false).organizerStateBasedCityId;
    String stateId = Provider.of<TeamProvider>(context, listen: false).organizerStateId;

    if(cityId == "" && stateId == ""){
      cityId = profile.organizerDetails.cityId.toString();
      stateId = profile.organizerDetails.stateId.toString();
    }

    if(orgPinCodeController.text.isEmpty){
      Dialogs.snackbar("Enter your pin code", context, isError: true);
    }
    else if(cityId == "" || stateId == ""){
      Dialogs.snackbar("Select your state and city", context, isError: true);
    }
    else if(profile.groundAddress == ""){
      address = Provider.of<ProfileProvider>(context, listen: false).address;
      houseNo = Provider.of<ProfileProvider>(context, listen: false).houseNo;
      pinCode = Provider.of<ProfileProvider>(context, listen: false).pinCode;
      street = Provider.of<ProfileProvider>(context, listen: false).street;
      latitude = Provider.of<ProfileProvider>(context, listen: false).latitude;
      longitude = Provider.of<ProfileProvider>(context, listen: false).longitude;
    }
    else {
      address = Provider.of<ProfileProvider>(context, listen: false).groundAddress;
      houseNo = Provider.of<ProfileProvider>(context, listen: false).groundHouseNo;
      pinCode = Provider.of<ProfileProvider>(context, listen: false).groundPinCode;
      street = Provider.of<ProfileProvider>(context, listen: false).groundStreet;
      latitude = Provider.of<ProfileProvider>(context, listen: false).groundLatitude;
      longitude = Provider.of<ProfileProvider>(context, listen: false).groundLongitude;
    }


    //ground
    if(profile.cityIdGround == "" && profile.stateIdGround == ""){
      cityIdG = Provider.of<ProfileProvider>(context, listen: false).cityId;
      stateIdG = Provider.of<ProfileProvider>(context, listen: false).stateId;
    } else {
      cityIdG = Provider.of<ProfileProvider>(context, listen: false).cityIdGround;
      stateIdG = Provider.of<ProfileProvider>(context, listen: false).stateIdGround;
    }
    print("organizer cityid $cityId stateId $stateId");
    if (_formKey.currentState!.validate()) {
      if(hasValue && !isValid){
        setState(() {
          loading = false;
        });
        Dialogs.snackbar("Enter a valid email address", context, isError: true);
      } else {
        setState(() {
          loading = true;
        });
        ProfileProvider().updateProfile(
            nameController.text.toString(),
            date == "" ? "" : date,
            location.toString() == "null" ? "" : location.toString(),
            companyNameController.text, latitude, longitude, address, houseNo,
            pinCode, street, cityId, stateId, cityIdG, stateIdG, orgPinCodeController.text, widget.profilePath, emailController.text.toString())
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
      }
    }
  }

}
