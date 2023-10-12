import 'package:cached_network_image/cached_network_image.dart';
import 'package:elevens_organizer/providers/payment_info_provider.dart';
import 'package:elevens_organizer/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/colours.dart';
import '../../../../utils/images.dart';
import '../../../../utils/styles.dart';
import '../widgets/snackbar.dart';
import 'add_amount_dialog_box.dart';

class OrganizerBattleListCard extends StatelessWidget {
  final String image, paidPrice, totalPrice, date, time, team, status, matchId, teamId, matchNumber;
  final VoidCallback refresh;
  const OrganizerBattleListCard(this.image, this.paidPrice, this.totalPrice, this.date, this.time, this.team, this.status, this.matchId, this.teamId, this.refresh, this.matchNumber,
      {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(paidPrice);
    return Bounceable(
      onTap: (){
        // Navigator.pushNamed(context, "payment_info_detail_screen");
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 5.w,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 3.w,
          vertical: 1.5.h,
        ),
        decoration: BoxDecoration(
          color: AppColor.lightColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CachedNetworkImage(
                  imageUrl: "${AppConstants.imageBaseUrl}${AppConstants.imageBaseUrlTeam}$image", fit: BoxFit.cover, width: 28.w, height: 14.h,
                  errorWidget: (context, url, widget){
                    return Image.asset(Images.createTeamBg, fit: BoxFit.cover, width: 28.w, height: 14.h,);
                  },
                )),
            SizedBox(width: 4.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("#$matchNumber",
                        style: fontBold.copyWith(
                            fontSize: 11.sp,
                            color: AppColor.matchNumberColor
                        ),),
                      status == "0"
                          ? InkWell(
                          onTap: (){
                            showPopupMenu(context, paidPrice, totalPrice, team);
                          },
                          child: Icon(Icons.more_vert_rounded, color: AppColor.textColor, size: 5.w,))
                          : const SizedBox(),
                    ],
                  ),
                  SizedBox(height: 0.5.h),
                  Text(team,
                    style: fontMedium.copyWith(
                        fontSize: 12.sp,
                        color: AppColor.textColor
                    ),),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 0.8.w,
                              vertical: 0.4.h,
                            ),
                            decoration: BoxDecoration(
                                color: AppColor.iconBgColor,
                                shape: BoxShape.circle
                            ),
                            child: SvgPicture.asset(Images.calendarIcon, color: AppColor.iconColour, width: 3.5.w,),
                          ),
                          SizedBox(width: 3.w),
                          Text(date,
                            style: fontMedium.copyWith(
                                fontSize: 9.sp,
                                color: AppColor.textColor
                            ),),
                        ],
                      ),
                      SizedBox(width: 2.w),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 0.8.w,
                              vertical: 0.4.h,
                            ),
                            decoration: BoxDecoration(
                                color: AppColor.iconBgColor,
                                shape: BoxShape.circle
                            ),
                            child: Icon(Icons.access_time, color: AppColor.iconColour, size: 3.5.w,),
                          ),
                          SizedBox(width: 3.w),
                          Text(time,
                            style: fontMedium.copyWith(
                                fontSize: 9.sp,
                                color: AppColor.textColor
                            ),),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("₹ ",
                        style: fontMedium.copyWith(
                            fontSize: 9.sp,
                            color: AppColor.textMildColor
                        ),),
                      Text("$paidPrice / $totalPrice",
                        style: fontMedium.copyWith(
                            fontSize: 12.sp,
                            color: AppColor.textColor
                        ),),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.w,
                          vertical: 0.4.h
                        ),
                        decoration: BoxDecoration(
                          color: status == "1" ? const Color(0xff57BB8A) : status == "0" ? const Color(0xffE67C73) : null,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Center(
                          child: Text(status == "1" ? "Paid" : status == "0" ? "Unpaid" : "",
                            style: fontRegular.copyWith(
                                color: AppColor.lightColor,
                                fontSize: 10.sp
                            ),),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showPopupMenu(BuildContext context, String paidPrice, String totalPrice, String team) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
        button.localToGlobal(button.size.topRight(Offset.zero), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    final List<PopupMenuEntry<String>> items = [
      PopupMenuItem<String>(
        value: 'item1',
        child: InkWell(
          onTap: (){
            showDialog(context: context,
                builder: (BuildContext context){
                  return AddAmountDialogBox(
                      paidPrice, totalPrice, team, matchId, teamId, refresh
                  );
                }
            );
          },
          child: Row(
            children: [
              Text('Record Payment',
                style: fontRegular.copyWith(
                    color: AppColor.textColor
                ),),
              const Spacer(),
              Icon(Icons.keyboard_arrow_right, color: AppColor.textColor, size: 5.w,)
            ],
          ),
        ),
      ),
      PopupMenuItem<String>(
        value: 'item2',
        child: InkWell(
          onTap: (){
            PaymentInfoProvider().requestPayment(teamId, matchId)
                .then((value) {
                if(value.status == true){
                  Dialogs.snackbar(value.message.toString(), context, isError: false);
                  Navigator.pop(context);
                  refresh();
                } else if(value.status == false){
                  Dialogs.snackbar(value.message.toString(), context, isError: true);
                } else {
                  Dialogs.snackbar("Something went wrong. Please try again.", context, isError: true);
                }
            });
          },
          child: Row(
            children: [
              Text('Request Payment',
                style: fontRegular.copyWith(
                    color: AppColor.textColor
                ),),
              const Spacer(),
              Icon(Icons.keyboard_arrow_right, color: AppColor.textColor, size: 5.w,)
            ],
          ),
        ),
      ),
    ];

    showMenu<String>(
      context: context,
      position: position,
      items: items,
    ).then((selectedValue) {
      if (selectedValue != null) {
        print('Selected: $selectedValue');
      }
    });
  }


}
