import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/styles.dart';

class CustomDatePicker extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  final double itemWidth;

  const CustomDatePicker(
      {Key? key, required this.onDateSelected, required this.itemWidth})
      : super(key: key);

  @override
  CustomDatePickerState createState() => CustomDatePickerState();
}

class CustomDatePickerState extends State<CustomDatePicker> {
  List<DateTime> dates = [];
  final _scrollController = ScrollController();
  int selectedIndex = 0;
  bool isDelivered = true;
  bool isUpcoming = false;
  bool isVacation = false;
  bool isHold = false;

  Future<void> _scrollToIndex(int selectedIndex) async {
    await Future.delayed(const Duration(seconds: 1));
    _scrollController.jumpTo((widget.itemWidth * selectedIndex) - 42.w);
  }

  @override
  void initState() {
    super.initState();
    dates = getDates();
    selectedIndex = dates.indexWhere((date) => isToday(date));
    _scrollToIndex(selectedIndex);
  }

  List<DateTime> getDates() {
    List<DateTime> dates = [];
    DateTime currentDate = DateTime.now();
    DateTime startDate = currentDate.subtract(const Duration(days: 3));
    DateTime endDate = currentDate.add(const Duration(days: 4));
    for (DateTime date = startDate;
        date.isBefore(endDate);
        date = date.add(const Duration(days: 1))) {
      dates.add(date);
    }
    return dates;
  }

  bool isToday(DateTime date) {
    DateTime now = DateTime.now();
    return date.day == now.day &&
        date.month == now.month &&
        date.year == now.year;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 13.h,
      // color: AppColor.primaryColor.withOpacity(0.05),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: dates.length,
              itemBuilder: (context, index) {
                final date = dates[index];
                final dayFormat = DateFormat('E');
                final dateFormat = DateFormat('d');
                final monthFormat = DateFormat('MMM');
                final day = dayFormat.format(date);
                final formattedDate = dateFormat.format(date);
                final formattedMonth = monthFormat.format(date);
                final isSelected = index == selectedIndex;

                return Bounceable(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                    widget.onDateSelected(dates[index]);
                  },
                  child: Container(
                    width: widget.itemWidth,
                    decoration: BoxDecoration(
                      color: isSelected ? AppColor.datePickerColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 1.h),
                        Text(
                          day,
                          style: fontRegular.copyWith(
                            color: isSelected
                                ? AppColor.lightColor
                                : AppColor.redColor,
                            fontSize: 10.sp,
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 0.5.w, vertical: 0.5.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Text(
                              formattedDate,
                              style: fontRegular.copyWith(
                                color: isSelected ? AppColor.lightColor : AppColor.textColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 13.sp,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          "$formattedMonth\n${date.year} ",
                          textAlign: TextAlign.center,
                          style: fontRegular.copyWith(
                            color: isSelected
                                ? AppColor.lightColor
                                : Colors.grey,
                            fontWeight: FontWeight.normal,
                            fontSize: 8.sp,
                          ),
                        ),
                        SizedBox(height: 1.h),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
