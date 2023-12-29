import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';

class NewUpdateBottomSheet extends StatefulWidget {
  final String heading, releaseNotes, type, versionNumber, buildNo;
  final bool priority;
  const NewUpdateBottomSheet(this.heading, this.releaseNotes, this.priority, this.type, this.versionNumber, this.buildNo, {super.key});

  @override
  State<NewUpdateBottomSheet> createState() => _NewUpdateBottomSheetState();
}

class _NewUpdateBottomSheetState extends State<NewUpdateBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Container(
        height: 80.h,
        padding: EdgeInsets.symmetric(
          horizontal: 5.w
        ),
        decoration: const BoxDecoration(
          color: AppColor.lightColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 5.h,),
            if(widget.type.toString() == "feature")...[
              Lottie.asset("assets/update.json"),
            ] else if(widget.type.toString() == "improvements")...[
              SvgPicture.asset(Images.improvements, fit: BoxFit.cover, width: 70.w,),
            ] else if(widget.type.toString() == "bug")...[
              SvgPicture.asset(Images.bugFix, fit: BoxFit.cover, width: 70.w,),
            ],
            SizedBox(height: 5.h,),
            Text("v ${widget.versionNumber}.${widget.buildNo}",
              style: fontBold.copyWith(
                  fontSize: 12.sp,
                  color: AppColor.textMildColor
              ),),
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Text(widget.heading,
              textAlign: TextAlign.center,
              style: fontBold.copyWith(
                fontSize: 18.sp,
                color: AppColor.textColor
              ),),
            ),
            SizedBox(height: 5.h,),
            Expanded(
              child: ListView(
                children: [
                  Text(widget.releaseNotes,
                    textAlign: TextAlign.center,
                    style: fontMedium.copyWith(
                        fontSize: 12.sp,
                        color: AppColor.textColor
                    ),),
                ],
              ),
            ),
            SizedBox(height: 3.h,),
            Bounceable(
              onTap: () async {
                await StoreRedirect.redirect(
                    androidAppId: "com.eleven.captain",
                    iOSAppId: "").whenComplete(() {
                      Navigator.pop(context);
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 2.h
                ),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(30.0)
                ),
                child: Center(
                  child: Text("Update Now",
                  textAlign: TextAlign.center,
                  style: fontMedium.copyWith(
                      fontSize: 14.sp,
                      color: AppColor.textColor
                  ),),
                ),
              ),
            ),
            SizedBox(height: 2.h,),
            !widget.priority ? const SizedBox() : Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 1.5.h
              ),
              child: InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Text("Skip update",
                  style: fontBold.copyWith(
                      fontSize: 12.sp,
                      color: AppColor.textColor
                  ),),
              ),
            ),
            SizedBox(height: 3.h,),
          ],
        ),
      ),
    );
  }

}
