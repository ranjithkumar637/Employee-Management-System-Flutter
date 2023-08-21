import 'package:cached_network_image/cached_network_image.dart';
import 'package:elevens_organizer/utils/images.dart';
import 'package:elevens_organizer/view/toss/toss_summary_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../providers/booking_provider.dart';
import '../../utils/app_constants.dart';
import '../../utils/colours.dart';
import '../../utils/styles.dart';
import '../widgets/snackbar.dart';

class TossResultDialog extends StatefulWidget {
  final String teamALogo, teamAName, teamBLogo, teamBName, matchId;
  final bool whoWon;
  const TossResultDialog(this.teamALogo,this.teamAName,this.teamBLogo,this.teamBName, this.matchId, this.whoWon, {Key? key}) : super(key: key);

  @override
  State<TossResultDialog> createState() => _TossResultDialogState();
}

class _TossResultDialogState extends State<TossResultDialog> {

  bool selectedTeamA = false;
  bool selectedTeamB = false;
  bool loading = false;

  bool batting = false;
  bool bowling = false;

  fixWonTeam(){
    if(widget.whoWon == true){
      setState(() {
        selectedTeamA = true;
      });
    } else {
      setState(() {
        selectedTeamB = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fixWonTeam();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(
        horizontal: 5.w
      ),
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(BuildContext context){
    return Container(
      height: 70.h,
      padding: EdgeInsets.symmetric(
        horizontal: 4.w,
        vertical: 3.h,
      ),
      decoration: BoxDecoration(
        color: AppColor.lightColor,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Column(
        children: [
          Text("Who won the Toss?",
            style: fontMedium.copyWith(
                fontSize: 16.sp,
                color: AppColor.textColor
            ),),
          SizedBox(height: 2.h),
          Row(
            children: [
              Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 3.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                        color: selectedTeamA ? AppColor.primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: AppColor.primaryColor)
                    ),
                    child: Column(
                      children: [
                        ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: "${
                                AppConstants.imageBaseUrl
                            }${AppConstants.imageBaseUrlTeam}${widget.teamALogo}",
                            errorWidget: (context, url, error) => Icon(Icons.person_outline_rounded, size: 4.w,),
                            fit: BoxFit.cover,
                            width: 20.w,
                            height: 9.h,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(widget.teamAName,
                          style: fontMedium.copyWith(
                              fontSize: 12.sp,
                              color: AppColor.textColor
                          ),),
                      ],
                    ),
                  )),
              SizedBox(width: 3.w),
              Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 3.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                        color: selectedTeamB ? AppColor.primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: AppColor.primaryColor)
                    ),
                    child: Column(
                      children: [
                        ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: "${
                                AppConstants.imageBaseUrl
                            }${AppConstants.imageBaseUrlTeam}${widget.teamBLogo}",
                            errorWidget: (context, url, error) => Icon(Icons.person_outline_rounded, size: 4.w,),
                            fit: BoxFit.cover,
                            width: 20.w,
                            height: 9.h,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(widget.teamBName,
                          style: fontMedium.copyWith(
                              fontSize: 12.sp,
                              color: AppColor.textColor
                          ),),
                      ],
                    ),
                  )),
            ],
          ),
          SizedBox(height: 4.h),
          Text("Choose to?",
            style: fontMedium.copyWith(
                fontSize: 14.sp,
                color: AppColor.textColor
            ),),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Bounceable(
                onTap: (){
                  setState(() {
                    batting = true;
                    bowling = false;
                  });
                },
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 25.w, height: 12.5.h,
                          padding: EdgeInsets.symmetric(
                            horizontal: 2.w,
                            vertical: 1.h,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColor.primaryColor)
                          ),
                          child: SvgPicture.asset(Images.battingImage),
                        ),
                        Positioned(
                          top: 0.0,
                          right: 0.0,
                          child: batting ? Icon(Icons.check_circle, color: AppColor.primaryColor, size: 7.w,) : const SizedBox(),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Text("Batting",
                      style: fontMedium.copyWith(
                          fontSize: 14.sp,
                          color: AppColor.textColor
                      ),),
                  ],
                ),
              ),
              Bounceable(
                onTap: (){
                  setState(() {
                    batting = false;
                    bowling = true;
                  });
                },
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 25.w, height: 12.5.h,
                          padding: EdgeInsets.symmetric(
                            horizontal: 2.w,
                            vertical: 1.h,
                          ),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColor.primaryColor)
                          ),
                          child: SvgPicture.asset(Images.bowlingImage),
                        ),
                        Positioned(
                          top: 0.0,
                          right: 0.0,
                          child: bowling ? Icon(Icons.check_circle, color: AppColor.primaryColor, size: 7.w,) : const SizedBox(),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Text("Bowling",
                      style: fontMedium.copyWith(
                          fontSize: 14.sp,
                          color: AppColor.textColor
                      ),),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              loading
              ? const Center(
                child: CircularProgressIndicator(),
              )
              : Bounceable(
                onTap: (){
                  setState(() {
                    loading = true;
                  });
                  BookingProvider().tossWonBy(
                    widget.matchId,
                    selectedTeamA ? "team_a" : "team_b",
                    batting ? "Batting" : "Bowling",
                  ).then((value) {
                    if(value.status==true){
                      setState(() {
                        loading = false;
                      });
                      Navigator.pop(context);
                      showDialog(context: context,
                          builder: (BuildContext context){
                            return TossSummaryDialog(
                              value.message.toString(),
                                widget.whoWon == true ? widget.teamALogo : widget.teamBLogo
                            );
                          });
                    }
                    else if (value.status==false){
                      setState(() {
                        loading = false;
                      });
                      Dialogs.snackbar(value.message.toString(),context);
                    }
                    else{
                      setState(() {
                        loading = false;
                      });
                      Dialogs.snackbar("Something Went Wrong",context, isError: true);
                    }
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 7.w,
                    vertical: 1.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.textColor,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Center(
                    child: Text("Save",
                      style: fontRegular.copyWith(
                          color: AppColor.lightColor,
                          fontSize: 11.sp
                      ),),
                  ),
                ),
              ),
              SizedBox(width: 5.w),
            ],
          ),
        ],
      ),
    );
  }

}
