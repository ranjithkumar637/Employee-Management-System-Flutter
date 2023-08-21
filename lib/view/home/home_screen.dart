import 'package:elevens_organizer/models/total_revenue-model.dart';
import 'package:elevens_organizer/view/home/points_revenue_box.dart';
import 'package:elevens_organizer/view/home/ref_code_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:provider/provider.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';
import 'package:sizer/sizer.dart';

import '../../models/slot_list_model.dart';
import '../../providers/booking_provider.dart';
import '../../providers/payment_info_provider.dart';
import '../../providers/profile_provider.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import '../widgets/slot_colour_info.dart';
import '../widgets/snackbar.dart';
import 'custom_date_picker.dart';
import 'home_grid_options.dart';
import 'notification_dot.dart';
import 'offing_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool loading = false;
  DateTime deliveryDate = DateTime.now();
  DateTime bookingDate = DateTime.now();

  int selectedItemIndex = -1;
  bool canBook = false;
  String slotTime = "", slotTime24 = "";
  List<SlotTimeList> slotsList = [];

  Future<List<Offings>>? futureData;
  List<Offings> offingsList = [];

  getOffingsList(){
    futureData = PaymentInfoProvider().offingsList()
        .then((value) {
          if(mounted){
            setState(() {
              offingsList = [];
              offingsList.addAll(value);
            });
          }
          return offingsList;
    });
  }

  String convertTo12HourFormat(String time) {
    DateFormat inputFormat = DateFormat('HH:mm:ss');
    DateFormat outputFormat = DateFormat('hh:mm a');

    DateTime dateTime = inputFormat.parse(time);
    String formattedTime = outputFormat.format(dateTime);

    return formattedTime;
  }

  getSlotsList(String groundId){
    print("get slots ground id $groundId");
    BookingProvider().getSlotsTimeList(groundId, bookingDate)
        .then((value){
      if(value.status == true){
        print(value.slotTimeList);
        setState(() {
          slotsList = [];
          slotsList = value.slotTimeList!;
        });
      }
    });

  }


  setDelay() async {
    if(mounted){
      setState(() {
        loading = true;
      });
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getProfile();
      getOffingsList();
    });
    await Future.delayed(const Duration(seconds: 1));
    if(mounted){
      setState(() {
        loading = false;
      });
    }
    await Future.delayed(const Duration(seconds: 2));
    if(mounted){
      final profile = Provider.of<ProfileProvider>(context, listen: false);
      getSlotsList(profile.organizerDetails.groundId.toString());
    }
  }

  showReferralCode(String refCode){
    showDialog(context: context,
        builder: (BuildContext context){
          return RefCodeDialog(refCode: refCode);
        }
    );
  }

  getProfile() async {
    Provider.of<ProfileProvider>(context, listen: false).getProfile();
    Provider.of<ProfileProvider>(context, listen: false).getReferralsList();
  }

  @override
  void initState() {
    super.initState();
    setDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: loading
          ? Center(child: Lottie.asset("assets/wicket.json", width: 100.w))
          : Consumer<ProfileProvider>(
          builder: (context, profile, child) {
            return Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 28.h,
                      child: ClipPath(
                        clipper: ProsteBezierCurve(
                          position: ClipPosition.bottom,
                          list: [
                            BezierCurveSection(
                              start: Offset(0, 22.h),
                              top: Offset(MediaQuery.of(context).size.width / 2, 28.h),
                              end: Offset(MediaQuery.of(context).size.width, 22.h),
                            ),
                          ],
                        ),
                        child: Image.asset(Images.pitchImage, fit: BoxFit.cover,),
                      ),
                    ),
                    Positioned(
                      child: SizedBox(
                        height: 28.h,
                        width: double.infinity,
                        child: ClipPath(
                          clipper: ProsteBezierCurve(
                            position: ClipPosition.bottom,
                            list: [
                              BezierCurveSection(
                                start: Offset(0, 22.h),
                                top: Offset(MediaQuery.of(context).size.width / 2, 28.h),
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
                                  Color(0xff383838),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    //referral points & revenue aomount
                    Positioned(
                      top: 18.h,
                      right: 5.w,
                      left: 5.w,
                      child: Row(
                        children: [
                          Expanded(
                            child: PointsAndRevenueBox(Images.refPointsImage, "Total Referral\nPoints", profile.profileModel.refPoints.toString() == "null"
                                ? "0"
                                : "${profile.profileModel.refPoints.toString()} pts", 1),
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: PointsAndRevenueBox(
                                Images.revenueAmountImage,
                                "Total Revenue\nAmount",
                                profile.profileModel.totalRevenue.toString() == "null"
                                ? "0"
                                : "₹ ${profile.profileModel.totalRevenue.toString()}",
                                2),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 5.h,
                      left: 5.w,
                      right: 5.w,
                      child: Row(
                        children: [
                          Bounceable(
                            onTap:(){
                            },
                            child: Container(
                              height: 10.h,
                              width: 20.w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: AppColor.imageBorderColor, width: 3.0),
                                  color: Colors.white,
                                  image: const DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage("https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg?w=1380&t=st=1680345590~exp=1680346190~hmac=eb31a40018f2115d71ee38e25576a27bf9933b85d832af6bb6ece771dc2c4d42"))
                              ),
                            ),
                          ),
                          SizedBox(width: 3.w),
                          Expanded(
                            child: Text("Hello!\n${profile.getName()}",
                              style: fontMedium.copyWith(
                                  fontSize: 14.sp,
                                  color: AppColor.lightColor
                              ),),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  GestureDetector(
                                      onTap:(){
                                        Navigator.pushNamed(context, "notification_screen");
                                      },
                                      child: SvgPicture.asset(Images.notification, color: AppColor.lightColor, width: 5.5.w,)),
                                  profile.profileModel.notifyCount.toString() == "0"
                                      ? const SizedBox()
                                      : const Positioned(
                                      right: -2.0,
                                      top: -2.0,
                                      child: NotificationDot()),
                                ],
                              ),
                              SizedBox(height: 2.h),
                              profile.organizerDetails.adminApprove == 1 ? Bounceable(
                                onTap: (){
                                  showReferralCode(profile.organizerDetails.organizerRefCode.toString());
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 3.w,
                                    vertical: 0.6.h,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(profile.organizerDetails.organizerRefCode.toString(),
                                        style: fontRegular.copyWith(
                                            fontSize: 10.sp,
                                            color: AppColor.lightColor
                                        ),),
                                      SizedBox(width: 2.w),
                                      SvgPicture.asset(Images.share, color: AppColor.lightColor, width: 4.w,),
                                    ],
                                  ),
                                ),
                              ) : Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 3.w,
                                  vertical: 0.6.h,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: AppColor.redColor
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.pending_actions, color: AppColor.lightColor, size: 4.w,),
                                    SizedBox(width: 2.w),
                                    Text("Pending approval",
                                      style: fontRegular.copyWith(
                                          fontSize: 10.sp,
                                          color: AppColor.lightColor
                                      ),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Expanded(
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 3.w,
                              vertical: 1.5.h
                          ),
                          margin: EdgeInsets.symmetric(
                              horizontal: 5.w,
                              vertical: 2.h
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.lightColor,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Booking Information",
                                style: fontMedium.copyWith(
                                    color: AppColor.textColor,
                                    fontSize: 12.sp
                                ),),
                              SizedBox(height: 1.5.h),
                              CustomDatePicker(
                                  onDateSelected: (date) {
                                    setState(() {
                                      selectedItemIndex = -1;
                                      bookingDate = date;
                                      slotTime = "";
                                      slotTime24 = "";
                                    });
                                    // widget.refresh();
                                    final currentDate = DateTime.now();
                                    if(date.isBefore(currentDate)){
                                      setState(() {
                                        canBook = false;
                                      });
                                    } else{
                                      print("today");
                                      getSlotsList(profile.organizerDetails.groundId.toString());
                                    }
                                    print(date);
                                  },
                                  enableBooking: (value){
                                    setState(() {
                                      canBook = value;
                                    });
                                    if(canBook){
                                      getSlotsList(profile.organizerDetails.groundId.toString());
                                      // Provider.of<BookingProvider>(context, listen: false).getSlotsTimeList(widget.groundId, bookingDate);
                                    }
                                  },
                                  itemWidth: 15.w),
                              SizedBox(height: 2.h),
                              slotsList.isEmpty
                                  ? Text("Slots not available",
                                style: fontMedium.copyWith(
                                    color: AppColor.redColor,
                                    fontSize: 11.sp
                                ),)
                                  :
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Slot Time",
                                    style: fontMedium.copyWith(
                                        color: AppColor.textColor,
                                        fontSize: 11.sp
                                    ),),
                                  SizedBox(height: 1.5.h),
                                  SizedBox(
                                    height: 10.h,
                                    child: ListView.separated(
                                      separatorBuilder: (context, _){
                                        return SizedBox(width: 2.w);
                                      },
                                      scrollDirection: Axis.horizontal,
                                      physics: const BouncingScrollPhysics(),

                                      itemCount: slotsList.length,
                                      itemBuilder: (context, index){
                                        String timeString = slotsList[index].start.toString();
                                        String timeStringLastSlot = slotsList.last.start.toString();
                                        print("last slot start time $timeString");
                                        DateTime dynamicDate = DateFormat("yyyy-MM-dd").parse(bookingDate.toString());
                                        DateTime dateTimeWithDynamicDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(
                                          "${DateFormat("yyyy-MM-dd").format(dynamicDate)} $timeString",
                                        );
                                        DateTime dateTimeWithDynamicDate1 = DateFormat("yyyy-MM-dd HH:mm:ss").parse(
                                          "${DateFormat("yyyy-MM-dd").format(dynamicDate)} $timeStringLastSlot",
                                        );
                                        if (dateTimeWithDynamicDate.isBefore(DateTime.now())) {
                                          print("Time is in the past, hide it.");
                                        } else {
                                          print("Time is in the future, show it.");
                                        }
                                        return dateTimeWithDynamicDate.isBefore(DateTime.now())
                                            ? const SizedBox()
                                            : dateTimeWithDynamicDate1.isBefore(DateTime.now())
                                            ? Text("Slots not available",
                                          style: fontMedium.copyWith(
                                              color: AppColor.redColor,
                                              fontSize: 11.sp
                                          ),)
                                            : Column(
                                          children: [
                                            if(slotsList[index].booked.toString() == "0" && slotsList[index].left.toString() == "0")...[
                                              Text("2 Left",
                                                style: fontRegular.copyWith(
                                                    color: AppColor.textColor,
                                                    fontSize: 9.sp
                                                ),),
                                            ] else if(slotsList[index].booked.toString() == "1" && slotsList[index].left.toString() == "1")...[
                                              Text("1 Left",
                                                style: fontRegular.copyWith(
                                                    color: AppColor.textColor,
                                                    fontSize: 9.sp
                                                ),),
                                            ] else if(slotsList[index].booked.toString() == "1" && slotsList[index].left.toString() == "0")...[
                                              Text("Full",
                                                style: fontRegular.copyWith(
                                                    color: AppColor.textColor,
                                                    fontSize: 9.sp
                                                ),),
                                            ],
                                            SizedBox(height: 0.5.h),
                                            Bounceable(
                                              onTap: () {
                                                if(canBook && slotsList[index].block.toString() == "1"){
                                                  Dialogs.snackbar(slotsList[index].blockReason.toString(), context, isError: true);
                                                }
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 5.w,
                                                  vertical: 0.8.h,
                                                ),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(30.0),
                                                    border: RDottedLineBorder.all(color: selectedItemIndex == index ? AppColor.lightColor : Colors.transparent, width: 3),
                                                    color: slotsList[index].booked.toString() == "0" && slotsList[index].left.toString() == "0" && slotsList[index].block.toString() == "1" ||
                                                        slotsList[index].booked.toString() == "1" && slotsList[index].left.toString() == "1" && slotsList[index].block.toString() == "1" ||
                                                        slotsList[index].booked.toString() == "0" && slotsList[index].left.toString() == "0" && slotsList[index].block.toString() == "1"
                                                        ? AppColor.hintFadeColour
                                                        : slotsList[index].booked.toString() == "0" && slotsList[index].left.toString() == "0"
                                                        ? AppColor.redColor
                                                        : slotsList[index].booked.toString() == "1" && slotsList[index].left.toString() == "1"
                                                        ? AppColor.selectedSlot
                                                        : slotsList[index].booked.toString() == "1" && slotsList[index].left.toString() == "0"
                                                        ? AppColor.availableSlot : AppColor.textColor
                                                ),
                                                child: Center(
                                                  child: Text(convertTo12HourFormat(slotsList[index].start.toString()),
                                                    style: fontRegular.copyWith(
                                                        color: AppColor.lightColor,
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
                              !canBook
                                  ? const SizedBox()
                                  : slotsList.isEmpty
                                  ? const SizedBox() : const SlotColourInfo(),
                            ],
                          ),
                        ),
                        //6 options
                        const HomeGridOptions(),
                        SizedBox(height: 3.h),
                        //in the offing title
                        offingsList.isEmpty
                        ? const SizedBox()
                        : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "In The Offing",
                                    style: fontMedium.copyWith(
                                        fontSize: 12.sp, color: AppColor.textColor),
                                  ),
                                  InkWell(
                                    onTap: (){

                                    },
                                    child: Text(
                                      "View all",
                                      style: fontMedium.copyWith(
                                          fontSize: 10.sp, color: AppColor.redColor),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2.h),
                              //horizontal listview
                              SizedBox(
                                height: 19.h,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (context ,_){
                                    return SizedBox(width: 2.w,);
                                  },
                                  itemCount: offingsList.length,
                                  itemBuilder: (context, index){
                                    final offing = offingsList[index];
                                    return OffingCard(offing);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 4.h),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
      ),
    );
  }
}






