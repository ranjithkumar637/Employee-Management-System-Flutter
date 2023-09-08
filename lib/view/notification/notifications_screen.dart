import 'package:elevens_organizer/view/notification/regular_notification.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/notification_list_model.dart';
import '../../providers/profile_provider.dart';
import '../../utils/colours.dart';
import '../../utils/connectivity_status.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import '../widgets/loader.dart';
import '../widgets/no_internet_view.dart';
import 'notification_count_card.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  Future<List<NotificationList>>? futureData;
  List<NotificationList> notificationList = [];
  bool loading = false;

  getNotifications(){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      futureData = ProfileProvider().getNotificationList()
          .then((value) {
        setState(() {
          notificationList = [];
          notificationList.addAll(value);
        });
        return notificationList;
      });
    });
    Provider.of<ProfileProvider>(context, listen: false).readNotification();
  }

  setDelay() async{
    setState(() {
      loading = true;
    });
    getNotifications();
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      loading = false;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setDelay();
  }

  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    if (connectionStatus == ConnectivityStatus.offline) {
      return const NoInternetView();
    }
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
          // const NotificationCountCard(),
          // Padding(
          //   padding: EdgeInsets.symmetric(
          //     horizontal: 5.w, vertical: 2.h
          //   ),
          //   child: Text("Today",
          //     style: fontMedium.copyWith(
          //         fontSize: 12.sp,
          //         color: AppColor.textColor
          //     ),),
          // ),
          loading
              ? const Loader()
              : notificationList.isEmpty
              ? Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 16.h),
                Image.asset(Images.noMatches, width: 80.w, fit: BoxFit.cover,),
                SizedBox(height: 3.h),
                Text("You don’t have any notifications",
                  style: fontMedium.copyWith(
                      fontSize: 12.sp,
                      color: AppColor.redColor
                  ),),
              ],
            ),
          )
              : Expanded(
            child: FutureBuilder(
                future: futureData,
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Loader();
                  }
                  if(snapshot.connectionState == ConnectionState.done){
                    return MediaQuery.removePadding(
                      removeTop: true,
                      context: context,
                      child: ListView.separated(
                          separatorBuilder: (context, _){
                            return SizedBox(height: 2.h);
                          },
                          physics: const BouncingScrollPhysics(),
                          itemCount: notificationList.length,
                          itemBuilder: (context, index){
                            return RegularNotification(
                                notificationList[index].title.toString(),
                                notificationList[index].note.toString(),
                                notificationList[index].groundImage.toString());
                          }
                      ),
                    );
                  } else {
                    return const Loader();
                  }
                }
            ),
          ),
        ],
      ),
    );
  }
}


