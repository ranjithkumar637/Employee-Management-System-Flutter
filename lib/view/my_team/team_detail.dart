// import 'package:flutter/material.dart';
// import 'package:flutter_animator/animation/animation_preferences.dart';
// import 'package:flutter_animator/widgets/fading_entrances/fade_in_up.dart';
// import 'package:flutter_bounceable/flutter_bounceable.dart';
// import 'package:proste_bezier_curve/proste_bezier_curve.dart';
// import 'package:provider/provider.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../providers/booking_provider.dart';
// import '../../utils/colours.dart';
// import '../../utils/images.dart';
// import '../../utils/styles.dart';
//
// class TeamDetail extends StatefulWidget {
//   final String teamId, teamName;
//   const TeamDetail(this.teamId, this.teamName, {Key? key}) : super(key: key);
//
//   @override
//   State<TeamDetail> createState() => _TeamDetailState();
// }
//
// class _TeamDetailState extends State<TeamDetail> {
//
//   bool loading = false;
//
//   setDelay() async {
//     if(mounted){
//       setState(() {
//         loading = true;
//       });
//     }
//     getSquad();
//     await Future.delayed(const Duration(seconds: 1));
//     if(mounted){
//       setState(() {
//         loading = false;
//       });
//     }
//   }
//
//   getSquad(){
//     Provider.of<BookingProvider>(context, listen: false).getPlayersListOfTeam(widget.teamId);
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     setDelay();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.bgColor,
//       body: Consumer<BookingProvider>(
//         builder: (context, squad, child) {
//           return Column(
//             children: [
//               Stack(
//                 clipBehavior: Clip.none,
//                 alignment: Alignment.center,
//                 children: [
//                   SizedBox(
//                     width: double.infinity,
//                     height: 32.h,
//                     child: ClipPath(
//                       clipper: ProsteBezierCurve(
//                         position: ClipPosition.bottom,
//                         list: [
//                           BezierCurveSection(
//                             start: Offset(0, 22.h),
//                             top: Offset(MediaQuery.of(context).size.width / 2, 30.h),
//                             end: Offset(MediaQuery.of(context).size.width, 22.h),
//                           ),
//                         ],
//                       ),
//                       child: Image.asset(Images.pitchImage, fit: BoxFit.cover,),
//                     ),
//                   ),
//                   Positioned(
//                     child: SizedBox(
//                       width: double.infinity,
//                       height: 32.h,
//                       child: ClipPath(
//                         clipper: ProsteBezierCurve(
//                           position: ClipPosition.bottom,
//                           list: [
//                             BezierCurveSection(
//                               start: Offset(0, 22.h),
//                               top: Offset(MediaQuery.of(context).size.width / 2, 30.h),
//                               end: Offset(MediaQuery.of(context).size.width, 22.h),
//                             ),
//                           ],
//                         ),
//                         child: Container(
//                           decoration: const BoxDecoration(
//                             gradient: LinearGradient(
//                               begin: Alignment.topCenter,
//                               end: Alignment.bottomCenter,
//                               colors: [
//                                 Color(0xff333334),
//                                 Colors.transparent,
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     top: 5.h,
//                     left: 5.w,
//                     right: 5.w,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Bounceable(
//                           onTap:(){
//                             Navigator.pop(context);
//                           },
//                             child: Icon(Icons.arrow_back, color: AppColor.lightColor, size: 7.w,)),
//                         Text("Team",
//                           style: fontMedium.copyWith(
//                               fontSize: 16.sp,
//                               color: AppColor.lightColor
//                           ),),
//                         SizedBox(width: 7.w,),
//                       ],
//                     ),
//                   ),
//                   Positioned(
//                     top: 10.h,
//                     child: Column(
//                       children: [
//                         Stack(
//                           children: [
//                             Container(
//                               height: 13.h,
//                               width: 26.w,
//                               decoration: BoxDecoration(
//                                   border: Border.all(color: AppColor.imageBorderColor, width: 2),
//                                   shape: BoxShape.circle,
//                                   color: Colors.white,
//                                   image: const DecorationImage(
//                                       fit: BoxFit.cover,
//                                       image: AssetImage(Images.teamTopImage))
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 2.h),
//                         Text(widget.teamName,
//                           style: fontBold.copyWith(
//                               fontSize: 17.sp,
//                               color: AppColor.lightColor
//                           ),),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               Expanded(
//                 child: Container(
//                   margin: EdgeInsets.only(
//                     top: 1.h,
//                   ),
//                   decoration: const BoxDecoration(
//                       color: AppColor.lightColor,
//                       borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(20.0),
//                           topRight: Radius.circular(20.0)
//                       )
//                   ),
//                   child: FadeInUp(
//                     preferences: const AnimationPreferences(
//                         duration: Duration(milliseconds: 500)
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 5.w,
//                             vertical: 1.h,
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(height: 2.h),
//                               Text("Captain",
//                                 style: fontMedium.copyWith(
//                                     fontSize: 12.sp,
//                                     color: AppColor.secondaryColor
//                                 ),),
//                               SizedBox(height: 2.h),
//                               PlayerListCard(
//                                   squad.captainData.captainName.toString(),
//                                   squad.captainData.captainRole.toString(),
//                                   "https://bcciplayerimages.s3.ap-south-1.amazonaws.com/playerheadshot/bcci/1000x1280/164.png",
//                                 false,
//                                 "", "",
//                               ),
//                             ],
//                           ),
//                         ),
//                         const Divider(),
//                         Padding(
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 5.w,
//                           ) + EdgeInsets.only(
//                               top: 2.h
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text("All Players",
//                                 style: fontMedium.copyWith(
//                                     fontSize: 12.sp,
//                                     color: AppColor.secondaryColor
//                                 ),),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: 2.h),
//                         Expanded(
//                           child: MediaQuery.removePadding(
//                             removeTop: true,
//                             context: context,
//                             child: Scrollbar(
//                               radius: const Radius.circular(3.0),
//                               child: ListView.separated(
//                                   addAutomaticKeepAlives: false,
//                                   addRepaintBoundaries: false,
//                                   shrinkWrap: true,
//                                   physics: const BouncingScrollPhysics(),
//                                   separatorBuilder: (context, _){
//                                     return const Divider();
//                                   },
//                                   itemCount: squad.teamPlayerList.length,
//                                   itemBuilder: (context, index){
//                                     return Padding(
//                                       padding: EdgeInsets.symmetric(
//                                         horizontal: 5.w,
//                                         vertical: 1.h,
//                                       ),
//                                       child: Bounceable(
//                                           onTap: (){
//                                             Navigator.pushNamed(context, 'profile_screen');
//                                           },
//                                           child: PlayerListCard(
//                                               squad.teamPlayerList[index].playerName.toString(),
//                                               squad.teamPlayerList[index].playerRole.toString(),
//                                               "https://bcciplayerimages.s3.ap-south-1.amazonaws.com/playerheadshot/bcci/1000x1280/164.png",
//                                             true,
//                                             squad.teamPlayerList[index].teamPlayerTableId.toString(),
//                                             squad.teamPlayerList[index].teamId.toString()
//                                           )),
//                                     );
//                                   }
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         }
//       ),
//     );
//   }
// }
