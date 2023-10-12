import 'package:elevens_organizer/models/match_history_payment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/converter.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.matchHistoryPaid.isEmpty
        ? const SizedBox()
        : Padding(
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
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
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
            )
        ),
        Expanded(
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
              : MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: ListView.separated(
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
