import 'package:elevens_organizer/models/match_history_payment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/converter.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import '../widgets/reset_button.dart';
import '../widgets/snackbar.dart';
import '../widgets/submit_button.dart';
import 'organizer_battle_list_card.dart';

class MatchHistoryPaymentPaid extends StatefulWidget {
  final List<MatchHistory> matchHistoryPaid;
  final VoidCallback refresh;
  const MatchHistoryPaymentPaid(this.matchHistoryPaid, this.refresh, {Key? key}) : super(key: key);

  @override
  State<MatchHistoryPaymentPaid> createState() => _MatchHistoryPaymentPaidState();
}

class _MatchHistoryPaymentPaidState extends State<MatchHistoryPaymentPaid> {

  String firstDate = "";
  String lastDate = "";
  List<MatchHistory> filteredItems = [];
  bool filter = false;
  bool loading = false;

  static DateTime? _parseDateTime(String dateTimeString) {
    if (dateTimeString.isEmpty) return null;
    final parts = dateTimeString.split('-'); // Split using '-' instead of '/'
    if (parts.length != 3) return null;
    final day = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final year = int.tryParse(parts[2]);
    if (day == null || month == null || year == null) return null;
    return DateTime(year, month, day);
  }

  DateTime convertDate(String dateString){
    // Convert the date string to a DateTime object
    DateTime date = DateFormat("MMM dd, yyyy").parse(dateString);
    return date;
  }

  filterByDate() async {
    DateTime? startDate = _parseDateTime(firstDate.toString());
    DateTime? endDate = _parseDateTime(lastDate.toString());
    print(startDate);
    print(endDate);
    setState(() {
      filteredItems = widget.matchHistoryPaid.where((item) {
        return convertDate(item.bookingDate.toString()).isAfter(startDate!) && convertDate(item.bookingDate.toString()).isBefore(endDate!)
            || convertDate(item.bookingDate.toString()).isAtSameMomentAs(startDate) || convertDate(item.bookingDate.toString()).isAtSameMomentAs(endDate!) ;
      }).toList();
      print(filteredItems.length);
    });
    setState(() {
      loading = true;
    });
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.matchHistoryPaid.isEmpty
            ? const SizedBox()
            : Column(
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
                              initialEntryMode: DatePickerEntryMode.calendarOnly,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now().add(const Duration(days: 7)),
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
                              initialEntryMode: DatePickerEntryMode.calendarOnly,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now().add(const Duration(days: 7)),
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
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
              child: Row(
                children: [
                  !filter ? const SizedBox() : Expanded(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          filter = false;
                          firstDate= "";
                          lastDate = "";
                        });
                        // setDelay();
                      },
                      child: const ResetButton(),
                    ),
                  ),
                  !filter ? const SizedBox() : SizedBox(width: 3.w),
                  firstDate == "" || lastDate == ""
                      ? const SizedBox()
                      : Expanded(
                    child: GestureDetector(
                      onTap: (){
                        DateTime? startDate = _parseDateTime(firstDate.toString());
                        DateTime? endDate = _parseDateTime(lastDate.toString());
                        print(startDate);
                        print(endDate);
                        if(firstDate == "" || lastDate == ""){
                          Dialogs.snackbar("Choose both start & end date", context, isError: true);
                        } else if(startDate!.isAfter(endDate!)){
                          Dialogs.snackbar("Choose a proper start & end date", context, isError: true);
                        } else{
                          filterByDate();
                          setState(() {
                            filter = true;
                          });
                        }
                      },
                      child: const SubmitButton(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if(filter && filteredItems.isNotEmpty)...[
          Padding(
            padding: EdgeInsets.only(
                top: 2.h,
                bottom: 2.h,
                left: 5.w
            ),
            child: Text(
              "Results",
              style: fontBold.copyWith(
                  color: Colors.black,
                  fontSize: 12.sp),
            ),
          )
        ]
        else if(filter && filteredItems.isEmpty)...[
          Center(
            child: Padding(
              padding: EdgeInsets.only(
                  left: 5.w,
                  top: 5.h
              ),
              child: Text(
                "No Results found",
                style: fontMedium.copyWith(
                    color: AppColor.redColor,
                    fontSize: 12.sp),
              ),
            ),
          )
        ]
        else ...[
            const SizedBox()
          ],
        !filter
            ? Expanded(
          child: MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: widget.matchHistoryPaid.isEmpty
                ? Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 4.h),
                  Image.asset(Images.noMatches, width: 80.w, fit: BoxFit.cover,),
                  SizedBox(height: 3.h),
                  Text("You don’t have any paid list",
                    style: fontMedium.copyWith(
                        fontSize: 12.sp,
                        color: AppColor.redColor
                    ),),
                ],
              ),
            )
                : ListView.separated(
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, _){
                return SizedBox(height: 1.5.h);
              },
              itemCount: widget.matchHistoryPaid.length,
              itemBuilder: (context, index){
                return OrganizerBattleListCard(
                  widget.matchHistoryPaid[index].logo,
                  widget.matchHistoryPaid[index].paidPrice.toString(),
                  widget.matchHistoryPaid[index].totalPrice.toString(),
                  widget.matchHistoryPaid[index].bookingDate.toString(),
                  Converter().convertTo12HourFormat(widget.matchHistoryPaid[index].bookingSlotStart.toString()),
                  widget.matchHistoryPaid[index].teamName.toString(),
                  widget.matchHistoryPaid[index].paidStatus.toString(),
                  widget.matchHistoryPaid[index].matchId.toString(),
                  widget.matchHistoryPaid[index].teamId.toString(), widget.refresh,
                    widget.matchHistoryPaid[index].matchNumber.toString()
                );
              },
            ),
          ),
        )
        : Expanded(
          child: MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, _){
                return SizedBox(height: 1.5.h);
              },
              itemCount: filteredItems.length,
              itemBuilder: (context, index){
                return OrganizerBattleListCard(
                    filteredItems[index].logo,
                    filteredItems[index].paidPrice.toString(),
                    filteredItems[index].totalPrice.toString(),
                    filteredItems[index].bookingDate.toString(),
                    Converter().convertTo12HourFormat(filteredItems[index].bookingSlotStart.toString()),
                    filteredItems[index].teamName.toString(),
                    filteredItems[index].paidStatus.toString(),
                    filteredItems[index].matchId.toString(),
                    filteredItems[index].teamId.toString(), widget.refresh,
                    filteredItems[index].matchNumber.toString()
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
