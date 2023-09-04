import 'dart:math';

import 'package:elevens_organizer/view/toss/toss_result_dialog.dart';
import 'package:elevens_organizer/view/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:sizer/sizer.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../models/today_matches_toss_model.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import '../widgets/snackbar.dart';

class Toss extends StatefulWidget {
  final String teamAName, teamAId,teamBName,teamBId,matchId,teamALogo,teamBLogo;
  const Toss(this.teamAName,this.teamAId,this.teamBName,this.teamBId,this.matchId, this.teamALogo,this.teamBLogo,  {Key? key}) : super(key: key);

  @override
  State<Toss> createState() => _TossState();
}

class _TossState extends State<Toss> with TickerProviderStateMixin{

  String? dropdownValue;
  List<String> teams = [];
  late TabController tabController;

  late AnimationController _controller;
  late Animation<double> _spinAnimation;

  String _tossResult = '';
  double height = 200.0;
  double width = 200.0;

  addTeam(){
    teams.add(widget.teamAName);
    teams.add(widget.teamBName);
    print(teams);
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    addTeam();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _spinAnimation = Tween<double>(begin: 0, end: 20).animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          if (_controller.value == 1.0) {
            setState(() {
              _tossResult = "head";
            });
          } else {
            _controller.reverse();
          }
        } else if (status == AnimationStatus.dismissed) {
          if (_controller.value == 0.0) {
            _controller.forward();
          }
        }
      });
    // tossHandle();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleToss() {
    setState(() {
      _tossResult = '';
    });

    _controller.reset();
    _controller.forward().then((_) {
      setState(() {
        final random = Random();
        _tossResult = random.nextBool() ? 'head' : 'tail';
      });
      if(_tossResult == "head"){
        tabController.animateTo(0);
      } else if(_tossResult == "tail"){
        tabController.animateTo(1);
      }
    });
  }

  tossHandle() async {
    _handleToss();
    await Future.delayed(const Duration(milliseconds: 150));
    setState(() {
      height = 190.0;
      width = 190.0;
    });
    _handleToss();
    await Future.delayed(const Duration(milliseconds: 150));
    setState(() {
      height = 220.0;
      width = 220.0;
    });
    _handleToss();
    await Future.delayed(const Duration(milliseconds: 150));
    setState(() {
      height = 245.0;
      width = 245.0;
    });
    _handleToss();
    await Future.delayed(const Duration(milliseconds: 150));
    setState(() {
      height = 270.0;
      width = 270.0;
    });
    _handleToss();
    await Future.delayed(const Duration(milliseconds: 150));
    setState(() {
      height = 245.0;
      width = 245.0;
    });
    _handleToss();
    await Future.delayed(const Duration(milliseconds: 150));
    setState(() {
      height = 220.0;
      width = 220.0;
    });
    _handleToss();
    await Future.delayed(const Duration(milliseconds: 150));
    setState(() {
      height = 190.0;
      width = 190.0;
    });
    _handleToss();
    await Future.delayed(const Duration(milliseconds: 50));
    setState(() {
      height = 150.0;
      width = 150.0;
    });
    _handleToss();
  }

  List<String> tabs = ['Heads', 'Tails'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: 64.h,
                child: ClipPath(
                  clipper: ProsteBezierCurve(
                    position: ClipPosition.bottom,
                    list: [
                      BezierCurveSection(
                        start: Offset(0, 58.h),
                        top: Offset(MediaQuery.of(context).size.width / 2, 64.h),
                        end: Offset(MediaQuery.of(context).size.width, 58.h),
                      ),
                    ],
                  ),
                  child: Image.asset(Images.pitchImage, fit: BoxFit.cover,),
                ),
              ),
              Positioned(
                child: SizedBox(
                  height: 64.h,
                  width: double.infinity,
                  child: ClipPath(
                    clipper: ProsteBezierCurve(
                      position: ClipPosition.bottom,
                      list: [
                        BezierCurveSection(
                          start: Offset(0, 58.h),
                          top: Offset(MediaQuery.of(context).size.width / 2, 64.h),
                          end: Offset(MediaQuery.of(context).size.width, 58.h),
                        ),
                      ],
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xff383838),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 7.h,
                left: 5.w,
                right: 5.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap:(){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back, color: AppColor.lightColor, size: 7.w,)),
                    Text("Toss",
                      style: fontMedium.copyWith(
                          fontSize: 16.sp,
                          color: AppColor.lightColor
                      ),),
                    SizedBox(width: 7.w,),
                  ],
                ),
              ),
              Positioned(
                top: 18.h,
                left: 5.w,
                right: 5.w,
                child: Text("${widget.teamAName}\nvs\n${widget.teamBName}",
                  textAlign: TextAlign.center,
                  style: fontMedium.copyWith(
                      fontSize: 20.sp,
                      color: AppColor.lightColor
                  ),),
              ),
              Positioned(
                top: 35.h,
                left: 5.w,
                right: 5.w,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.textColor,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: IgnorePointer(
                    child: TabBar(
                      isScrollable: false,
                      padding: EdgeInsets.symmetric(
                        horizontal: 1.w,
                        vertical: 0.5.h,
                      ),
                      controller: tabController,
                      indicator: BoxDecoration(
                        color: AppColor.lightColor,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      indicatorColor: Colors.transparent,
                      labelColor: AppColor.textColor,
                      labelStyle: fontMedium.copyWith(
                          fontSize: 14.sp
                      ),
                      unselectedLabelColor: AppColor.lightColor,
                      unselectedLabelStyle: fontMedium.copyWith(
                          fontSize: 14.sp
                      ),
                      tabs: tabs.map((String value){
                        return Tab(text: value,);
                      }).toList(),
                    ),
                  ),
                ),
              ),
              _tossResult == ""
              ? const SizedBox()
              : Positioned(
                top: 45.h,
                left: 5.w,
                right: 5.w,
                child: Container(
                    height: 5.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 1.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.lightColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: DropdownButton<String>(
                      onTap: (){

                      },
                      underline: const SizedBox(),
                      isExpanded: true,
                      hint: Text("Which team won ?",
                      style: fontRegular.copyWith(
                        color: AppColor.textMildColor,
                        fontSize: 10.sp
                      ),),
                      value: dropdownValue,
                      items: teams
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                              value,
                              style: fontMedium.copyWith(fontSize: 10.sp,color: AppColor.textColor)
                          ),
                        );
                      }).toList(),
                      // Step 5.
                      onChanged: (String? newValue) {
                        if(_tossResult == ""){
                          Dialogs.snackbar("Flip the coin, then choose the team", context, isError: true);
                        } else{
                          setState(() {
                            dropdownValue = newValue!;
                          });
                          showDialog(context: context,
                              builder: (BuildContext context){
                                return TossResultDialog(
                                    widget.teamALogo,
                                    widget.teamAName,
                                    widget.teamBLogo,
                                    widget.teamBName,
                                    widget.matchId,
                                    widget.teamAName == dropdownValue ? true : false,
                                    _tossResult
                                );
                              });
                        }
                      },
                    )
                ),
              ),
              Positioned(
                top: 55.h,
                child: Transform(
                  transform: Matrix4.rotationX(
                    _controller.value < 0.5
                        ? pi * _controller.value
                        : pi - pi * _controller.value,
                  )..rotateZ(_spinAnimation.value * pi / 360),
                  alignment: Alignment.center,
                  child: AnimatedContainer(
                    height: height,
                    width: width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                            image: AssetImage(
                              'assets/images/${_tossResult.isEmpty ? 'head' : _tossResult}.png',
                            )),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(-1, 1),
                              blurRadius: 7.0,
                              spreadRadius: 5.0),
                        ]),
                    duration: const Duration(milliseconds: 250),
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          SizedBox(height: 15.h),
          _tossResult != ""
          ? const SizedBox()
          : Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
            ),
            child: GestureDetector(
                onTap: (){
                  tossHandle();
                },
                child: const CustomButton(AppColor.iconColour, "Flip", AppColor.lightColor)),
          ),
          SizedBox(height: 5.h),
        ],
      ),
    );
  }
}
