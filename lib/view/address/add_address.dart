import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:geocoding/geocoding.dart' as geocoding;

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location_platform_interface/location_platform_interface.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/profile_provider.dart';
import '../../providers/team_provider.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import '../my_team/city_list_dialog.dart';
import '../my_team/create_team.dart';
import '../my_team/state_list_dialog.dart';
import '../widgets/custom_button.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {

  bool showFirst = true;
  bool loading = false;
  double initHeight = 70.h;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController houseController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();

  final Completer<GoogleMapController> _controller = Completer();
  LocationData? currentPosition;
  LatLng _latLong = const LatLng(12.9664127, 80.2154874);
  bool locating = false;
  geocoding.Placemark? _placeMark;
  late CameraPosition cameraPosition;
  String? street, subLocality, locality, postalCode, country;
  String? lat, long;

  getCityList(){
    Provider.of<TeamProvider>(context, listen: false).getCityList();
  }

  void openCitySheet(String stateBasedCityId) {
    Provider.of<TeamProvider>(context, listen: false).getStateBasedCityList(stateBasedCityId);
    showDialog(context: context,
        builder: (BuildContext context){
          return const CityListDialog();
        }
    );
  }

  getStateList(){
    Provider.of<TeamProvider>(context, listen: false).getStateList();
  }

  void openStateSheet() {
    showDialog(context: context,
        builder: (BuildContext context){
          return const StateListDialog();
        }
    );
  }

  getData() {
    _getUserLocation();
    _latLong = LatLng(
      _latLong.latitude,
      _latLong.longitude,
    );
    // if (kDebugMode) {
    //   print("lat_long: $lat $long");
    // }
  }

  _getUserLocation() async {
    // currentPosition = await _getLocationPermission();
    _requestLocationPermission();
    getUserAddress();
    _goToCurrentPosition(
        LatLng(currentPosition!.latitude!, currentPosition!.longitude!));
    if (kDebugMode) {
      print("lat_long : ${currentPosition?.latitude} + ${currentPosition
          ?.longitude}");
    }
  }

  Future<void> _requestLocationPermission() async {
    await Permission.location.request();
  }

  getUserAddress() async {
    List<geocoding.Placemark> placeMarks = await geocoding
        .placemarkFromCoordinates(_latLong.latitude, _latLong.longitude);
    print(_placeMark?.locality);
    setState(() {
      _placeMark = placeMarks.first;
      street = _placeMark?.street;
      locality = _placeMark?.locality;
      subLocality = _placeMark?.subLocality;
      postalCode = _placeMark?.postalCode;
      country = _placeMark?.country;
      lat = _latLong.latitude.toString();
      long = _latLong.longitude.toString();
      streetController.text =
      "${street.toString()}.";
      pinCodeController.text = postalCode.toString();
    });
  }


  Future<void> _goToCurrentPosition(LatLng latlng) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            bearing: 192.8334901395799,
            target: LatLng(latlng.latitude, latlng.longitude),
            //tilt: 59.440717697143555,
            zoom: 14.4746)
    ));
  }

  // Future<LocationData> _getLocationPermission() async {
  //   Location location = Location();
  //
  //   bool serviceEnabled;
  //   PermissionStatus permissionGranted;
  //   LocationData locationData;
  //
  //   serviceEnabled = await location.serviceEnabled();
  //   if (!serviceEnabled) {
  //     serviceEnabled = await location.requestService();
  //     if (!serviceEnabled) {
  //       return Future.error('Service not enabled');
  //     }
  //   }
  //
  //   permissionGranted = await location.hasPermission();
  //   if (permissionGranted == PermissionStatus.denied) {
  //     permissionGranted = await location.requestPermission();
  //     if (permissionGranted != PermissionStatus.granted) {
  //       return Future.error('Permission Denied');
  //     }
  //   }
  //
  //   locationData = await location.getLocation();
  //   return locationData;
  // }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                AnimatedContainer(
                  width: double.maxFinite,
                  height: initHeight,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      )
                  ),
                  duration: const Duration(milliseconds: 300),
                  child: GoogleMap(
                    gestureRecognizers: <
                        Factory <OneSequenceGestureRecognizer>>{
                      Factory <OneSequenceGestureRecognizer>(
                            () => EagerGestureRecognizer(),
                      ),
                    },
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    zoomControlsEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: _latLong,
                      zoom: 17,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    onCameraMove: (CameraPosition position) async {
                      cameraPosition = position;
                      locating = true;
                      _latLong = position.target;
                      if (kDebugMode) {
                        print("${_latLong.latitude}  ${_latLong.longitude}");
                      }
                    },
                    onCameraIdle: () async {
                      setState(() {
                        getUserAddress();
                        locating = false;
                      });
                    },
                  ),
                ),
                Positioned(
                  top: 2.h,
                  left: 5.w,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back, color: AppColor.textColor,
                        size: 7.w,)),
                ),
                Positioned(
                  top: 2.h,
                  child: Text("Add Address",
                    style: fontMedium.copyWith(
                        fontSize: 16.sp,
                        color: AppColor.textColor
                    ),),
                ),
                Positioned(
                  child: Icon(
                    Icons.my_location, color: AppColor.redColor, size: 8.w,),
                ),
              ],
            ),
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.symmetric(
                horizontal: 5.w,
                vertical: 3.h,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 4.w,
                vertical: 1.5.h,
              ),
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 3.w,
                      vertical: 1.5.h,
                    ),
                    decoration: const BoxDecoration(
                        color: Color(0xff333333),
                        shape: BoxShape.circle
                    ),
                    child: SvgPicture.asset(
                      Images.currentLocationImage,
                      color: AppColor.primaryColor, width: 6.w,),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Your Address",
                          style: fontMedium.copyWith(
                              fontSize: 12.sp,
                              color: AppColor.textColor
                          ),),
                        SizedBox(height: 0.5.h),
                        Text("$street, $subLocality, $locality",
                          style: fontRegular.copyWith(
                              fontSize: 10.sp,
                              color: AppColor.textColor
                          ),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (Widget child,
                      Animation<double> animation) {
                    final scaleAnimation = Tween<double>(
                      begin: 0.0,
                      end: 1.0,
                    ).animate(animation);

                    return ScaleTransition(
                      scale: scaleAnimation,
                      child: child,
                    );
                  },
                  child: showFirst
                      ? MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: ListView(
                      children: [

                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w
                          ),
                          child: Bounceable(
                              onTap: () {
                                setState(() {
                                  showFirst = !showFirst;
                                  initHeight = 25.h;
                                });
                              },
                              child: const CustomButton(
                                  AppColor.textColor, 'Confirm Location',
                                  AppColor.lightColor)),
                        ),
                      ],
                    ),
                  )
                      : Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 5.w
                    ),
                    child: Form(
                      key: _formKey,
                      child: MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
                        child: ListView(
                          children: [
                            Text("Add Address details",
                              style: fontMedium.copyWith(
                                  color: AppColor.textColor,
                                  fontSize: 15.sp
                              ),),
                            SizedBox(height: 4.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("House No / Flat No",
                                  style: fontRegular.copyWith(
                                      fontSize: 9.sp,
                                      color: AppColor.textColor
                                  ),),
                                SizedBox(height: 1.h),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5.w,
                                    vertical: 1.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColor.lightColor,
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: Center(
                                    child: TextFormField(
                                      controller: houseController,
                                      cursorColor: AppColor.secondaryColor,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Enter house/flat no';
                                        }
                                        return null;
                                      },
                                      style: fontRegular.copyWith(
                                          fontSize: 10.sp,
                                          color: AppColor.textColor
                                      ),
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        border: InputBorder.none,
                                        hintText: "Ex: 14/s1",
                                        hintStyle: fontRegular.copyWith(
                                            fontSize: 10.sp,
                                            color: AppColor.textMildColor
                                        ),),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Street name",
                                  style: fontRegular.copyWith(
                                      fontSize: 9.sp,
                                      color: AppColor.textColor
                                  ),),
                                SizedBox(height: 1.h),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5.w,
                                    vertical: 1.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColor.lightColor,
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: Center(
                                    child: TextFormField(
                                      controller: streetController,
                                      cursorColor: AppColor.secondaryColor,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Enter street name';
                                        }
                                        return null;
                                      },
                                      style: fontRegular.copyWith(
                                          fontSize: 10.sp,
                                          color: AppColor.textColor
                                      ),
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        border: InputBorder.none,
                                        hintText: "Ex: Sakthi nagar",
                                        hintStyle: fontRegular.copyWith(
                                            fontSize: 10.sp,
                                            color: AppColor.textMildColor
                                        ),),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Pincode",
                                  style: fontRegular.copyWith(
                                      fontSize: 9.sp,
                                      color: AppColor.textColor
                                  ),),
                                SizedBox(height: 1.h),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5.w,
                                    vertical: 1.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColor.lightColor,
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: Center(
                                    child: TextFormField(
                                      controller: pinCodeController,
                                      cursorColor: AppColor.secondaryColor,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Enter pincode';
                                        }
                                        return null;
                                      },
                                      style: fontRegular.copyWith(
                                          fontSize: 10.sp,
                                          color: AppColor.textColor
                                      ),
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.done,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        border: InputBorder.none,
                                        hintText: "Ex: 630606",
                                        hintStyle: fontRegular.copyWith(
                                            fontSize: 10.sp,
                                            color: AppColor.textMildColor
                                        ),),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const FieldHeading("State"),
                                SizedBox(height:1.h),
                                Consumer<TeamProvider>(
                                    builder: (context, team, child) {
                                      return InkWell(
                                        onTap: (){
                                          getStateList();
                                          openStateSheet();
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.w,
                                              vertical: 1.2.h
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColor.lightColor,
                                            borderRadius: BorderRadius.circular(30.0),
                                          ),
                                          child: Row(
                                            children: [
                                              Text(team.state,
                                                style: fontRegular.copyWith(
                                                    color: AppColor.textColor
                                                ),),
                                              const Spacer(),
                                              const Icon(Icons.arrow_drop_down_sharp, color: AppColor.textColor,)
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                ),
                                SizedBox(height: 2.h),
                                const FieldHeading("City"),
                                SizedBox(height:1.h),
                                Consumer<TeamProvider>(
                                    builder: (context, team, child) {
                                      return InkWell(
                                        onTap: (){
                                          openCitySheet(team.stateId);
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.w,
                                              vertical: 1.2.h
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColor.lightColor,
                                            borderRadius: BorderRadius.circular(30.0),
                                          ),
                                          child: Row(
                                            children: [
                                              Text(team.stateBasedCity,
                                                style: fontRegular.copyWith(
                                                    color: AppColor.textColor
                                                ),),
                                              const Spacer(),
                                              const Icon(Icons.arrow_drop_down_sharp, color: AppColor.textColor,)
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                ),
                              ],
                            ),
                            SizedBox(height: 4.h),
                            loading
                                ? const Center(
                              child: CircularProgressIndicator(),)
                                : Bounceable(
                                onTap: () {
                                  validate();
                                },
                                child: const CustomButton(
                                    AppColor.textColor, 'Save',
                                    AppColor.lightColor)),
                            SizedBox(height: 2.h),
                          ],
                        ),
                      ),
                    ),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }

  validate() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      Provider.of<ProfileProvider>(context, listen: false).saveGroundAddress(
          street.toString(), subLocality.toString(), locality.toString(),
          postalCode.toString(), lat.toString(), long.toString(), houseController.text.toString());
      setState(() {
        loading = false;
      });
      Navigator.pop(context);
    }
  }
}
