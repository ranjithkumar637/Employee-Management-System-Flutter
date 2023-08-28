
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/total_revenue-model.dart';
import '../../providers/booking_provider.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/scale_route.dart';
import '../../utils/styles.dart';

import '../widgets/loader.dart';
import 'offing_detail_screen.dart';
import 'offings_list.dart';

class InTheOffing extends StatefulWidget {
  final List<Offings> offings;
  const InTheOffing(this.offings, {Key? key}) : super(key: key);

  @override
  State<InTheOffing> createState() => _InTheOffingState();
}

class _InTheOffingState extends State<InTheOffing> {

  bool loading = false;
  TextEditingController searchController = TextEditingController();

  bool searching = false;
  bool isResultEmpty = false;
  String searchedText = "";
  bool locationFilter = false;
  List<Offings> searchedList = [];

  setDelay() async {
    if(mounted){
      setState(() {
        loading = true;
      });
    }
    await Future.delayed(const Duration(seconds: 2));
    if(mounted){
      setState(() {
        loading = false;
      });
    }
  }

  onSearchCategory(String search) {
    setState(() {
      searching = true;
      searchedText = search;
      searchedList = widget.offings.where((match) => match.teamAName!.toLowerCase().toString().contains(search.toLowerCase())
          || match.cityName!.toLowerCase().toString().contains(search.toLowerCase())).toList();
      if (searchedList.isEmpty) {
        setState(() {
          isResultEmpty = true;
        });
      } else {
        setState(() {
          isResultEmpty = false;
        });
      }
      searching = false;
    });
  }

  filterGroundsByCity(String value) {
    print(value);
    setState(() {
      locationFilter = true;
      searching = true;
      searchedText = value;
      searchedList = widget.offings.where((match) => match.cityName!.toLowerCase().toString().contains(value.toLowerCase())).toList();
      print(searchedList);
      if (searchedList.isEmpty) {
        setState(() {
          isResultEmpty = true;
        });
      } else {
        setState(() {
          isResultEmpty = false;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setDelay();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 3.w
              ) + EdgeInsets.only(
                  top: 5.h, bottom: 3.h
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap:(){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back, color: AppColor.textColor, size: 7.w,)),
                  Text("In the Offing",
                    style: fontMedium.copyWith(
                        fontSize: 16.sp,
                        color: AppColor.textColor
                    ),),
                  SizedBox(width: 7.w,),
                ],
              ),
            ),
            SizedBox(height: 2.h),
            if(loading)...[
              const Loader(),
            ]
            else if(searching)...[
              if(isResultEmpty && searching)...[
                Padding(
                  padding: EdgeInsets.only(top: 5.h),
                  child: Text(
                    "No results found",
                    style: fontBold.copyWith(
                        color: AppColor.redColor, fontSize: 14.sp),
                  ),
                )
              ]
              else if(!isResultEmpty && searching)...[
                //offing list
                Expanded(
                  child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (context, _){
                          return SizedBox(height: 1.5.h);
                        },
                        itemCount: searchedList.length,
                        itemBuilder: (context, index){
                          final offing = searchedList[index];
                          return Bounceable(
                            onTap:(){
                              Navigator.push(context, ScaleRoute(page: OffingDetailScreen(searchedList[index].matchId.toString(), offing)));
                            },
                            child: OffingsList(
                                searchedList[index].teamALogo.toString(),
                                searchedList[index].bookingDate.toString(),
                                searchedList[index].bookingSlotStart.toString(),
                                searchedList[index].cityName.toString(),
                                searchedList[index].teamAName.toString(),
                                searchedList[index].teamBName.toString(),
                                offing,
                              // searchedList[index].groundName.toString(),
                              // searchedList[index].groundImage.toString(),
                            ),
                          );
                        },
                      )),
                ),
              ]
            ]
            else if(isResultEmpty || !searching)...[
                //offing list
                Expanded(
                  child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (context, _){
                          return SizedBox(height: 1.5.h);
                        },
                        itemCount: widget.offings.length,
                        itemBuilder: (context, index){
                          final offing = widget.offings[index];
                          return Bounceable(
                            onTap:(){
                              Navigator.push(context, ScaleRoute(page: OffingDetailScreen(widget.offings[index].matchId.toString(), offing)));
                            },
                            child: OffingsList(
                                widget.offings[index].teamALogo.toString(),
                                widget.offings[index].bookingDate.toString(),
                                widget.offings[index].bookingSlotStart.toString(),
                                widget.offings[index].cityName.toString(),
                                widget.offings[index].teamAName.toString(),
                                widget.offings[index].teamBName.toString(),
                                offing,
                              // widget.offings[index].groundName.toString(),
                              // widget.offings[index].groundImage.toString(),
                            ),
                          );
                        },
                      )),
                ),
              ],
          ],
        ),
      ),
    );
  }

}
