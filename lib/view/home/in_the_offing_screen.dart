
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/offing_list_model.dart';
import '../../models/total_revenue-model.dart';
import '../../providers/booking_provider.dart';
import '../../providers/team_provider.dart';
import '../../utils/colours.dart';
import '../../utils/connectivity_status.dart';
import '../../utils/images.dart';
import '../../utils/scale_route.dart';
import '../../utils/styles.dart';

import '../widgets/loader.dart';
import '../widgets/no_internet_view.dart';
import 'ground_locations.dart';
import 'offing_detail_screen.dart';
import 'offings_list.dart';

class InTheOffing extends StatefulWidget {
  final List<OffingsList> offings;
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
  List<OffingsList> searchedList = [];

  setDelay() async {
    if(mounted){
      setState(() {
        loading = true;
      });
    }
    await Future.delayed(const Duration(seconds: 1));
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
      searchedList = widget.offings.where((match) => match.teamAName.toLowerCase().toString().contains(search.toLowerCase())
          || match.cityName.toLowerCase().toString().contains(search.toLowerCase())
          || match.teamBName.toLowerCase().toString().contains(search.toLowerCase())
          || match.groundName.toLowerCase().toString().contains(search.toLowerCase())
          || match.organizerName.toLowerCase().toString().contains(search.toLowerCase())
      ).toList();
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
      searchedList = widget.offings.where((match) => match.cityName.toLowerCase().toString().contains(value.toLowerCase())).toList();
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
    var platform = Theme.of(context).platform;
    bool isIOS = platform == TargetPlatform.iOS;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    if (connectionStatus == ConnectivityStatus.offline) {
      return const NoInternetView();
    }
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
                  top: isIOS ? statusBarHeight : 2.h + statusBarHeight,
                  bottom: 3.h
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
            widget.offings.isEmpty
                ? const SizedBox()
                : Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 5.w
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  locationFilter
                      ? const SizedBox()
                      : Expanded(
                    child: Container(
                      height: 5.h,
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                        vertical: 1.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.lightColor,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: searchController,
                                cursorColor: AppColor.secondaryColor,
                                onChanged: (value) {
                                  onSearchCategory(value);
                                  setState(() {
                                    if (value.isEmpty) {
                                      searching = false;
                                    }
                                    else{
                                      searching = true;
                                    }
                                  });
                                },
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none,
                                  hintText: "Search for grounds ...",
                                  hintStyle: fontRegular.copyWith(
                                      fontSize: 10.sp,
                                      color: AppColor.textMildColor
                                  ),),
                              ),
                            ),
                            searching
                                ? InkWell(
                                onTap: (){
                                  setState(() {
                                    searchController.clear();
                                    searching = false;
                                  });
                                  FocusScopeNode currentFocus = FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                },
                                child: Icon(Icons.close, color: AppColor.iconColour, size: 5.w,))
                                : SvgPicture.asset(Images.search, color: AppColor.iconColour, width: 3.5.w,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  locationFilter
                      ? const SizedBox()
                      : SizedBox(width: 5.w),
                  Bounceable(
                    onTap: (){
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      openGroundLocationBottomSheet();
                    },
                    child: Container(
                      height: 5.h,
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 1.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Row(
                        children: [
                          Consumer<TeamProvider>(
                              builder: (context, filter, child) {
                                return Text(filter.locationFilterCity == "" ? "Location" : filter.locationFilterCity,
                                  style: fontRegular.copyWith(
                                      fontSize: 10.5.sp,
                                      color: AppColor.textColor
                                  ),);
                              }
                          ),
                          SizedBox(width: 1.5.w),
                          Icon(Icons.keyboard_arrow_down, color: AppColor.textColor, size: 4.w,),
                        ],
                      ),
                    ),
                  ),
                  locationFilter
                      ? const Spacer()
                      : const SizedBox(),
                  !locationFilter
                      ? const SizedBox()
                      : Row(
                    children: [
                      SizedBox(width: 5.w),
                      Bounceable(
                        onTap: (){
                          setState((){
                            locationFilter = false;
                            searching = false;
                          });
                          Provider.of<TeamProvider>(context, listen: false).removeFilterCity();
                          setDelay();
                        },
                        child: Container(
                          height: 5.h,
                          padding: EdgeInsets.symmetric(
                            horizontal: 4.w,
                            vertical: 1.5.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.redColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Text("Clear filters",
                            style: fontRegular.copyWith(
                                fontSize: 10.5.sp,
                                color: AppColor.redColor
                            ),),
                        ),
                      ),
                    ],
                  ),
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
                            child: OffingsListView(
                                searchedList[index].bookingDate.toString(),
                                searchedList[index].bookingSlotStart.toString(),
                                searchedList[index].cityName.toString(),
                                searchedList[index].teamAName.toString(),
                                searchedList[index].teamBName.toString(),
                                offing,
                              searchedList[index].groundName.toString(),
                              searchedList[index].groundImage.toString(),
                              searchedList[index].organizerName.toString(),
                              searchedList[index].matchNumber.toString(),
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
                            child: OffingsListView(
                                widget.offings[index].bookingDate.toString(),
                                widget.offings[index].bookingSlotStart.toString(),
                                widget.offings[index].cityName.toString(),
                                widget.offings[index].teamAName.toString(),
                                widget.offings[index].teamBName.toString(),
                                offing,
                              widget.offings[index].groundName.toString(),
                              widget.offings[index].groundImage.toString(),
                              widget.offings[index].organizerName.toString(),
                              widget.offings[index].matchNumber.toString(),
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

  void openGroundLocationBottomSheet() {
    showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return const GroundLocations();
        }).then((value) {
      final city = Provider.of<TeamProvider>(context, listen: false).locationFilterCity;
      print("filter location city $city");
      if(city != ""){
        filterGroundsByCity(city);
      }
    });
  }

}
