
import 'package:flutter/material.dart';
import 'package:flutter_animator/animation/animation_preferences.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_up.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/tn_city_list_model.dart';
import '../../providers/booking_provider.dart';
import '../../providers/team_provider.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import '../widgets/loader.dart';
import 'nearby_locations.dart';

class GroundLocations extends StatefulWidget {
  const GroundLocations({Key? key}) : super(key: key);

  @override
  State<GroundLocations> createState() => _GroundLocationsState();
}

class _GroundLocationsState extends State<GroundLocations> {

  double height = 85.h;
  Future<List<TnCity>>? futureData;
  List<TnCity> tnCityList = [];
  bool loading = false;
  final TextEditingController searchCityController = TextEditingController();

  bool searching = false;
  bool isResultEmpty = false;
  String searchedText = "";

  List<TnCity> searchedList = [];

  getTNCityList() async {
    setState((){
      loading = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    futureData = TeamProvider().getTNCityList().then((value) {
      setState(() {
        tnCityList = [];
        loading = false;
        tnCityList.addAll(value);
      });
      print(tnCityList);
      return tnCityList;
    });
  }

  onSearchCity(String search) {
    setState(() {
      searching = true;
      searchedText = search;
      searchedList = tnCityList.where((city) => city.cityName!.toLowerCase().toString().contains(search.toLowerCase())).toList();
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTNCityList();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          height = 90.h;
        });
        await Future.delayed(const Duration(milliseconds: 200))
            .then((value) {
          Navigator.pop(context);
        });
        return true;
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.maxFinite,
        height: height,
        decoration: const BoxDecoration(
            color: AppColor.lightColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 5.w
              ) + EdgeInsets.only(
                  top: 2.h
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap:() async {
                        setState(() {
                          height = 90.h;
                        });
                        await Future.delayed(const Duration(milliseconds: 200))
                            .then((value) {
                          Navigator.pop(context);
                        });
                      },
                      child: Icon(Icons.arrow_back, color: AppColor.textColor, size: 7.w,)),
                  Text("Location",
                    style: fontMedium.copyWith(
                        fontSize: 16.sp,
                        color: AppColor.textColor
                    ),),
                  SizedBox(width: 7.w,),
                ],
              ),
            ),
            SizedBox(height: 2.h),
            Container(
              height: 6.h,
              margin: EdgeInsets.symmetric(
                  horizontal: 5.w
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 5.w,
                vertical: 1.5.h,
              ),
              decoration: BoxDecoration(
                color: AppColor.textFieldBg1,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: searchCityController,
                      cursorColor: AppColor.secondaryColor,
                      onChanged: (value) {
                        onSearchCity(value);
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
                        hintText: "Search city",
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
                          searchCityController.clear();
                          searching = false;
                        });
                      },
                      child: Icon(Icons.close, color: AppColor.iconColour, size: 5.w,))
                      : SvgPicture.asset(Images.search, color: AppColor.iconColour, width: 3.5.w,),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h),
              child: const Divider(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 5.w
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Choose area",
                    style: fontRegular.copyWith(
                        fontSize: 11.sp,
                        color: AppColor.textMildColor
                    ),),
                  SizedBox(height: 1.h),
                  Text("All in TamilNadu",
                    style: fontMedium.copyWith(
                        fontSize: 12.sp,
                        color: AppColor.iconColour
                    ),),
                ],
              ),
            ),
            SizedBox(height: 2.h),
            if(loading)...[
              const Loader(),
            ]
            else if(searching)...[
              if(isResultEmpty && searching)...[
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 5.h),
                    child: Text(
                      "No city found",
                      style: fontBold.copyWith(
                          color: AppColor.redColor, fontSize: 14.sp),
                    ),
                  ),
                )
              ]
              else if(!isResultEmpty && searching)...[
                Expanded(
                  child: FadeInUp(
                    preferences: const AnimationPreferences(
                        duration: Duration(milliseconds: 400)
                    ),
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (context, _){
                        return SizedBox(height: 3.h);
                      },
                      itemCount: searchedList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Bounceable(
                          onTap:(){
                            Provider.of<TeamProvider>(context, listen: false).storeLocationFilterCity(searchedList[index].cityName.toString());
                            FocusScopeNode currentFocus = FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            Navigator.pop(context);
                          },
                          child: NearbyLocations(
                              searchedList[index].cityName.toString()
                          ),
                        );
                      },

                    ),
                  ),
                )
              ]
            ]
            else if(isResultEmpty || !searching)...[
                Expanded(
                  child: FutureBuilder(
                      future: futureData,
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting) {
                          return const Loader();
                        } if(snapshot.connectionState == ConnectionState.done) {
                          return ListView.separated(
                            separatorBuilder: (context, _){
                              return SizedBox(height: 3.h);
                            },
                            physics: const BouncingScrollPhysics(),
                            itemCount: tnCityList.length,
                            itemBuilder: (context, index){
                              return Bounceable(
                                onTap: (){
                                  Provider.of<TeamProvider>(context, listen: false).storeLocationFilterCity(tnCityList[index].cityName.toString());
                                  Navigator.pop(context);
                                },
                                child: NearbyLocations(
                                    tnCityList[index].cityName.toString()
                                ),
                              );
                            },
                          );
                        } else{
                          return const Loader();
                        }
                      }
                  ),
                ),
              ],
          ],
        ),
      ),
    );
  }
}

