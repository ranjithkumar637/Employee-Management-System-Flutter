import 'package:elevens_organizer/view/notification/regular_notification.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/styles.dart';
import 'notification_count_card.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 5.w
            ) + EdgeInsets.only(
              top: 5.h, bottom: 3.h
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap:(){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back, color: AppColor.textColor, size: 7.w,)),
                Text("Notifications",
                  style: fontMedium.copyWith(
                      fontSize: 16.sp,
                      color: AppColor.textColor
                  ),),
                SizedBox(width: 7.w,),
              ],
            ),
          ),
          //notification count
          const NotificationCountCard(),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5.w, vertical: 2.h
            ),
            child: Text("Today",
              style: fontMedium.copyWith(
                  fontSize: 12.sp,
                  color: AppColor.textColor
              ),),
          ),
          const RegularNotification("Next Match", "Toss & Tails VS Dhoni CC", false),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}


