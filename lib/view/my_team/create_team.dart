import 'dart:io';

import 'package:elevens_organizer/view/my_team/state_list_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/team_provider.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_dialog_box.dart';
import '../widgets/snackbar.dart';
import 'captain_list_dialog.dart';
import 'city_list_dialog.dart';
import 'custom_dialog_box.dart';

class CreateTeam extends StatefulWidget {
  const CreateTeam({Key? key}) : super(key: key);

  @override
  State<CreateTeam> createState() => _CreateTeamState();
}

class _CreateTeamState extends State<CreateTeam> {

  bool loading = false;
  //team
  final TextEditingController teamNameController = TextEditingController();
  final TextEditingController teamMobileController = TextEditingController();
  final TextEditingController teamSecMobileController = TextEditingController();

  //captain
  final TextEditingController capNameController = TextEditingController();
  final TextEditingController capMobileController = TextEditingController();
  final TextEditingController capSecMobileController = TextEditingController();

  //vice-captain
  final TextEditingController vcNameController = TextEditingController();
  final TextEditingController vcMobileController = TextEditingController();
  final TextEditingController vcSecMobileController = TextEditingController();

  //admin
  final TextEditingController adminNameController = TextEditingController();
  final TextEditingController adminMobileController = TextEditingController();
  final TextEditingController adminSecMobileController = TextEditingController();

  //payment
  final TextEditingController upiController = TextEditingController();
  String? captainCity, viceCaptainCity, adminCity, captainId;
  String? adminState, adminStateId;
  int i = 0;
  FilePickerResult? files;
  List<PlatformFile> multipleFiles = [];
  List<String> qrcode = [];
  List<String> teamLogo = [];

  final _formKey = GlobalKey<FormState>();

  pickFile() async {
    setState(() {
      qrcode = [];
    });
    var files = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (files == null) return;
    setState(() {
      multipleFiles =
          files.files.map((file) => file).cast<PlatformFile>().toList();
      for (var i = 0; i < multipleFiles.length; i++) {

        qrcode.add(multipleFiles[i].path!);
      }
    });
  }

  File? imageFile;

