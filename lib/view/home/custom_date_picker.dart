import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/profile_provider.dart';
import '../../utils/colours.dart';
import '../../utils/styles.dart';
import '../widgets/snackbar.dart';

class CustomDatePicker extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  final Function(bool) enableBooking;
  final double itemWidth;

  const CustomDatePicker(
      {Key? key, required this.onDateSelected, required this.itemWidth, required this.enableBooking})
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
  bool isSelected = false;

  Future<void> _scrollToIndex(int selectedIndex) async {
    await Future.delayed(const Duration(seconds: 1));
    _scrollController.jumpTo((widget.itemWidth * selectedIndex) - 42.w);
  }

  @override
  void initState() {
    super.initState();
    dates = getDates();
    selectedIndex = dates.indexWhere((date) => isToday(date));
    // checkWhetherSlotTime();
    _scrollToIndex(selectedIndex);
  }

  void checkWhetherSlotTime() {
    dates = getDates();
    final ground = Provider.of<ProfileProvider>(context, listen: false);
    print(dates);
    bool isSlotDate = false;
    for(int i = 0; i< dates.length; i++){
      isSlotDate = ground.slotList.any((slot) {
        final slotDate = DateTime.parse(slot.date.toString());
        return slotDate.isAfter(DateTime.now().subtract(const Duration(days: 1))) && slot.date == dates[i].toString().split(' ')[0];
      });
      print("is slot date $isSlotDate");
    }
    widget.enableBooking(isSlotDate);
  }


  List<DateTime> getDates() {
    List<DateTime> dates = [];
    DateTime currentDate = DateTime.now();

    // Calculate the difference in days from Monday (1) to the current weekday
    int daysUntilMonday = (currentDate.weekday - DateTime.monday + 7) % 7;

    DateTime startDate = currentDate.subtract(Duration(days: daysUntilMonday));
    DateTime endDate = startDate.add(const Duration(days: 6)); // Saturday is 6 days from Monday

    for (DateTime date = startDate; date.isBefore(endDate.add(const Duration(days: 1))); date = date.add(const Duration(days: 1))) {
      dates.add(date);
    }

    return dates;
  }

  bool isPreviousDay(DateTime date) {
    DateTime now = DateTime.now();
    return date.isBefore(now.subtract(const Duration(days: 1)));
  }

  bool isToday(DateTime date) {
    DateTime now = DateTime.now();
    return date.day == now.day &&
        date.month == now.month &&
        date.year == now.year;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
        builder: (context, ground, child) {
          return SizedBox(
            height: 13.h,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
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
                      final isSlotDate = ground.slotList.any((slot) {
                        final slotDate = DateTime.parse(slot.date.toString());
                        return slotDate.isAfter(DateTime.now().subtract(const Duration(days: 1))) && slot.date == date.toString().split(' ')[0];
                      });
                      return Bounceable(
                        onTap: () async {
                          if(!isSlotDate){
                            widget.enableBooking(false);
                            Dialogs.snackbar("Slot not available", context, isError: true);
                          } else{
                            widget.onDateSelected(dates[index]);
                            widget.enableBooking(true);
                            setState(() {
                              selectedIndex = index;
                            });
                            // await Future.delayed(const Duration(seconds: 1));
                            // setState(() {
                            //   isSelected = index == selectedIndex;
                            // });
                          }
                        },
                        child: Container(
                          width: widget.itemWidth,
                          decoration: BoxDecoration(
                            color: isSelected && isSlotDate ? AppColor.datePickerColor : isSelected && !isSlotDate ? Colors.grey : Colors.transparent,
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
                                  color: isPreviousDay(dates[index])
                                      ? AppColor.hintFadeColour
                                      : isSelected
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
                                      color: isPreviousDay(dates[index])
                                          ? AppColor.hintFadeColour
                                          :  isSelected ? AppColor.lightColor : AppColor.textColor,
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
                                style:  fontRegular.copyWith(
                                  color: isPreviousDay(dates[index])
                                      ? AppColor.hintFadeColour
                                      : isSelected
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
    );
  }

}
