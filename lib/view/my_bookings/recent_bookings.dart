import 'package:flutter/material.dart';
import 'package:flutter_animator/animation/animation_preferences.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_up.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../models/recent_booking_list_model.dart';
import '../../providers/booking_provider.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import '../widgets/loader.dart';
import 'booking_history.dart';
import 'bookings_card.dart';

class RecentBookings extends StatefulWidget {
  const RecentBookings({Key? key}) : super(key: key);

  @override
  State<RecentBookings> createState() => _RecentBookingsState();
}

class _RecentBookingsState extends State<RecentBookings> {


  Future<List<RecentBooking>>? futureData;
  bool loading = false;
  List<RecentBooking> recentBooking = [];

  getRecentBookingsList(){
    futureData = BookingProvider().getRecentBooking().then((value) {
      print(value);
      setState(() {
        recentBooking = [];
        recentBooking.addAll(value);
      });
      print(recentBooking);
      return recentBooking;
    });
  }

  setDelay() async {
    setState(() {
      loading = true;
    });
    getRecentBookingsList();
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
     setDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          if(loading)...[
            const Loader()
          ] else...[
            //recent bookings list
            Expanded(
              child:
              recentBooking.isEmpty
                  ? Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(Images.noMatches, width: 80.w, fit: BoxFit.cover,),
                    SizedBox(height: 3.h),
                    Text("No matches found",
                      style: fontMedium.copyWith(
                          fontSize: 12.sp,
                          color: AppColor.redColor
                      ),),
                  ],
                ),
              )
                  :
              FadeInUp(
                preferences: const AnimationPreferences(
                    duration: Duration(milliseconds: 600)
                ),
                child: FutureBuilder(
                    future: futureData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } if (snapshot.connectionState ==
                          ConnectionState.done) {
                        return ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          separatorBuilder: (context, _){
                            return SizedBox(height: 2.h);
                          },
                          itemCount: recentBooking.length,
                          itemBuilder: (context, index){
                            return BookingsCard(
                                recentBooking[index].bookingSlotStart.toString(),
                                recentBooking[index].bookingDate.toString(),
                                recentBooking[index].cityName.toString(),
                                recentBooking[index].logo.toString(),
                                recentBooking[index].teamName.toString(),
                                recentBooking[index].teamId.toString(),
                                recentBooking[index].matchId.toString());
                          },
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }

                    }
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}


