import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/team_provider.dart';
import '../../utils/colours.dart';
import '../../utils/styles.dart';

class TeamDetailData extends StatefulWidget {
  final String teamId;
  const TeamDetailData(this.teamId, {Key? key}) : super(key: key);

  @override
  State<TeamDetailData> createState() => _TeamDetailDataState();
}

class _TeamDetailDataState extends State<TeamDetailData> {

  String teamName = "", teamMobile = "", teamSecMobile = "";
  String capName = "", capMobile = "", capSecMobile = "";
  String vcName = "", vcMobile = "", vcSecMobile = "";
  String adminName = "", adminMobile = "", adminSecMobile = "";
  String upiId = '';
  List<String> qrcode = [];

  getTeamData() async {
    Provider.of<TeamProvider>(context, listen: false).viewTeam(widget.teamId)
        .then((value){
      teamName = value.teamDetails!.teamName.toString();
      teamMobile = value.teamDetails!.primaryContact.toString();
      teamSecMobile = value.teamDetails!.secondaryContact.toString();

      capName = value.teamDetails!.captainName.toString();
      capMobile = value.teamDetails!.captainPrimaryContact.toString();
      capSecMobile = value.teamDetails!.captainSecondaryContact.toString();

      vcName = value.teamDetails!.viceCaptainName.toString();
      vcMobile = value.teamDetails!.viceCaptainPrimaryContact.toString();
      vcSecMobile = value.teamDetails!.viceCaptainSecondaryContact.toString();

      adminName = value.teamDetails!.adminName.toString();
      adminMobile = value.teamDetails!.adminPrimaryContact.toString();
      adminSecMobile = value.teamDetails!.adminSecondaryContact.toString();
      upiId = value.teamDetails!.upiId.toString();
      qrcode.add(value.teamDetails!.qrCode.toString());
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTeamData();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: ListView(
        children: [
          //team
          SizedBox(
            width: double.infinity,
            child: Theme(
              data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent),
              child: ExpansionTile(
                initiallyExpanded: true,
                title: Text(
                  "Team Details",
                  style: fontMedium.copyWith(
                      fontSize: 12.sp,
                      color: AppColor.textColor),
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 5.w
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const FieldHeading("Team Name *", false),
                        SizedBox(height:1.h),
                        Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                            vertical: 1.5.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.lightColor,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Text(teamName,
                            style: fontRegular.copyWith(
                                fontSize: 10.sp,
                                color: AppColor.textColor
                            ),),
                        ),
                        SizedBox(height:2.h),
                        const FieldHeading("Team Mobile *", false),
                        SizedBox(height:1.h),
                        Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                            vertical: 1.5.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.lightColor,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Text(teamMobile,
                            style: fontRegular.copyWith(
                                fontSize: 10.sp,
                                color: AppColor.textColor
                            ),),
                        ),
                        SizedBox(height:2.h),
                        teamSecMobile == ""
                        ? const SizedBox()
                        : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const FieldHeading("Secondary Number", false),
                            SizedBox(height:1.h),
                            Container(
                              width: double.maxFinite,
                              padding: EdgeInsets.symmetric(
                                horizontal: 5.w,
                                vertical: 1.5.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.lightColor,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Text(teamSecMobile,
                                style: fontRegular.copyWith(
                                    fontSize: 10.sp,
                                    color: AppColor.textColor
                                ),),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h),
            child: const Divider(thickness: 1.0,),
          ),
          //captain
          SizedBox(
            width: double.infinity,
            child: Theme(
              data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent),
              child: ExpansionTile(
                initiallyExpanded: true,
                title: Text(
                  "Team Captain Details",
                  style: fontMedium.copyWith(
                      fontSize: 12.sp,
                      color: AppColor.textColor),
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 5.w
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const FieldHeading("Name *", false),
                        SizedBox(height:1.h),
                        Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                            vertical: 1.5.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.lightColor,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Text(capName,
                            style: fontRegular.copyWith(
                                fontSize: 10.sp,
                                color: AppColor.textColor
                            ),),
                        ),
                        SizedBox(height:2.h),
                        const FieldHeading("Mobile Number *", false),
                        SizedBox(height:1.h),
                        Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                            vertical: 1.5.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.lightColor,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Text(capMobile,
                            style: fontRegular.copyWith(
                                fontSize: 10.sp,
                                color: AppColor.textColor
                            ),),
                        ),
                        SizedBox(height:2.h),
                        capSecMobile == ""
                        ? const SizedBox()
                        : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const FieldHeading("Secondary Number", false),
                            SizedBox(height:1.h),
                            Container(
                              width: double.maxFinite,
                              padding: EdgeInsets.symmetric(
                                horizontal: 5.w,
                                vertical: 1.5.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.lightColor,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Text(capSecMobile,
                                style: fontRegular.copyWith(
                                    fontSize: 10.sp,
                                    color: AppColor.textColor
                                ),),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h),
            child: const Divider(thickness: 1.0,),
          ),
          //vice captain
          SizedBox(
            width: double.infinity,
            child: Theme(
              data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent),
              child: ExpansionTile(
                initiallyExpanded: true,
                title: Text(
                  "Team Vice Captain Details",
                  style: fontMedium.copyWith(
                      fontSize: 12.sp,
                      color: AppColor.textColor),
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 5.w
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const FieldHeading("Name *", false),
                        SizedBox(height:1.h),
                        Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                            vertical: 1.5.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.lightColor,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Text(vcName,
                            style: fontRegular.copyWith(
                                fontSize: 10.sp,
                                color: AppColor.textColor
                            ),),
                        ),
                        SizedBox(height:2.h),
                        const FieldHeading("Mobile Number *", false),
                        SizedBox(height:1.h),
                        Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                            vertical: 1.5.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.lightColor,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Text(vcMobile,
                            style: fontRegular.copyWith(
                                fontSize: 10.sp,
                                color: AppColor.textColor
                            ),),
                        ),
                        SizedBox(height:2.h),
                        vcSecMobile == ""
                        ? const SizedBox()
                        : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const FieldHeading("Secondary Number", false),
                            SizedBox(height:1.h),
                            Container(
                              width: double.maxFinite,
                              padding: EdgeInsets.symmetric(
                                horizontal: 5.w,
                                vertical: 1.5.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.lightColor,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Text(vcSecMobile,
                                style: fontRegular.copyWith(
                                    fontSize: 10.sp,
                                    color: AppColor.textColor
                                ),),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          adminName == "" && adminMobile == "" && adminSecMobile == ""
              ? const SizedBox()
              : Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h),
            child: const Divider(thickness: 1.0,),
          ),
          //admin
          adminName == "" && adminMobile == "" && adminSecMobile == ""
          ? const SizedBox()
          : SizedBox(
            width: double.infinity,
            child: Theme(
              data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent),
              child: ExpansionTile(
                initiallyExpanded: true,
                title: RichText(
                  text: TextSpan(
                      text: 'Team admin details',
                      style: fontMedium.copyWith(
                        color: AppColor.textColor,
                        fontSize: 12.sp,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: ' (Optional)',
                          style: fontRegular.copyWith(
                            color: AppColor.textMildColor,
                            fontSize: 12.sp,
                          ),
                        )
                      ]
                  ),
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 5.w
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        adminName == ""
                            ? const SizedBox()
                            : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const FieldHeading("Name", false),
                            SizedBox(height:1.h),
                            Container(
                              width: double.maxFinite,
                              padding: EdgeInsets.symmetric(
                                horizontal: 5.w,
                                vertical: 1.5.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.lightColor,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Text(adminName,
                                style: fontRegular.copyWith(
                                    fontSize: 10.sp,
                                    color: AppColor.textColor
                                ),),
                            ),
                            SizedBox(height:2.h),
                          ],
                        ),

                        adminMobile == ""
                            ? const SizedBox()
                            : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const FieldHeading("Mobile Number", false),
                            SizedBox(height:1.h),
                            Container(
                              width: double.maxFinite,
                              padding: EdgeInsets.symmetric(
                                horizontal: 5.w,
                                vertical: 1.5.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.lightColor,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Text(adminMobile,
                                style: fontRegular.copyWith(
                                    fontSize: 10.sp,
                                    color: AppColor.textColor
                                ),),
                            ),
                            SizedBox(height:2.h),
                          ],
                        ),

                        adminSecMobile == ""
                        ? const SizedBox()
                        : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const FieldHeading("Secondary Number", false),
                            SizedBox(height:1.h),
                            Container(
                              width: double.maxFinite,
                              padding: EdgeInsets.symmetric(
                                horizontal: 5.w,
                                vertical: 1.5.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.lightColor,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Text(adminSecMobile,
                                style: fontRegular.copyWith(
                                    fontSize: 10.sp,
                                    color: AppColor.textColor
                                ),),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h),
            child: const Divider(thickness: 1.0,),
          ),
          //payment details
          SizedBox(
            width: double.infinity,
            child: Theme(
              data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent),
              child: ExpansionTile(
                initiallyExpanded: true,
                title: Text(
                  "Payment details",
                  style: fontMedium.copyWith(
                      fontSize: 12.sp,
                      color: AppColor.textColor),
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 5.w
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const FieldHeading("QR Code *", false),
                        SizedBox(height:1.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 1.7.h,
                          ) + EdgeInsets.only(
                              left: 5.w, right: 3.w
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.lightColor,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(qrcode.isNotEmpty ? qrcode[0].split('/').last.toString() : "Select File",
                                  style: fontRegular.copyWith(
                                      fontSize: 10.sp,
                                      color: AppColor.textColor
                                  ),),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height:2.h),
                        const FieldHeading("UPI ID *", false),
                        SizedBox(height:1.h),
                        Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                            vertical: 1.5.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.lightColor,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Text(upiId,
                            style: fontRegular.copyWith(
                                fontSize: 10.sp,
                                color: AppColor.textColor
                            ),),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height:2.h),
        ],
      ),
    );
  }
}

class FieldHeading extends StatelessWidget {
  final String heading;
  final bool edit;
  const FieldHeading(this.heading, this.edit, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(heading,
      style: fontRegular.copyWith(
          fontSize: 10.sp,
          color: edit ? AppColor.iconColour : AppColor.textColor
      ),);
  }
}