  openCameraStart() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        teamLogo.add(pickedFile.path);
      });
    }
  }

  openGalleryStart() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        teamLogo.add(pickedFile.path);
      });
    }
  }

  void chooseTeamLogo() {
    showDialog(context: context,
        builder: (BuildContext context){
          return FilePickDialog(
              camera : openCameraStart,
              gallery: openGalleryStart,
          );
        }
    );
  }

  getCaptainList(){
    Provider.of<TeamProvider>(context, listen: false).getCaptainList();
  }

  getStateList(){
    Provider.of<TeamProvider>(context, listen: false).getStateList();
  }

  getCityList(){
    Provider.of<TeamProvider>(context, listen: false).getCityList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCityList();
    getCaptainList();
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
      child: Scaffold(
        backgroundColor: AppColor.bgColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 32.h,
                    child: ClipPath(
                      clipper: ProsteBezierCurve(
                        position: ClipPosition.bottom,
                        list: [
                          BezierCurveSection(
                            start: Offset(0, 22.h),
                            top: Offset(MediaQuery.of(context).size.width / 2, 30.h),
                            end: Offset(MediaQuery.of(context).size.width, 22.h),
                          ),
                        ],
                      ),
                      child: Image.asset(Images.pitchImage, fit: BoxFit.cover,),
                    ),
                  ),
                  Positioned(
                    child: SizedBox(
                      width: double.infinity,
                      height: 32.h,
                      child: ClipPath(
                        clipper: ProsteBezierCurve(
                          position: ClipPosition.bottom,
                          list: [
                            BezierCurveSection(
                              start: Offset(0, 22.h),
                              top: Offset(MediaQuery.of(context).size.width / 2, 30.h),
                              end: Offset(MediaQuery.of(context).size.width, 22.h),
                            ),
                          ],
                        ),
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xff333334),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 5.h,
                    left: 5.w,
                    right: 5.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap:(){
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back, color: AppColor.lightColor, size: 7.w,)),
                        Text("Create Team",
                          style: fontMedium.copyWith(
                              fontSize: 16.sp,
                              color: AppColor.lightColor
                          ),),
                        SizedBox(width: 7.w,),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 12.h,
                    child: Stack(
                      children: [
                        imageFile != null
                            ? Container(
                          height: 15.h,
                          width: 30.w,
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColor.imageBorderColor, width: 2),
                              shape: BoxShape.circle,
                              color: Colors.white,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(imageFile!))
                          ),
                        ) : Container(
                            height: 15.h,
                            width: 30.w,
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColor.imageBorderColor, width: 2),
                                shape: BoxShape.circle,
                                color: Colors.white,
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(Images.createTeamBg))
                            )),
                        Positioned(
                          bottom: 0.0,
                          right: 0.0,
                          child: InkWell(
                            onTap: (){
                              chooseTeamLogo();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 2.w,
                                vertical: 1.h,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.secondaryColor,
                                border: Border.all(color: AppColor.imageBorderColor, width: 1),
                              ),
                              child: Icon(Icons.camera_alt_outlined, color: AppColor.lightColor, size: 5.w,),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //team
                      SizedBox(
                        width: double.infinity,
                        child: Theme(
                          data: Theme.of(context).copyWith(
                              dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            initiallyExpanded: true,
                            title: Text(
                              "Team Details",
                              style: fontMedium.copyWith(
                                  fontSize: 12.sp,
                                  color: AppColor.textColor),
                            ),
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.w
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const FieldHeading("Team Name *"),
                                    SizedBox(height:1.h),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 5.w,
                                        vertical: 1.2.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColor.lightColor,
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      child: Center(
                                        child: TextFormField(
                                          controller: teamNameController,
                                          cursorColor: AppColor.secondaryColor,
                                          style: fontRegular.copyWith(
                                              fontSize: 10.sp,
                                              color: AppColor.textColor
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Enter team name';
                                            }
                                            return null;
                                          },
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            border: InputBorder.none,
                                            hintText: "CSK",
                                            hintStyle: fontRegular.copyWith(
                                                fontSize: 10.sp,
                                                color: AppColor.textMildColor
                                            ),),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height:2.h),
                                    const FieldHeading("Team Mobile *"),
                                    SizedBox(height:1.h),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 5.w,
                                        vertical: 1.2.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColor.lightColor,
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      child: Center(
                                        child: TextFormField(
                                          controller: teamMobileController,
                                          cursorColor: AppColor.secondaryColor,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(10),
                                          ],
                                          style: fontRegular.copyWith(
                                              fontSize: 10.sp,
                                              color: AppColor.textColor
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Enter team mobile number';
                                            } else if (value.length < 10) {
                                              return 'Mobile Number must be 10 digits';
                                            }
                                            return null;
                                          },
                                          keyboardType: TextInputType.phone,
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            border: InputBorder.none,
                                            hintText: "9999988888",
                                            hintStyle: fontRegular.copyWith(
                                                fontSize: 10.sp,
                                                color: AppColor.textMildColor
                                            ),),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height:2.h),
                                    const FieldHeading("Secondary Number"),
                                    SizedBox(height:1.h),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 5.w,
                                        vertical: 1.2.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColor.lightColor,
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      child: Center(
                                        child: TextFormField(
                                          controller: teamSecMobileController,
                                          cursorColor: AppColor.secondaryColor,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(10),
                                          ],
                                          style: fontRegular.copyWith(
                                              fontSize: 10.sp,
                                              color: AppColor.textColor
                                          ),
                                          keyboardType: TextInputType.phone,
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            border: InputBorder.none,
                                            hintText: "9999988888",
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
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: const Divider(thickness: 1.0,),
                      ),
                      //captain
                      SizedBox(
                        width: double.infinity,
                        child: Theme(
                          data: Theme.of(context).copyWith(
                              dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            initiallyExpanded: true,
                            title: Text(
                              "Team Captain Details",
                              style: fontMedium.copyWith(
                                  fontSize: 12.sp,
                                  color: AppColor.textColor),
                            ),
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.w
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const FieldHeading("Name *"),
                                    SizedBox(height:1.h),
                                    Consumer<TeamProvider>(
                                        builder: (context, team, child) {
                                          return InkWell(
                                            onTap: (){
                                              showDialog(context: context,
                                                  builder: (BuildContext context){
                                                    return const CaptainListDialog();
                                                  }
                                              );
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 5.w,
                                                vertical: 1.8.h,
                                              ),
                                              decoration: BoxDecoration(
                                                color: AppColor.lightColor,
                                                borderRadius: BorderRadius.circular(30.0),
                                              ),
                                              child: Row(
                                                children: [
                                                  Text(team.captainName == "" ? "Select Captain" : team.captainName,
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
                                    SizedBox(height:2.h),
                                    const FieldHeading("Mobile Number *"),
                                    SizedBox(height:1.h),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 5.w,
                                        vertical: 1.2.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColor.lightColor,
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      child: Center(
                                        child: TextFormField(
                                          controller: capMobileController,
                                          cursorColor: AppColor.secondaryColor,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(10),
                                          ],
                                          style: fontRegular.copyWith(
                                              fontSize: 10.sp,
                                              color: AppColor.textColor
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Enter captain mobile number';
                                            } else if (value.length < 10) {
                                              return 'Mobile Number must be 10 digits';
                                            }
                                            return null;
                                          },
                                          keyboardType: TextInputType.phone,
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            border: InputBorder.none,
                                            hintText: "9999988888",
                                            hintStyle: fontRegular.copyWith(
                                                fontSize: 10.sp,
                                                color: AppColor.textMildColor
                                            ),),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height:2.h),
                                    const FieldHeading("Secondary Number"),
                                    SizedBox(height:1.h),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 5.w,
                                        vertical: 1.2.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColor.lightColor,
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      child: Center(
                                        child: TextFormField(
                                          controller: capSecMobileController,
                                          cursorColor: AppColor.secondaryColor,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(10),
                                          ],
                                          style: fontRegular.copyWith(
                                              fontSize: 10.sp,
                                              color: AppColor.textColor
                                          ),
                                          keyboardType: TextInputType.phone,
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            border: InputBorder.none,
                                            hintText: "9999988888",
                                            hintStyle: fontRegular.copyWith(
                                                fontSize: 10.sp,
                                                color: AppColor.textMildColor
                                            ),),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    // const FieldHeading("Location *"),
                                    // SizedBox(height:1.h),
                                    // Consumer<TeamProvider>(
                                    //   builder: (context, team, child) {
                                    //     return Container(
                                    //       width: double.infinity,
                                    //       padding: EdgeInsets.symmetric(
                                    //         horizontal: 5.w,
                                    //       ),
                                    //       decoration: BoxDecoration(
                                    //         color: AppColor.lightColor,
                                    //         borderRadius: BorderRadius.circular(30.0),
                                    //       ),
                                    //       child: DropdownButton<String>(
                                    //         underline: const SizedBox(),
                                    //         isExpanded: true,
                                    //         value: captainCity,
                                    //         style: fontRegular.copyWith(
                                    //           color: AppColor.textColor
                                    //         ),
                                    //         items: team.cityList.map((date) {
                                    //           return DropdownMenuItem<String>(
                                    //             value: date.cityName,
                                    //             child: Text(date.cityName.toString(),
                                    //             style: fontRegular.copyWith(
                                    //               color: AppColor.textColor
                                    //             ),),
                                    //           );
                                    //         }).toList(),
                                    //         onChanged: (selectedDateId) {
                                    //           // print(selectedDateId);
                                    //           setState(() {
                                    //             captainCity = selectedDateId;
                                    //           });
                                    //         },
                                    //       ),
                                    //     );
                                    //   }
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: const Divider(thickness: 1.0,),
                      ),
                      //vice captain
                      SizedBox(
                        width: double.infinity,
                        child: Theme(
                          data: Theme.of(context).copyWith(
                              dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            initiallyExpanded: true,
                            title: Text(
                              "Team Vice Captain Details",
                              style: fontMedium.copyWith(
                                  fontSize: 12.sp,
                                  color: AppColor.textColor),
                            ),
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.w
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const FieldHeading("Name *"),
                                    SizedBox(height:1.h),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 5.w,
                                        vertical: 1.2.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColor.lightColor,
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      child: Center(
                                        child: TextFormField(
                                          controller: vcNameController,
                                          cursorColor: AppColor.secondaryColor,
                                          style: fontRegular.copyWith(
                                              fontSize: 10.sp,
                                              color: AppColor.textColor
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Enter vice captain name';
                                            }
                                            return null;
                                          },
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            border: InputBorder.none,
                                            hintText: "Virat Kohli",
                                            hintStyle: fontRegular.copyWith(
                                                fontSize: 10.sp,
                                                color: AppColor.textMildColor
                                            ),),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height:2.h),
                                    const FieldHeading("Mobile Number *"),
                                    SizedBox(height:1.h),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 5.w,
                                        vertical: 1.2.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColor.lightColor,
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      child: Center(
                                        child: TextFormField(
                                          controller: vcMobileController,
                                          cursorColor: AppColor.secondaryColor,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(10),
                                          ],
                                          style: fontRegular.copyWith(
                                              fontSize: 10.sp,
                                              color: AppColor.textColor
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Enter vice captain mobile number';
                                            } else if (value.length < 10) {
                                              return 'Mobile Number must be 10 digits';
                                            }
                                            return null;
                                          },
                                          keyboardType: TextInputType.phone,
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            border: InputBorder.none,
                                            hintText: "9999988888",
                                            hintStyle: fontRegular.copyWith(
                                                fontSize: 10.sp,
                                                color: AppColor.textMildColor
                                            ),),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height:2.h),
                                    const FieldHeading("Secondary Number"),
                                    SizedBox(height:1.h),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 5.w,
                                        vertical: 1.2.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColor.lightColor,
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      child: Center(
                                        child: TextFormField(
                                          controller: vcSecMobileController,
                                          cursorColor: AppColor.secondaryColor,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(10),
                                          ],
                                          style: fontRegular.copyWith(
                                              fontSize: 10.sp,
                                              color: AppColor.textColor
                                          ),
                                          keyboardType: TextInputType.phone,
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            border: InputBorder.none,
                                            hintText: "9999988888",
                                            hintStyle: fontRegular.copyWith(
                                                fontSize: 10.sp,
                                                color: AppColor.textMildColor
                                            ),),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    // const FieldHeading("Location *"),
                                    // SizedBox(height:1.h),
                                    // Consumer<TeamProvider>(
                                    //     builder: (context, team, child) {
                                    //       return Container(
                                    //         width: double.infinity,
                                    //         padding: EdgeInsets.symmetric(
                                    //           horizontal: 5.w,
                                    //         ),
                                    //         decoration: BoxDecoration(
                                    //           color: AppColor.lightColor,
                                    //           borderRadius: BorderRadius.circular(30.0),
                                    //         ),
                                    //         child: DropdownButton<String>(
                                    //           underline: const SizedBox(),
                                    //           isExpanded: true,
                                    //           value: viceCaptainCity,
                                    //           style: fontRegular.copyWith(
                                    //               color: AppColor.textColor
                                    //           ),
                                    //           items: team.cityList.map((date) {
                                    //             return DropdownMenuItem<String>(
                                    //               value: date.cityName,
                                    //               child: Text(date.cityName.toString(),
                                    //                 style: fontRegular.copyWith(
                                    //                     color: AppColor.textColor
                                    //                 ),),
                                    //             );
                                    //           }).toList(),
                                    //           onChanged: (selectedDateId) {
                                    //             // print(selectedDateId);
                                    //             setState(() {
                                    //               viceCaptainCity = selectedDateId;
                                    //             });
                                    //           },
                                    //         ),
                                    //       );
                                    //     }
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: const Divider(thickness: 1.0,),
                      ),
                      //admin
                      SizedBox(
                        width: double.infinity,
                        child: Theme(
                          data: Theme.of(context).copyWith(
                              dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            initiallyExpanded: true,
                            title: RichText(
                                 text: TextSpan(
                                 text: 'Team admin details',
                                 style: fontMedium.copyWith(
                                    color: AppColor.textColor,
                                    fontSize: 12.sp,
                                   ),
                                 children: <TextSpan>[
                                     TextSpan(text: ' (Optional)',
                                      style: fontRegular.copyWith(
                                      color: AppColor.textMildColor,
                                      fontSize: 12.sp,
                                    ),
                                )
                                ]
                               ),
                              ),
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.w
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const FieldHeading("Name"),
                                    SizedBox(height:1.h),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 5.w,
                                        vertical: 1.2.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColor.lightColor,
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      child: Center(
                                        child: TextFormField(
                                          controller: adminNameController,
                                          cursorColor: AppColor.secondaryColor,
                                          style: fontRegular.copyWith(
                                              fontSize: 10.sp,
                                              color: AppColor.textColor
                                          ),
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            border: InputBorder.none,
                                            hintText: "Virat Kohli",
                                            hintStyle: fontRegular.copyWith(
                                                fontSize: 10.sp,
                                                color: AppColor.textMildColor
                                            ),),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height:2.h),
                                    const FieldHeading("Mobile Number"),
                                    SizedBox(height:1.h),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 5.w,
                                        vertical: 1.2.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColor.lightColor,
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      child: Center(
                                        child: TextFormField(
                                          controller: adminMobileController,
                                          cursorColor: AppColor.secondaryColor,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(10),
                                          ],
                                          style: fontRegular.copyWith(
                                              fontSize: 10.sp,
                                              color: AppColor.textColor
                                          ),
                                          keyboardType: TextInputType.phone,
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            border: InputBorder.none,
                                            hintText: "9999988888",
                                            hintStyle: fontRegular.copyWith(
                                                fontSize: 10.sp,
                                                color: AppColor.textMildColor
                                            ),),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height:2.h),
                                    const FieldHeading("Secondary Number"),
                                    SizedBox(height:1.h),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 5.w,
                                        vertical: 1.2.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColor.lightColor,
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      child: Center(
                                        child: TextFormField(
                                          controller: adminSecMobileController,
                                          cursorColor: AppColor.secondaryColor,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(10),
                                          ],
                                          style: fontRegular.copyWith(
                                              fontSize: 10.sp,
                                              color: AppColor.textColor
                                          ),
                                          keyboardType: TextInputType.phone,
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            border: InputBorder.none,
                                            hintText: "9999988888",
                                            hintStyle: fontRegular.copyWith(
                                                fontSize: 10.sp,
                                                color: AppColor.textMildColor
                                            ),),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    // const FieldHeading("State"),
                                    // SizedBox(height:1.h),
                                    // Consumer<TeamProvider>(
                                    //     builder: (context, team, child) {
                                    //       return InkWell(
                                    //         onTap: (){
                                    //           getStateList();
                                    //           openStateSheet();
                                    //         },
                                    //         child: Container(
                                    //           width: double.infinity,
                                    //           padding: EdgeInsets.symmetric(
                                    //             horizontal: 5.w,
                                    //             vertical: 1.2.h
                                    //           ),
                                    //           decoration: BoxDecoration(
                                    //             color: AppColor.lightColor,
                                    //             borderRadius: BorderRadius.circular(30.0),
                                    //           ),
                                    //           child: Row(
                                    //             children: [
                                    //               Text(team.state,
                                    //                 style: fontRegular.copyWith(
                                    //                 color: AppColor.textColor
                                    //                 ),),
                                    //               const Spacer(),
                                    //               const Icon(Icons.arrow_drop_down_sharp, color: AppColor.textColor,)
                                    //             ],
                                    //           ),
                                    //         ),
                                    //       );
                                    //     }
                                    // ),
                                    // SizedBox(height: 2.h),
                                    // const FieldHeading("City"),
                                    // SizedBox(height:1.h),
                                    // Consumer<TeamProvider>(
                                    //     builder: (context, team, child) {
                                    //       return InkWell(
                                    //         onTap: (){
                                    //           openCitySheet(team.stateId);
                                    //         },
                                    //         child: Container(
                                    //           width: double.infinity,
                                    //           padding: EdgeInsets.symmetric(
                                    //             horizontal: 5.w,
                                    //             vertical: 1.2.h
                                    //           ),
                                    //           decoration: BoxDecoration(
                                    //             color: AppColor.lightColor,
                                    //             borderRadius: BorderRadius.circular(30.0),
                                    //           ),
                                    //           child: Row(
                                    //             children: [
                                    //               Text(team.stateBasedCity,
                                    //                 style: fontRegular.copyWith(
                                    //                     color: AppColor.textColor
                                    //                 ),),
                                    //               const Spacer(),
                                    //               const Icon(Icons.arrow_drop_down_sharp, color: AppColor.textColor,)
                                    //             ],
                                    //           ),
                                    //         ),
                                    //       );
                                    //     }
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: const Divider(thickness: 1.0,),
                      ),
                      //payment details
                      SizedBox(
                        width: double.infinity,
                        child: Theme(
                          data: Theme.of(context).copyWith(
                              dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            initiallyExpanded: true,
                            title: Text(
                              "Payment details",
                              style: fontMedium.copyWith(
                                  fontSize: 12.sp,
                                  color: AppColor.textColor),
                            ),
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.w
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const FieldHeading("QR Code *"),
                                    SizedBox(height:1.h),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 1.5.h,
                                      ) + EdgeInsets.only(
                                        left: 5.w, right: 3.w
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColor.lightColor,
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(qrcode.isNotEmpty ? qrcode[0].split('/').last.toString() : "Select File",
                                              style: fontRegular.copyWith(
                                                  fontSize: 10.sp,
                                                  color: AppColor.textColor
                                              ),),
                                          ),
                                          Bounceable(
                                            onTap: (){
                                              pickFile();
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 5.w,
                                                vertical: 1.h,
                                              ),
                                              decoration: BoxDecoration(
                                                color: AppColor.secondaryColor,
                                                borderRadius: BorderRadius.circular(20.0),
                                              ),
                                              child: Center(
                                                child: Text("Choose File",
                                                  style: fontRegular.copyWith(
                                                      fontSize: 10.sp,
                                                      color: AppColor.lightColor
                                                  ),),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height:2.h),
                                    const FieldHeading("UPI ID *"),
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
                                          controller: upiController,
                                          cursorColor: AppColor.secondaryColor,
                                          style: fontRegular.copyWith(
                                              fontSize: 10.sp,
                                              color: AppColor.textColor
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Enter UPI ID';
                                            }
                                            return null;
                                          },
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.done,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            border: InputBorder.none,
                                            hintText: "9999988888",
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
                      ),
                    ],
                  ),
                ),
              ),
              loading
                  ? const Center( child: CircularProgressIndicator(),)
                  : Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 5.w,
                    vertical: 3.h
                ),
                child: Bounceable(
                    onTap: (){
                      validate();
                    },
                    child: const CustomButton(AppColor.textColor, "Save", AppColor.lightColor)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  validate(){
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    String stateId = Provider.of<TeamProvider>(context, listen: false).stateId;
    String capName = Provider.of<TeamProvider>(context, listen: false).captainName;
    String capId = Provider.of<TeamProvider>(context, listen: false).captainId;
    String cityId = Provider.of<TeamProvider>(context, listen: false).stateBasedCityId;
    print(captainCity);
    print(viceCaptainCity);
    if (_formKey.currentState!.validate()) {
      if(teamLogo.isEmpty){
        Dialogs.snackbar("Upload team logo image", context, isError: true);
      } else if(qrcode.isEmpty){
        Dialogs.snackbar("Upload qr code image", context, isError: true);
      }
      // else if(captainCity == "" || captainCity == null){
      //   Dialogs.snackbar("Choose captain city", context, isError: true);
      // } else if(viceCaptainCity == "" || viceCaptainCity == null){
      //   Dialogs.snackbar("Choose vice captain city", context, isError: true);
      // }
      else{
        setState(() {
          loading = true;
        });
        TeamProvider().createTeam(
            teamLogo,
            qrcode,
            teamNameController.text,
            teamMobileController.text,
            teamSecMobileController.text,
            capName,
            capMobileController.text,
            captainCity.toString(),
            vcNameController.text,
            vcMobileController.text,
            viceCaptainCity.toString(),
            adminNameController.text,
            adminMobileController.text,
            stateId, cityId, upiController.text, capSecMobileController.text,
            vcSecMobileController.text,
            adminSecMobileController.text, capId)
            .then((value){
          if(value.status == true){
            setState(() {
              loading = false;
            });
            showDialog(context: context,
                builder: (BuildContext context){
                  return CustomDialogBox(
                    "Success",
                    "Your team and team code has been successfully created",
                    value.user!.teamRefCode.toString(),
                  );
                }
            );
          } else if(value.status == false){
            setState(() {
              loading = false;
            });
            Dialogs.snackbar("Something went wrong", context, isError: true);
          }
        });
      }

    }

  }

  void openCitySheet(String stateBasedCityId) {
    Provider.of<TeamProvider>(context, listen: false).getStateBasedCityList(stateBasedCityId);
    showDialog(context: context,
        builder: (BuildContext context){
          return const CityListDialog();
        }
    );
  }

  void openStateSheet() {
    showDialog(context: context,
        builder: (BuildContext context){
          return const StateListDialog();
        }
    );
  }
}

class FieldHeading extends StatelessWidget {
  final String heading;
  const FieldHeading(this.heading, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(heading,
      style: fontRegular.copyWith(
          fontSize: 10.sp,
          color: AppColor.textColor
      ),);
  }
}

