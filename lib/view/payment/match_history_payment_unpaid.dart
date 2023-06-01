import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import 'organizer_battle_list_card.dart';

class MatchHistoryPaymentUnPaid extends StatefulWidget {
  const MatchHistoryPaymentUnPaid({Key? key}) : super(key: key);

  @override
  State<MatchHistoryPaymentUnPaid> createState() => _MatchHistoryPaymentUnPaidState();
}

class _MatchHistoryPaymentUnPaidState extends State<MatchHistoryPaymentUnPaid> {

  String firstDate = "";
  String lastDate = "";

  List<Map<String, dynamic>> organizerBattlePaidList = [
    {
      "image": Images.groundListImage1,
      "paid_price": "5000",
      "total_price": "5000",
      "date": "Aug 21, 2023",
      "time": "07:00 AM",
      'team': "Toss & Tails",
      "status": "Unpaid"
    },
    {
      "image": Images.groundListImage2,
      "paid_price": "5000",
      "total_price": "5000",
      "date": "Aug 21, 2023",
      "time": "07:00 PM",
      'team': "Dhoni CC",
      "status": "Unpaid"
    },
    {
      "image": Images.groundListImage3,
      "paid_price": "5000",
      "total_price": "5000",
      "date": "Aug 21, 2023",
      "time": "07:00 AM",
      'team': "Toss & Tails",
      "status": "Unpaid"
    },
    {
      "image": Images.groundListImage4,
      "paid_price": "5000",
      "total_price": "5000",
      "date": "Aug 21, 2023",
      "time": "07:00 PM",
      'team': "Dhoni CC",
      "status": "Unpaid"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 5.w, vertical: 2.5.h
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
            )
        ),
        Expanded(
          child: MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, _){
                return SizedBox(height: 1.5.h);
              },
              itemCount: organizerBattlePaidList.length,
              itemBuilder: (context, index){
                return OrganizerBattleListCard(
                  organizerBattlePaidList[index]["image"],
                  organizerBattlePaidList[index]["paid_price"],
                  organizerBattlePaidList[index]["total_price"],
                  organizerBattlePaidList[index]["date"],
                  organizerBattlePaidList[index]["time"],
                  organizerBattlePaidList[index]["team"],
                  organizerBattlePaidList[index]["status"],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class DateFilterContainer extends StatelessWidget {
  final String date;
  const DateFilterContainer(this.date, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 1.5.h,
      ),
      decoration: BoxDecoration(
        color: AppColor.lightColor,
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: Row(
        children: [
          Text(date,
            style: fontRegular.copyWith(
                fontSize: 12.sp,
                color: AppColor.textMildColor
            ),),
          const Spacer(),
          SvgPicture.asset(Images.calendarIcon, color: AppColor.secondaryColor, width: 5.w,),
        ],
      ),
    );
  }
}

