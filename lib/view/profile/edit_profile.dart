import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:elevens_organizer/utils/styles.dart';
import 'package:elevens_organizer/view/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/profile_provider.dart';
import '../../utils/app_constants.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../widgets/custom_dialog_box.dart';
import 'information.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> with SingleTickerProviderStateMixin{

  late TabController tabController;

  File? imageFileProfile;
  List<String> profilePic = [];

  openCameraStartPic() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      imageQuality: 50,
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        imageFileProfile = File(pickedFile.path);
        profilePic.add(pickedFile.path);
      });
    }
  }

  openGalleryStartPic() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (pickedFile != null) {
      setState(() {
        imageFileProfile = File(pickedFile.path);
        profilePic.add(pickedFile.path);
      });
    }
  }

  void chooseProfilePic() {
    showDialog(context: context,
        builder: (BuildContext context){
          return FilePickDialog(
            camera : openCameraStartPic,
            gallery: openGalleryStartPic,
          );
        }
    );
  }


  getProfile(){
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<ProfileProvider>(context, listen: false).getProfile(context);
      Provider.of<ProfileProvider>(context, listen: false).getGroundDetails();
    });
  }

  File? imageFile = File("");
  List<File> imageFiles = [];

  openCameraStart() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      imageQuality: 50,
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        imageFiles.add(File(pickedFile.path));
      });
      Provider.of<ProfileProvider>(context, listen: false).saveGroundMainImage(pickedFile.path);
    }
  }

  openGalleryStart() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      imageQuality: 50,
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        imageFiles.add(File(pickedFile.path));
      });
      Provider.of<ProfileProvider>(context, listen: false).saveGroundMainImage(pickedFile.path);
    }
  }

  void chooseGroundImage() {
    showDialog(context: context,
        builder: (BuildContext context){
          return FilePickDialog(
            camera : openCameraStart,
            gallery: openGalleryStart,
          );
        }
    );
  }

  int newTabIndex = 0;

  Future<void> _requestLocationPermission() async {
    await Permission.location.request();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {
        newTabIndex = tabController.index;
      });
    });
    getProfile();
    _requestLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProfileProvider>(
        builder: (context, ground, child) {
          return Column(
            children: [
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Image.asset(Images.offingImage, width: double.maxFinite, fit: BoxFit.cover, height: 34.h,),
                  Positioned(
                    child: Container(
                      width: double.maxFinite,
                      height: 34.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color(0xff333334),
                            const Color(0xff333334).withOpacity(0.5),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 5.h,
                    left: 5.w,
                    child: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_back_ios_new, color: AppColor.lightColor, size: 4.5.w,),
                          SizedBox(width: 3.w),
                          Text("Back",
                          style: fontMedium.copyWith(
                            color: AppColor.lightColor,
                            fontSize: 12.sp
                          ),),
                        ],
                      ),
                    ),
                  ),
                  if(newTabIndex == 0)...[
                    Positioned(
                      top: 10.h,
                      child: Consumer<ProfileProvider>(
                          builder: (context, profile, child) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Stack(
                                  children: [
                                    imageFileProfile != null
                                        ? Container(
                                        height: 14.h,
                                        width: 28.w,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: AppColor.imageBorderColor, width: 2),
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: FileImage(imageFileProfile!)) )
                                    ) :
                                    ClipOval(
                                      child: CachedNetworkImage(
                                        height: 14.h,
                                        width: 28.w,
                                        fit: BoxFit.cover,
                                        imageUrl: "${AppConstants.imageBaseUrl}${AppConstants.imageBaseUrlProfile}${ground.organizerDetails.profilePhoto.toString()}",
                                        errorWidget: (context, url, widget){
                                          return Image.network("https://cdn-icons-png.flaticon.com/256/4389/4389644.png", height: 14.h,
                                            width: 28.w,
                                            fit: BoxFit.cover,);
                                        },
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0.0,
                                      right: 0.0,
                                      child: InkWell(
                                        onTap: (){
                                          chooseProfilePic();
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
                                SizedBox(height: 4.h),
                                Text(profile.getName(),
                                  style: fontMedium.copyWith(
                                      fontSize: 16.sp,
                                      color: AppColor.lightColor
                                  ),),
                              ],
                            );
                          }
                      ),
                    ),
                  ] else...[
                    Positioned(
                      bottom: 1.h,
                      child: ground.groundDetails.groundName == null || ground.groundDetails.groundName.toString() == ""
                          ? const SizedBox()
                          : Text(ground.groundDetails.groundName.toString(),
                        style: fontMedium.copyWith(
                            color: AppColor.lightColor,
                            fontSize: 16.sp
                        ),),
                    ),
                    Positioned(
                      top: 10.h,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          if(ground.groundDetails.mainImage.toString() == ""
                              && imageFiles.isEmpty)...[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.asset(Images.groundImage, width: 90.w,
                                fit: BoxFit.cover,
                                height: 18.h,),
                            ),
                          ] else if(ground.groundDetails.mainImage.toString() == ""
                              && imageFiles.isNotEmpty)...[
                            ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image.file(
                                  imageFile!,
                                  width: 90.w,
                                  fit: BoxFit.cover,
                                  height: 18.h,
                                ))
                          ]
                          else if(ground.groundDetails.mainImage.toString() != ""
                                && imageFiles.isNotEmpty)...[
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Image.file(
                                    imageFile!,
                                    width: 90.w,
                                    fit: BoxFit.cover,
                                    height: 18.h,
                                  ))
                            ]
                            else if(ground.groundDetails.mainImage.toString() != "")...[
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: CachedNetworkImage(
                                      imageUrl: "${AppConstants.imageBaseUrl}${AppConstants.imageBaseUrlGallery}${ground.mainImg.toString()}",
                                      width: 90.w,
                                      fit: BoxFit.cover,
                                      height: 18.h,
                                      errorWidget: (context, error, url) =>
                                          Image.asset(Images.groundImage, width: 90.w,
                                            fit: BoxFit.cover,
                                            height: 18.h,),
                                    ))
                              ],
                          //gradient
                          Positioned(
                            child: Container(
                              width: 90.w,
                              height: 18.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    const Color(0xff333334).withOpacity(0.1),
                                    const Color(0xff333334).withOpacity(0.01),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          //add / edit button
                          Positioned(
                            child: Bounceable(
                              onTap: (){
                                chooseGroundImage();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6.w,
                                  vertical: 0.6.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColor.primaryColor,
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: Text(ground.groundDetails.mainImage.toString() == "" || ground.groundDetails.mainImage == null ? "Add" : "Edit",
                                  style: fontMedium.copyWith(
                                      fontSize: 10.sp,
                                      color: AppColor.textColor
                                  ),),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]

                ],
              ),
              SizedBox(height: 2.h),
              TabBar(
                  onTap: (index) {
                    setState(() {
                      newTabIndex = index; // Update the active tab index
                    });
                  },
                  indicatorColor: AppColor.secondaryColor,
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelStyle: fontMedium.copyWith(
                      fontSize: 12.sp
                  ),
                  unselectedLabelColor: AppColor.unselectedTabColor,
                  labelColor: AppColor.secondaryColor,
                  controller: tabController,
                  tabs: const [
                    Tab(
                      text: "Profile",
                    ),
                    Tab(
                      text: "Information",
                    ),
                  ]),
              Theme(
                  data: ThemeData(
                    dividerTheme: const DividerThemeData(
                      space: 0,
                      thickness: 0.5,
                      indent: 0,
                      endIndent: 0,
                    ),
                  ),
                  child: const Divider()),
              Expanded(
                child: TabBarView(
                    controller: tabController,
                    children: [
                      Profile(ground, profilePic),
                      Information(ground),
                    ]),
              ),
            ],
          );
        }
      ),
    );
  }
}
