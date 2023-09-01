import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:elevens_organizer/utils/styles.dart';
import 'package:elevens_organizer/view/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
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


  getProfile(){
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<ProfileProvider>(context, listen: false).getProfile();
      Provider.of<ProfileProvider>(context, listen: false).getGroundDetails();
    });
  }

  File? imageFile = File("");
  List<File> imageFiles = [];

  openCameraStart() async {
    XFile? pickedFile = await ImagePicker().pickImage(
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
                  // Positioned(
                  //   top: 5.h,
                  //   right: 5.w,
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       // Icon(Icons.favorite_border_rounded, color: AppColor.lightColor, size: 6.w,),
                  //       // SizedBox(width: 5.w),
                  //       SvgPicture.asset(Images.share, color: AppColor.lightColor, width: 6.w,)
                  //     ],
                  //   ),
                  // ),
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
                        newTabIndex == 0 ? const SizedBox() : Positioned(
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
                        // Positioned(
                        //   bottom: 1.h,
                        //   right: 2.w,
                        //   child: ground.groundImages.isEmpty
                        //   ? const SizedBox()
                        //   : InkWell(
                        //     onTap: (){
                        //
                        //     },
                        //     child: Text("${ground.groundImages.length - 1}+ photos",
                        //       style: fontMedium.copyWith(
                        //           fontSize: 10.sp,
                        //           color: AppColor.lightColor
                        //       ),),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
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
                      Profile(ground),
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
