import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/app_constants.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';

class RegularNotification extends StatefulWidget {
  final String title, body, image;
  const RegularNotification(this.title, this.body, this.image, {Key? key}) : super(key: key);

  @override
  State<RegularNotification> createState() => _RegularNotificationState();
}

class _RegularNotificationState extends State<RegularNotification> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 5.w,
          vertical: 2.h
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 5.w,
      ),
      decoration: BoxDecoration(
        color: AppColor.lightColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: "${AppConstants.imageBaseUrl}${AppConstants.imageBaseUrlGallery}${widget.image}",
              height: 7.h,
              width: 14.w,
              fit: BoxFit.cover,
              errorWidget: (context, url, widget){
                return Image.asset(Images.groundListImage2, fit: BoxFit.cover, height: 7.h,
                  width: 14.w,);
              },
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title,
                  style: fontMedium.copyWith(
                      fontSize: 11.sp,
                      color: AppColor.redColor
                  ),),
                SizedBox(height: 1.h),
                Text(widget.body,
                  style: fontRegular.copyWith(
                      fontSize: 10.sp,
                      color: AppColor.textColor
                  ),),
              ],
            ),
          ),
          SizedBox(width: 3.w),
          const CircleAvatar(
            radius: 4,
            backgroundColor: AppColor.secondaryColor,
          ),
        ],
      ),
    );
  }
}
