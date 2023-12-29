import 'package:cached_network_image/cached_network_image.dart';
import 'package:elevens_organizer/models/notification_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../utils/app_constants.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';

class RegularNotification extends StatelessWidget {
  final String title, body, image, read;
  final NotificationList item;
  const RegularNotification(this.title, this.body, this.image, this.read, this.item, {Key? key}) : super(key: key);

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
          if(item.matchId.toString() == "")...[
            CircleAvatar(
              radius: 30.0,
              backgroundColor: AppColor.primaryColor.withOpacity(0.5),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 3.w
                ),
                child: SvgPicture.asset(Images.notification, color: AppColor.textColor,),
              ),
            ),
          ] else ...[
            ClipOval(
              child: CachedNetworkImage(
                imageUrl: "${AppConstants.imageBaseUrl}${AppConstants.imageBaseUrlGallery}$image",
                height: 7.h,
                width: 14.w,
                fit: BoxFit.cover,
                errorWidget: (context, url, widget){
                  return Image.asset(Images.groundSmall, fit: BoxFit.cover, height: 7.h,
                    width: 14.w,);
                },
              ),
            ),
          ],
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                  style: fontMedium.copyWith(
                      fontSize: 11.sp,
                      color: AppColor.redColor
                  ),),
                SizedBox(height: 1.h),
                Text(body,
                  style: fontRegular.copyWith(
                      fontSize: 10.sp,
                      color: AppColor.textColor
                  ),),
              ],
            ),
          ),
          SizedBox(width: 3.w),
          read == "0"
          ? const CircleAvatar(
            radius: 4,
            backgroundColor: AppColor.secondaryColor,
          ) : const SizedBox(),
        ],
      ),
    );
  }
}
