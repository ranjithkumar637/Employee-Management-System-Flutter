import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';

class BookingHistory extends StatefulWidget {
  const BookingHistory({Key? key}) : super(key: key);

  @override
  State<BookingHistory> createState() => _BookingHistoryState();
}

class _BookingHistoryState extends State<BookingHistory> {

  String firstDate = "";
  String lastDate = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 5.w, vertical: 2.h
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
        ],
      ),
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
                fontSize: 11.sp,
                color: AppColor.textMildColor
            ),),
          const Spacer(),
          SvgPicture.asset(Images.calendarIcon, color: AppColor.secondaryColor, width: 5.w,),
        ],
      ),
    );
  }
}

