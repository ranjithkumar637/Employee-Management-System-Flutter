import 'package:elevens_organizer/view/revenue/revenue_list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../../models/revenue_team_list_model.dart';
import '../../providers/payment_info_provider.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import '../my_matches/match_history.dart';
import '../widgets/loader.dart';
import '../widgets/revenue_refer_data_box.dart';

class RevenueScreen extends StatefulWidget {
  const RevenueScreen({Key? key}) : super(key: key);

  @override
  State<RevenueScreen> createState() => _RevenueScreenState();
}

class _RevenueScreenState extends State<RevenueScreen> {

  String firstDate = "";
  String lastDate = "";

  Future<List<TeamsList>>? futureData ;
  bool loading = false;

  List<TeamsList> revenueTeamList = [];
  getRevenueTeamList(){
    futureData = PaymentInfoProvider().getRevenueTeamList().then((value){
      setState(() {
        revenueTeamList = [];
        revenueTeamList.addAll(value.teamsList!);
      });
      print(revenueTeamList);
      return revenueTeamList;
    });
  }
  setDelay() async{
    if(mounted){
      setState(() {
        loading = true;
      });
    }
    getRevenueTeamList();
    await Future.delayed(const Duration(seconds: 1));
    if(mounted){
      setState(() {
        loading = false;
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
    return Scaffold(
      body: Column(
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
                SizedBox(width: 7.w,),
                Text("Revenue",
                  style: fontMedium.copyWith(
                      fontSize: 16.sp,
                      color: AppColor.textColor
                  ),),
                SizedBox(width: 7.w,),
              ],
            ),
          ),
          revenueTeamList.isEmpty
              ? const SizedBox()
          : const RevenueReferDataBox("250000", 2),
          revenueTeamList.isEmpty
              ? const SizedBox()
              : Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5.w,
              vertical: 2.h,
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now(),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                useMaterial3: true,
                                colorScheme: const ColorScheme.light(
                                  primary: AppColor.primaryColor,
                                  onPrimary: AppColor.textColor,
                                  onSurface: AppColor.textColor,
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor: AppColor.secondaryColor, // button text color
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );

                        if (picked != null) {
                          setState(() {
                            firstDate = DateFormat("dd-MM-yyyy").format(picked);
                          });
                        }
                      },
                      child: DateFilterContainer(firstDate.toString() == "null" || firstDate.toString() == "" ? "Start Date" : firstDate.toString())),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: GestureDetector(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now(),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                useMaterial3: true,
                                colorScheme: const ColorScheme.light(
                                  primary: AppColor.primaryColor,
                                  onPrimary: AppColor.textColor,
                                  onSurface: AppColor.textColor,
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor: AppColor.secondaryColor, // button text color
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );

                        if (picked != null) {
                          setState(() {
                            lastDate = DateFormat("dd-MM-yyyy").format(picked);
                          });
                        }
                      },
                      child: DateFilterContainer(lastDate.toString() == "null" || lastDate.toString() == "" ? "End Date" : lastDate.toString())),
                ),
              ],
            ),
          ),
          Expanded(
            child: revenueTeamList.isEmpty
                ? Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 4.h),
                  SvgPicture.asset(
                    Images.revenueImage,
                    width: 40.w,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    "You don’t have any revenue yet",
                    style: fontMedium.copyWith(
                        fontSize: 12.sp, color: AppColor.redColor),
                  ),
                ],
              ),
            )
                : loading
                ? const Loader()
            : MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: FutureBuilder(
                  future: futureData,
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const Loader();
                    } if(snapshot.connectionState == ConnectionState.done){
                      return ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (context, _){
                          return SizedBox(height: 1.5.h);
                        },
                        itemCount: revenueTeamList.length,
                        itemBuilder: (context, index){
                          return RevenueListCard(
                            revenueTeamList[index].logo.toString(),
                            revenueTeamList[index].paidPrice.toString(),
                            revenueTeamList[index].totalPrice.toString(),
                            revenueTeamList[index].bookingDate.toString(),
                            revenueTeamList[index].bookingSlotStart.toString(),
                            revenueTeamList[index].teamName.toString(),
                            revenueTeamList[index].paidStatus.toString(),
                          );
                        },
                      );
                    } else {
                      return const Loader();
                    }
                  }
                )),
          ),
        ],
      ),
    );
  }
}
