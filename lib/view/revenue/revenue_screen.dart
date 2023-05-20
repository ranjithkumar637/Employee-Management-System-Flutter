import 'package:elevens_organizer/view/revenue/revenue_list_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import '../my_matches/match_history.dart';
import '../widgets/revenue_refer_data_box.dart';

class RevenueScreen extends StatefulWidget {
  const RevenueScreen({Key? key}) : super(key: key);

  @override
  State<RevenueScreen> createState() => _RevenueScreenState();
}

class _RevenueScreenState extends State<RevenueScreen> {

  String firstDate = "";
  String lastDate = "";

  List<Map<String, dynamic>> revenueTeamList = [
    {
      "image": Images.groundListImage1,
      "paid_price": "5000",
      "total_price": "5000",
      "date": "Aug 21, 2023",
      "time": "07:00 AM",
      "status": "Paid",
      "team_name": "Toss & Tails"
    },
    {
      "image": Images.groundListImage1,
      "paid_price": "5000",
      "total_price": "5000",
      "date": "Aug 21, 2023",
      "time": "07:00 PM",
      "status": "Paid",
      "team_name": "Dhoni CC"
    }
  ];

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
                GestureDetector(
                    onTap:(){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back, color: AppColor.textColor, size: 7.w,)),
                Text("Revenue",
                  style: fontMedium.copyWith(
                      fontSize: 16.sp,
                      color: AppColor.textColor
                  ),),
                SizedBox(width: 7.w,),
              ],
            ),
          ),
          const RevenueReferDataBox("250000", 2),
          Padding(
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
                          lastDate: DateTime(2100),
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
                          lastDate: DateTime(2100),
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
            child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context, _){
                    return SizedBox(height: 1.5.h);
                  },
                  itemCount: revenueTeamList.length,
                  itemBuilder: (context, index){
                    return RevenueListCard(
                      revenueTeamList[index]["image"],
                      revenueTeamList[index]["paid_price"],
                      revenueTeamList[index]["total_price"],
                      revenueTeamList[index]["date"],
                      revenueTeamList[index]["time"],
                      revenueTeamList[index]["team_name"],
                      revenueTeamList[index]["status"],
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }
}
