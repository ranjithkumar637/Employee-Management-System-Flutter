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
  String? accToken;
  Future<List<Uint8List>>? _imageData;

  Future<Uint8List> fetchProtectedImages(String imageUrl) async {
    print("imageurl $imageUrl");
    final headers = {'Authorization': 'Bearer $accToken'};

    var response = await http.get(Uri.parse("${AppConstants.imageBaseUrl}${AppConstants.imageBaseUrlGallery}$imageUrl"), headers: headers);
    print("${AppConstants.imageBaseUrl}${AppConstants.imageBaseUrlGallery}$imageUrl");
    print(response.body);
    print(response.statusCode);
    print(json.decode(response.body));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load image');
    }
  }


  getPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    accToken = preferences.getString("access_token");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrefs();
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
              widget.ground.groundImages.length < 5
              ? InkWell(
                  onTap: (){
                    chooseGroundImage();
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
                  )) : const SizedBox(),
            ],
          ),
          SizedBox(height: 2.h),
          SizedBox(
            height: 11.h,
            child: ListView.separated(
              separatorBuilder: (context, _){
                return SizedBox(width: 2.w);
              },
              scrollDirection: Axis.horizontal,
              itemCount: widget.ground.groundImages.length,
              itemBuilder: (context, index){
                print("index $index");
                return FutureBuilder<Uint8List>(
                  future: fetchProtectedImages(widget.ground.groundImages[index].toString()),
                  builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                      return Image.memory(
                        snapshot.data!,
                        fit: BoxFit.cover,
                      );
                    } else if (snapshot.hasError) {
                      print("failed to load image");
                      return const Text('Failed to load images');
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                );
                // return ClipRRect(
                //     borderRadius: BorderRadius.circular(5.0),
                //     child: Image.memory(
                //       fetchProtectedImage("${AppConstants.imageBaseUrl}storage/app/public/ground/${widget.ground.groundImages[index].toString()}"),
                //       width: 24.w,
                //       height: 10.h,
                //       fit: BoxFit.cover,
                //     ));
              },
            ),
          ),
          imageFiles.isEmpty
              ? const SizedBox()
              : SizedBox(height: 2.h),
          imageFiles.isEmpty
          ? const SizedBox()
          : SizedBox(
            height: 11.h,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, _){
                return SizedBox(width: 2.w);
              },
              scrollDirection: Axis.horizontal,
              itemCount: imageFiles.length,
              itemBuilder: (context, index){
                return ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Image.file(
                      imageFiles[index],
                      width: 24.w,
                      height: 10.h,
                      fit: BoxFit.cover,
                    ));
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
