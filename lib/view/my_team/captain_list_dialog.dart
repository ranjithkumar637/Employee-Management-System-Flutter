import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/team_provider.dart';
import '../../utils/colours.dart';
import '../../utils/styles.dart';


class CaptainListDialog extends StatelessWidget {
  const CaptainListDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(BuildContext context){
    return Container(
      height: 40.h,
      padding: EdgeInsets.symmetric(
        horizontal: 3.w,
        vertical: 3.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        children: [
          Text("Captain List",
            style: fontMedium.copyWith(
                fontSize: 14.sp,
                color: AppColor.textColor
            ),),
          SizedBox(height: 2.h),
          const Divider(),
          SizedBox(height: 2.h),
          Expanded(
            child: Consumer<TeamProvider>(
                builder: (context, team, child) {
                  return Scrollbar(
                    thumbVisibility: true,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (context, _){
                        return SizedBox(height: 3.h);
                      },
                      itemCount: team.captainList.length,
                      itemBuilder: (context, index){
                        return InkWell(
                          onTap: (){
                            Provider.of<TeamProvider>(context, listen: false).storeCaptain(team.captainList[index].name.toString(), team.captainList[index].id.toString());
                            Navigator.pop(context);
                          },
                          child: Text(team.captainList[index].name.toString(),
                            style: fontRegular.copyWith(
                                color: AppColor.textColor,
                                fontSize: 12.sp
                            ),),
                        );
                      },
                    ),
                  );
                }
            ),
          ),
        ],
      ),
    );
  }
}
