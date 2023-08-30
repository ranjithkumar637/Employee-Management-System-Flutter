import 'package:elevens_organizer/models/referral_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/animation/animation_preferences.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_up.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../providers/profile_provider.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import '../widgets/loader.dart';

class MyReferrals extends StatefulWidget {
  const MyReferrals({Key? key}) : super(key: key);

  @override
  State<MyReferrals> createState() => _MyReferralsState();
}

class _MyReferralsState extends State<MyReferrals> {

  bool loading = false;
  Future<List<RefList>>? futureData;
  List<RefList> refList = [];

  getList(){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      futureData = ProfileProvider().getReferralsList()
          .then((value) {
        setState(() {
          refList = [];
          refList.addAll(value);
        });
        return refList;
      });
    });
  }

  setDelay() async {
    if(mounted){
      setState(() {
        loading = true;
      });
    }
    getList();
    await Future.delayed(const Duration(seconds: 2));
    if(mounted){
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setDelay();
  }

  @override
  Widget build(BuildContext context) {
    return  refList.isEmpty
        ? Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(Images.noMatches, width: 80.w, fit: BoxFit.cover,),
          SizedBox(height: 3.h),
          Text("No referrals found",
            style: fontMedium.copyWith(
                fontSize: 12.sp,
                color: AppColor.redColor
            ),),
        ],
      ),
    ) : FadeInUp(
      preferences: const AnimationPreferences(
          duration: Duration(milliseconds: 400)
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: FutureBuilder(
          future: futureData,
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Loader();
            }
            if(snapshot.connectionState == ConnectionState.done){
              return GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 1.5.h,
                    crossAxisSpacing: 3.w,
                    childAspectRatio: 2
                ),
                itemCount: refList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ReferralsCard(refList[index].points.toString(), refList[index].captainName.toString());
                },
              );
            } else {
              return const Loader();
            }
          }
        ),
      ),
    );
  }
}

class ReferralsCard extends StatelessWidget {
  final String points, referral;
  const ReferralsCard(this.points, this.referral, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffFAC713),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
                right: 2.w, bottom: 1.h
            ),
            child: SvgPicture.asset(Images.refPointsImage, width: 23.w,),
          ),
          Positioned(
            left: 2.w,
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 4.w,
                    vertical: 2.h,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColor.textColor,
                    shape: BoxShape.circle
                  ),
                  child: RichText(
                       text: TextSpan(
                       text: 'You got',
                       style: fontRegular.copyWith(
                          color: AppColor.lightColor,
                          fontSize: 7.sp,
                         ),
                       children: <TextSpan>[
                           TextSpan(text: '\n$points Points',
                            style: fontRegular.copyWith(
                            color: AppColor.primaryColor,
                            fontSize: 7.sp,
                          ),
                      )
                      ]
                     ),
                    ),
                ),
                SizedBox(width: 3.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Invited",
                      style: fontRegular.copyWith(
                          fontSize: 10.sp,
                          color: AppColor.textColor
                      ),),
                    Text(referral,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: fontMedium.copyWith(
                          fontSize: 10.sp,
                          color: AppColor.textColor
                      ),),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

