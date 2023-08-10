import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/team_provider.dart';
import '../../utils/colours.dart';
import '../../utils/styles.dart';


class StateListDialog extends StatelessWidget {
  final bool fromOrganizer;
  const StateListDialog({Key? key, required this.fromOrganizer}) : super(key: key);

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
      height: 70.h,
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
          Text("State List",
            style: fontMedium.copyWith(
                fontSize: 14.sp,
                color: AppColor.textColor
            ),),
          SizedBox(height: 2.h),
          const Divider(),
          SizedBox(height: 2.h),
          Expanded(
            child: Consumer<TeamProvider>(
              builder: (context, state, child) {
                return Scrollbar(
                  thumbVisibility: true,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (context, _){
                      return SizedBox(height: 3.h);
                    },
                    itemCount: state.stateList.length,
                    itemBuilder: (context, index){
                      return InkWell(
                        onTap: (){
                          Provider.of<TeamProvider>(context, listen: false).storeState(state.stateList[index].name.toString(), state.stateList[index].id.toString());
                          Navigator.pop(context);
                        },
                        child: Text(state.stateList[index].name.toString(),
                        style: fontRegular.copyWith(
                          color: AppColor.textColor,
                          fontSize: 11.sp
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
