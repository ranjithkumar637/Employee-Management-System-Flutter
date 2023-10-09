import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:elevens_organizer/models/total_revenue-model.dart';
import 'package:elevens_organizer/view/home/in_the_offing_screen.dart';
import 'package:elevens_organizer/view/home/points_revenue_box.dart';
import 'package:elevens_organizer/view/home/ref_code_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../models/offing_list_model.dart';
import '../../models/slot_list_model.dart';
import '../../models/upcoming_match_list_model.dart';
import '../../providers/booking_provider.dart';
import '../../providers/navigation_provider.dart';
import '../../providers/payment_info_provider.dart';
import '../../providers/profile_provider.dart';
import '../../providers/team_provider.dart';
import '../../utils/app_constants.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/scale_route.dart';
import '../../utils/styles.dart';
import '../auth/login_screen.dart';
import '../my_matches/match_info_screen.dart';
import '../my_matches/upcoming_battle.dart';
import '../my_matches/upcoming_match_card.dart';
import '../profile/edit_profile.dart';
import '../refer_and_earn/refer_and_earn_screen.dart';
import '../widgets/loader.dart';
import '../widgets/slot_colour_info.dart';
import '../widgets/snackbar.dart';
import 'custom_date_picker.dart';
import 'home_grid_options.dart';
import 'home_upcoming_card.dart';
import 'notification_dot.dart';
import 'offing_card.dart';
import 'offing_detail_screen.dart';

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

  Future<List<OffingsList>>? futureData;
  List<OffingsList> offingsList = [];

  Future<List<UpcomingMatch>>? futureData1;
  List<UpcomingMatch> upcomingMatchList = [];

  getUpcomingMatchList() {
    futureData1 =
        ProfileProvider().getOrganizerUpcomingMatchList().then((value) {
          if (mounted) {
            setState(() {
              upcomingMatchList = [];
              upcomingMatchList.addAll(value);
            });
          }
          print(upcomingMatchList);
          return upcomingMatchList;
        });
  }

  getOffingsList(){
    // print("get offing city id $cityId");
    futureData = PaymentInfoProvider().getOffingsList()
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
        if(mounted){
          setState(() {
            slotsList = [];
            slotsList = value.slotTimeList!;
          });
        }
      }
    });

  }

  bool reduceHeight = false;
  bool refreshSlots = false;

  setDelay() async {
    if(mounted){
      setState(() {
        loading = true;
      });
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getProfile();
      getUpcomingMatchList();
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
      getOffingsList();
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
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool? login = preferences.getBool("isLoggedIn");
    if(login == true){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ProfileProvider().getProfile(context)
            .then((value) async {
          if(value.status == true){
            Provider.of<ProfileProvider>(context, listen: false).getProfile(context);
          } else if(value.status == false && value.message.toString() == "Unauthenticated"){
            Dialogs.snackbar("User unauthenticated", context, isError: true);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) {
                return const LoginScreen();
              }),
            );
            SharedPreferences preferences =
            await SharedPreferences.getInstance();
            preferences.clear();
          }
        });
        Provider.of<ProfileProvider>(context, listen: false).getReferralsList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setDelay();
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: loading
          ? const Loader()
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
                      child: Image.asset(Images.homeTop, fit: BoxFit.cover,),
                    ),
                    Positioned(
                      top: 2.h + statusBarHeight,
                      left: 5.w,
                      right: 5.w,
                      child: Row(
                        children: [
                          Bounceable(
                            onTap:(){
                              Provider.of<NavigationProvider>(context, listen: false).setCurrentIndex(4);
                            },
                            child: ClipOval(
                              child: CachedNetworkImage(
                                height: 10.h,
                                width: 20.w,
                                fit: BoxFit.cover,
                                imageUrl: "${AppConstants.imageBaseUrl}${AppConstants.imageBaseUrlProfile}${profile.organizerDetails.profilePhoto.toString()}",
                                errorWidget: (context, url, widget){
                                  return Image.network("https://cdn-icons-png.flaticon.com/256/4389/4389644.png", height: 14.h,
                                    width: 28.w,
                                    fit: BoxFit.cover,);
                                },
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
                                        Navigator.pushNamed(context, "notification_screen")
                                            .then((value) {
                                          ProfileProvider().getProfile(context)
                                              .then((value) async {
                                            if(value.status == true){
                                              Provider.of<ProfileProvider>(context, listen: false).getProfile(context);
                                            } else if(value.status == false && value.message.toString() == "Unauthenticated"){
                                              Dialogs.snackbar("User unauthenticated", context, isError: true);
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(builder: (context) {
                                                  return const LoginScreen();
                                                }),
                                              );
                                              SharedPreferences preferences =
                                              await SharedPreferences.getInstance();
                                              preferences.clear();
                                            }
                                          });
                                        });
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
                              profile.organizerDetails.adminApprove == 1
                                  ? Bounceable(
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
                              )
                                  : const SizedBox(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Expanded(
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        SizedBox(height: 2.h),
                        if(profile.profileModel.refPoints.toString() != "null")...[
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                PointsAndRevenueBox(
                                    Images.revenueAmountImage,
                                    "Total Referral\nPoints",
                                    profile.profileModel.refPoints.toString() == "null"
                                        ? "0 pts"
                                        : "${profile.profileModel.refPoints.toString()} pts",
                                    1),
                                PointsAndRevenueBox(
                                    Images.revenueAmountImage,
                                    "Total Revenue\nAmount",
                                    profile.profileModel.totalRevenue.toString() == "null"
                                        ? "0"
                                        : "₹ ${profile.profileModel.totalRevenue.toString()}",
                                    2),
                              ],
                            ),
                          ),

                        ] else ...[
                          RevenueOnly(profile.profileModel.totalRevenue.toString()),
                        ],
                        Consumer<ProfileProvider>(
                            builder: (context, profile, child) {
                              return profile.organizerDetails.groundApprove == 0
                                  ? Bounceable(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return const EditProfile();
                                    }),
                                  ).then((value) {
                                    getProfile();
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 5.w,
                                  ) + EdgeInsets.only(
                                      top: 2.h
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 3.w,
                                    vertical: 1.2.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColor.redColor.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text("Awaiting admin's approval, your ground will be approved very shortly",
                                          style: fontMedium.copyWith(
                                              fontSize: 10.sp,
                                              color: AppColor.lightColor
                                          ),),
                                      ),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: AppColor.lightColor,
                                        size: 6.w,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                                  : const SizedBox();
                            }
                        ),
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
                          child: refreshSlots
                              ? Center(
                            child: Text("Refreshing slots...",
                              style: fontMedium.copyWith(
                                  color: AppColor.textColor,
                                  fontSize: 12.sp
                              ),),
                          )
                              : Column(
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
                                    }
                                  },
                                  itemWidth: 15.w),
                              SizedBox(height: 2.h),
                              slotsList.isEmpty
                                  ? Text("Slots will be opened shortly",
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
                                    height: 11.h,
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
                                        return Column(
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
                                                  horizontal: 3.w,
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
                                                        fontSize: 8.5.sp
                                                    ),),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 0.5.h),
                                            Text("${slotsList[index].overs.toString()} overs",
                                              style: fontRegular.copyWith(
                                                  color: AppColor.secondaryColor,
                                                  fontSize: 9.sp
                                              ),),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              reduceHeight ? SizedBox(height: 1.h) : const SizedBox(),
                              slotsList.isEmpty
                                  ? const SizedBox() : const SlotColourInfo(),
                            ],
                          ),
                        ),
                        //6 options
                        const HomeGridOptions(),
                        SizedBox(height: 3.h),
                        //in the offing title
                        offingsList.isEmpty
                            ? Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "In The Offing",
                                style: fontMedium.copyWith(
                                    fontSize: 12.sp, color: AppColor.textColor),
                              ),
                              SizedBox(height: 2.h),
                              Container(
                                width: double.maxFinite,
                                padding: EdgeInsets.symmetric(
                                    vertical: 2.h,
                                    horizontal: 4.w
                                ),
                                decoration: BoxDecoration(
                                  color: AppColor.redColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Text("No offings found",
                                  style: fontMedium.copyWith(
                                      color: AppColor.redColor,
                                      fontSize: 11.sp
                                  ),),
                              ),
                            ],
                          ),
                        )
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
                                      Provider.of<TeamProvider>(context, listen: false).removeFilterCity();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) {
                                              return InTheOffing(offingsList);
                                            }),
                                      );
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
                                child: FutureBuilder(
                                    future: futureData,
                                    builder: (context, snapshot) {
                                      if(snapshot.connectionState == ConnectionState.waiting){
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                      if(snapshot.connectionState == ConnectionState.done){
                                        return ListView.separated(
                                          scrollDirection: Axis.horizontal,
                                          physics: const BouncingScrollPhysics(),
                                          separatorBuilder: (context ,_){
                                            return SizedBox(width: 2.w,);
                                          },
                                          itemCount: offingsList.length > 3 ? 3 : offingsList.length,
                                          itemBuilder: (context, index){
                                            final offing = offingsList[index];
                                            return Bounceable(
                                                onTap: (){
                                                  Navigator.push(context, ScaleRoute(page: OffingDetailScreen(offing.matchId.toString(), offing)));
                                                },
                                                child: OffingCard(offing, offingsList.length));
                                          },
                                        );
                                      } else {
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                    }
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 2.h),
                        //my matches title
                        upcomingMatchList.isEmpty
                            ? Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "My Matches",
                                style: fontMedium.copyWith(
                                    fontSize: 12.sp, color: AppColor.textColor),
                              ),
                              SizedBox(height: 2.h),
                              Container(
                                width: double.maxFinite,
                                padding: EdgeInsets.symmetric(
                                    vertical: 2.h,
                                    horizontal: 4.w
                                ),
                                decoration: BoxDecoration(
                                  color: AppColor.redColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Text("No matches found",
                                  style: fontMedium.copyWith(
                                      color: AppColor.redColor,
                                      fontSize: 11.sp
                                  ),),
                              ),
                            ],
                          ),
                        )
                            : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "My Matches",
                                    style: fontMedium.copyWith(
                                        fontSize: 12.sp, color: AppColor.textColor),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      Provider.of<ProfileProvider>(context, listen: false)
                                          .moveToMatches();
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
                                height: 23.h,
                                child: FutureBuilder(
                                    future: futureData,
                                    builder: (context, snapshot) {
                                      if(snapshot.connectionState == ConnectionState.waiting){
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                      if(snapshot.connectionState == ConnectionState.done){
                                        return ListView.separated(
                                          scrollDirection: Axis.horizontal,
                                          physics: const BouncingScrollPhysics(),
                                          separatorBuilder: (context ,_){
                                            return SizedBox(width: 2.w,);
                                          },
                                          itemCount: upcomingMatchList.length > 3 ? 3 : upcomingMatchList.length,
                                          itemBuilder: (context, index){
                                            final match = upcomingMatchList[index];
                                            return UpcomingCard(match, upcomingMatchList.length);
                                          },
                                        );
                                      } else {
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                    }
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 2.h),
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

class RevenueOnly extends StatelessWidget {
  final String amount;
  const RevenueOnly(this.amount, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: (){
        Navigator.pushNamed(context, "revenue_screen");
      },
      child: Container(
        height: 14.h,
        width: 90.w,
        margin: EdgeInsets.symmetric(
            horizontal: 5.w
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColor.secondaryColor,
              AppColor.primaryColor,
            ],
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Positioned(
                right: 5.0,
                child: SvgPicture.asset(Images.revenueAmountImage, width: 23.w,)),
            Positioned(
              left: 5.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Total Revenue amount",
                    style: fontMedium.copyWith(
                        fontSize: 12.sp,
                        color: AppColor.textColor
                    ),),
                  SizedBox(height: 1.5.h),
                  Text("₹ $amount",
                    style: fontMedium.copyWith(
                        fontSize: 18.sp,
                        color: AppColor.textColor
                    ),),
                ],
              ),
            ),
            Positioned(
              right: 5.w,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: (){
                  Navigator.pushNamed(context, "revenue_screen");
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 3.w,
                    vertical: 0.6.h,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: AppColor.lightColor
                  ),
                  child: Center(
                    child: Text("View Details",
                      style: fontRegular.copyWith(
                          fontSize: 10.sp,
                          color: AppColor.textColor
                      ),),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}







