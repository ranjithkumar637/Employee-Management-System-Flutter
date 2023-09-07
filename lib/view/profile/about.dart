import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:elevens_organizer/utils/app_constants.dart';
import 'package:elevens_organizer/view/profile/update_description_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

import '../../providers/profile_provider.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import '../widgets/custom_dialog_box.dart';
import '../widgets/snackbar.dart';

class About extends StatefulWidget {
  final ProfileProvider ground;
  const About(this.ground, {Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {

  File? imageFile = File("");
  List<File> imageFiles = [];
  FilePickerResult? files;
  List<PlatformFile> multipleFiles = [];
  List<String> groundImages = [];

  openCameraStart() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      imageQuality: 50,
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        imageFiles.add(File(pickedFile.path));
        // groundImages.add(pickedFile.path);
      });
      Provider.of<ProfileProvider>(context, listen: false).saveGroundImages(pickedFile.path);
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
        // groundImages.add(pickedFile.path);
      });
      Provider.of<ProfileProvider>(context, listen: false).saveGroundImages(pickedFile.path);
    }
  }

  openGalleryStartMulti() async {
    List<XFile>? pickedFile = await ImagePicker().pickMultiImage();
    if (pickedFile.isNotEmpty) {
      if(pickedFile.length > 5){
        Dialogs.snackbar("Upload up to 5 images", context, isError: true);
      } else {
        for(int i = 0; i < pickedFile.length; i++){
          setState(() {
            imageFile = File(pickedFile[i].path);
            imageFiles.add(File(pickedFile[i].path));
          });
          Provider.of<ProfileProvider>(context, listen: false).saveMultiGroundImages(pickedFile);
        }
      }
    }
  }

  void chooseGroundImage() {
    showDialog(context: context,
        builder: (BuildContext context){
          return FilePickDialog(
            camera : openCameraStart,
            gallery: openGalleryStartMulti,
          );
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 2.h,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 1.5.h,
      ),
      decoration: BoxDecoration(
        color: AppColor.lightColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("About",
                style: fontMedium.copyWith(
                    color: AppColor.textColor,
                    fontSize: 12.sp
                ),),
              InkWell(
                  onTap: (){
                    showDialog(context: context,
                        builder: (BuildContext context){
                          return UpdateAboutDialog(
                              widget.ground.description);
                        }
                    );
                  },
                  child: SvgPicture.asset(Images.editIcon, color: AppColor.iconColour, width: 4.w,)),
            ],
          ),
          SizedBox(height: 2.h),
          Text("Description",
            style: fontMedium.copyWith(
                color: AppColor.textColor,
                fontSize: 11.sp
            ),),
          SizedBox(height: 1.h),
          Text(widget.ground.description.toString() == "" ? "-" : widget.ground.description.toString(),
            style: fontRegular.copyWith(
                color: AppColor.textColor,
                fontSize: 10.sp
            ),),
          const Dash(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Photos",
                style: fontMedium.copyWith(
                    color: AppColor.textColor,
                    fontSize: 12.sp
                ),),
              InkWell(
                  onTap: (){
                    imageFiles.length == 5
                        ? Dialogs.snackbar("Only 5 images are allowed", context, isError: false)
                        : chooseGroundImage();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.5.w,
                      vertical: 0.8.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.iconBgColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.add_circle_outline_rounded, color: AppColor.iconColour, size: 4.5.w,),
                        SizedBox(width: 2.w),
                        Text("Add Photos",
                          style: fontMedium.copyWith(
                              color: AppColor.iconColour,
                              fontSize: 8.sp
                          ),),
                      ],
                    ),
                  )),
            ],
          ),
          widget.ground.groundImages.isEmpty
              ? const SizedBox()
              : SizedBox(height: 2.h),
          widget.ground.groundImages.isEmpty
              ? const SizedBox()
              : SizedBox(
            height: 11.h,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, _){
                return SizedBox(width: 2.w);
              },
              scrollDirection: Axis.horizontal,
              itemCount: widget.ground.groundImages.length,
              itemBuilder: (context, index){
                return ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: CachedNetworkImage(
                    imageUrl: "${AppConstants.imageBaseUrl}${AppConstants.imageBaseUrlGallery}${widget.ground.groundImages[index].toString()}",
                    fit: BoxFit.cover,
                    width: 24.w,
                    height: 10.h,
                  ),
                );
              },
            ),
          ),
          imageFiles.isEmpty
              ? const SizedBox()
              : SizedBox(height: 2.h),
          imageFiles.isEmpty
              ? const SizedBox()
              : Row(
            children: [
              Text("Now added Photos",
                style: fontMedium.copyWith(
                    color: AppColor.textMildColor,
                    fontSize: 10.sp
                ),),
              const Spacer(),
              InkWell(
                onTap: (){
                  setState(() {
                    imageFiles = [];
                  });
                  Provider.of<ProfileProvider>(context, listen: false).removeMultiGroundImage();
                },
                child: Container(
                  width: 24.w,
                  padding: EdgeInsets.symmetric(
                    horizontal: 2.w,
                    vertical: 0.3.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.redColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Center(
                    child: Text("Remove all",
                      style: fontRegular.copyWith(
                          color: AppColor.redColor,
                          fontSize: 9.sp
                      ),),
                  ),
                ),
              ),
            ],
          ),
          imageFiles.isEmpty
              ? const SizedBox()
              : SizedBox(height: 2.h),
          imageFiles.isEmpty
              ? const SizedBox()
              : SizedBox(
            height: 15.h,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, _){
                return SizedBox(width: 2.w);
              },
              scrollDirection: Axis.horizontal,
              itemCount: imageFiles.length,
              itemBuilder: (context, index){
                return Column(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Image.file(
                          imageFiles[index],
                          width: 24.w,
                          height: 10.h,
                          fit: BoxFit.cover,
                        )),
                    SizedBox(height: 1.h),
                    InkWell(
                      onTap:(){
                        setState(() {
                          imageFiles.removeAt(index);
                        });
                        Provider.of<ProfileProvider>(context, listen: false).removeOneMultiGroundImage(index);
                      },
                      child: Container(
                        width: 24.w,
                        padding: EdgeInsets.symmetric(
                          horizontal: 2.w,
                          vertical: 0.3.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.redColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Center(
                          child: Text("Remove",
                            style: fontRegular.copyWith(
                                color: AppColor.redColor,
                                fontSize: 9.sp
                            ),),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Dash extends StatelessWidget {
  const Dash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 2.5.h,
      ),
      child: const DottedLine(
        dashColor: Color(0xffEFEAEA),
      ),
    );
  }
}
