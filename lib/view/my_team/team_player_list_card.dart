
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../providers/team_provider.dart';
import '../../../utils/colours.dart';
import '../../../utils/styles.dart';
import '../widgets/player_image.dart';
import '../widgets/player_name.dart';
import '../widgets/player_style.dart';

class TeamPlayerListCard extends StatelessWidget {
  final String playerName, style, playerImage, id, teamId, role;
  final bool showChangeRoleOption;
  final VoidCallback refreshList;
  const TeamPlayerListCard(this.playerName, this.style, this.playerImage, this.showChangeRoleOption, this.id, this.teamId, this.role, this.refreshList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PlayerImage(playerImage, 7.h, 14.w),
        SizedBox(width: 3.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PlayerName(playerName),
              SizedBox(height: 1.h),
              style == "" ? const SizedBox() : PlayerStyle(style)
            ],
          ),
        ),
        SizedBox(width: 3.w),
        showChangeRoleOption
        ? InkWell(
            onTap: (){
              // if(role == "vc"){
              //   showPopupMenu(context);
              // } else if(role == "admin"){
              //   showPopupMenu1(context);
              // } else if(role == "player"){
              //   showPopupMenu2(context);
              // }
            },
            child: Icon(Icons.more_vert_rounded, color: AppColor.textColor, size: 6.w,))
        : const SizedBox(),
      ],
    );
  }

  // void showPopupMenu(BuildContext context) {
  //   print("id-route $id team id-route $teamId");
  //   final RenderBox button = context.findRenderObject() as RenderBox;
  //   final RenderBox overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;
  //   final RelativeRect position = RelativeRect.fromRect(
  //     Rect.fromPoints(
  //       button.localToGlobal(Offset.zero, ancestor: overlay),
  //       button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
  //     ),
  //     Offset.zero & overlay.size,
  //   );
  //
  //   final List<PopupMenuEntry<String>> items = [
  //     PopupMenuItem<String>(
  //       value: 'item1',
  //       child: InkWell(
  //         onTap: (){
  //           TeamProvider().updatePlayerRole(id, "Admin", teamId)
  //               .then((value) {
  //             if(value.status == true){
  //               Dialogs.snackbar("$playerName is set as Admin", context, isError: false);
  //               Navigator.pop(context);
  //               refreshList();
  //             } else{
  //               Dialogs.snackbar(value.message.toString(), context, isError: true);
  //               Navigator.pop(context);
  //             }
  //           });
  //         },
  //         child: Row(
  //           children: [
  //             Text('Set as Admin',
  //               style: fontRegular.copyWith(
  //                   color: AppColor.textColor
  //               ),),
  //             const Spacer(),
  //             Icon(Icons.keyboard_arrow_right, color: AppColor.textColor, size: 5.w,)
  //           ],
  //         ),
  //       ),
  //     ),
  //     PopupMenuItem<String>(
  //       value: 'item2',
  //       child: InkWell(
  //         onTap: (){
  //           TeamProvider().updatePlayerRole(id, "Player", teamId)
  //               .then((value) {
  //             if(value.status == true){
  //               Dialogs.snackbar("$playerName is set as Player", context, isError: false);
  //               Navigator.pop(context);
  //               refreshList();
  //             } else{
  //               Dialogs.snackbar(value.message.toString(), context, isError: true);
  //               Navigator.pop(context);
  //             }
  //           });
  //         },
  //         child: Row(
  //           children: [
  //             Text('Set as Player',
  //               style: fontRegular.copyWith(
  //                   color: AppColor.textColor
  //               ),),
  //             const Spacer(),
  //             Icon(Icons.keyboard_arrow_right, color: AppColor.textColor, size: 5.w,)
  //           ],
  //         ),
  //       ),
  //     ),
  //   ];
  //
  //   showMenu<String>(
  //     context: context,
  //     position: position,
  //     items: items,
  //   ).then((selectedValue) {
  //     if (selectedValue != null) {
  //       print('Selected: $selectedValue');
  //     }
  //   });
  // }
  //
  // void showPopupMenu1(BuildContext context) {
  //   print("id-route $id team id-route $teamId");
  //   final RenderBox button = context.findRenderObject() as RenderBox;
  //   final RenderBox overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;
  //   final RelativeRect position = RelativeRect.fromRect(
  //     Rect.fromPoints(
  //       button.localToGlobal(Offset.zero, ancestor: overlay),
  //       button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
  //     ),
  //     Offset.zero & overlay.size,
  //   );
  //
  //   final List<PopupMenuEntry<String>> items = [
  //     PopupMenuItem<String>(
  //       value: 'item1',
  //       child: InkWell(
  //         onTap: (){
  //           TeamProvider().updatePlayerRole(id, "Vice Captain", teamId)
  //               .then((value) {
  //             if(value.status == true){
  //               Dialogs.snackbar("$playerName is set as Vice Captain", context, isError: false);
  //               Navigator.pop(context);
  //               refreshList();
  //             } else{
  //               Dialogs.snackbar(value.message.toString(), context, isError: true);
  //               Navigator.pop(context);
  //             }
  //           });
  //         },
  //         child: Row(
  //           children: [
  //             Text('Set as Vice Captain',
  //               style: fontRegular.copyWith(
  //                   color: AppColor.textColor
  //               ),),
  //             const Spacer(),
  //             Icon(Icons.keyboard_arrow_right, color: AppColor.textColor, size: 5.w,)
  //           ],
  //         ),
  //       ),
  //     ),
  //     PopupMenuItem<String>(
  //       value: 'item2',
  //       child: InkWell(
  //         onTap: (){
  //           TeamProvider().updatePlayerRole(id, "Player", teamId)
  //               .then((value) {
  //             if(value.status == true){
  //               Dialogs.snackbar("$playerName is set as Player", context, isError: false);
  //               Navigator.pop(context);
  //               refreshList();
  //             } else{
  //               Dialogs.snackbar(value.message.toString(), context, isError: true);
  //               Navigator.pop(context);
  //             }
  //           });
  //         },
  //         child: Row(
  //           children: [
  //             Text('Set as Player',
  //               style: fontRegular.copyWith(
  //                   color: AppColor.textColor
  //               ),),
  //             const Spacer(),
  //             Icon(Icons.keyboard_arrow_right, color: AppColor.textColor, size: 5.w,)
  //           ],
  //         ),
  //       ),
  //     ),
  //   ];
  //
  //   showMenu<String>(
  //     context: context,
  //     position: position,
  //     items: items,
  //   ).then((selectedValue) {
  //     if (selectedValue != null) {
  //       print('Selected: $selectedValue');
  //     }
  //   });
  // }
  //
  // void showPopupMenu2(BuildContext context) {
  //   print("id-route $id team id-route $teamId");
  //   final RenderBox button = context.findRenderObject() as RenderBox;
  //   final RenderBox overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;
  //   final RelativeRect position = RelativeRect.fromRect(
  //     Rect.fromPoints(
  //       button.localToGlobal(Offset.zero, ancestor: overlay),
  //       button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
  //     ),
  //     Offset.zero & overlay.size,
  //   );
  //
  //   final List<PopupMenuEntry<String>> items = [
  //     PopupMenuItem<String>(
  //       value: 'item1',
  //       child: InkWell(
  //         onTap: (){
  //           TeamProvider().updatePlayerRole(id, "Vice Captain", teamId)
  //               .then((value) {
  //             if(value.status == true){
  //               Dialogs.snackbar("$playerName is set as Vice Captain", context, isError: false);
  //               Navigator.pop(context);
  //               refreshList();
  //             } else{
  //               Dialogs.snackbar(value.message.toString(), context, isError: true);
  //               Navigator.pop(context);
  //             }
  //           });
  //         },
  //         child: Row(
  //           children: [
  //             Text('Set as Vice Captain',
  //               style: fontRegular.copyWith(
  //                   color: AppColor.textColor
  //               ),),
  //             const Spacer(),
  //             Icon(Icons.keyboard_arrow_right, color: AppColor.textColor, size: 5.w,)
  //           ],
  //         ),
  //       ),
  //     ),
  //     PopupMenuItem<String>(
  //       value: 'item2',
  //       child: InkWell(
  //         onTap: (){
  //           TeamProvider().updatePlayerRole(id, "Admin", teamId)
  //               .then((value) {
  //             if(value.status == true){
  //               Dialogs.snackbar("$playerName is set as Admin", context, isError: false);
  //               Navigator.pop(context);
  //               refreshList();
  //             } else{
  //               Dialogs.snackbar(value.message.toString(), context, isError: true);
  //               Navigator.pop(context);
  //             }
  //           });
  //         },
  //         child: Row(
  //           children: [
  //             Text('Set as Admin',
  //               style: fontRegular.copyWith(
  //                   color: AppColor.textColor
  //               ),),
  //             const Spacer(),
  //             Icon(Icons.keyboard_arrow_right, color: AppColor.textColor, size: 5.w,)
  //           ],
  //         ),
  //       ),
  //     ),
  //   ];
  //
  //   showMenu<String>(
  //     context: context,
  //     position: position,
  //     items: items,
  //   ).then((selectedValue) {
  //     if (selectedValue != null) {
  //       print('Selected: $selectedValue');
  //     }
  //   });
  // }
}
