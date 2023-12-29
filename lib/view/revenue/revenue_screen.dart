import 'package:elevens_organizer/view/revenue/revenue_list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../models/revenue_team_list_model.dart';
import '../../providers/payment_info_provider.dart';
import '../../utils/colours.dart';
import '../../utils/connectivity_status.dart';
import '../../utils/images.dart';
import '../../utils/strings.dart';
import '../../utils/styles.dart';
import '../widgets/loader.dart';
import '../widgets/no_internet_view.dart';
import '../widgets/revenue_refer_data_box.dart';

class RevenueScreen extends StatefulWidget {
  const RevenueScreen({Key? key}) : super(key: key);

  @override
  State<RevenueScreen> createState() => _RevenueScreenState();
}

class _RevenueScreenState extends State<RevenueScreen> {

  String firstDate = "";
  String lastDate = "";

  Future<List<TeamsList>>? futureData ;
  bool loading = false;

  List<TeamsList> revenueTeamList = [];

  getRevenueTeamList(){
    Provider.of<PaymentInfoProvider>(context, listen: false).getRevenueTeamList();
    futureData = PaymentInfoProvider().getRevenueTeamList().then((value){
      setState(() {
        revenueTeamList = [];
        revenueTeamList.addAll(value.teamsList!);
      });
      print(revenueTeamList);
      return revenueTeamList;
    });
  }

  setDelay() async{
    if(mounted){
      setState(() {
        loading = true;
      });
    }
    getRevenueTeamList();
    await Future.delayed(const Duration(seconds: 1));
    if(mounted){
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setDelay();
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    var platform = Theme.of(context).platform;
    bool isIOS = platform == TargetPlatform.iOS;
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    if (connectionStatus == ConnectivityStatus.offline) {
      return const NoInternetView();
    }
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 5.w
            ) + EdgeInsets.only(
                top: isIOS ? statusBarHeight : 2.h + statusBarHeight,
                bottom: 3.h
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 7.w,),
                Text("Revenue",
                  style: fontMedium.copyWith(
                      fontSize: 16.sp,
                      color: AppColor.textColor
                  ),),
                SizedBox(width: 7.w,),
              ],
            ),
          ),
          revenueTeamList.isEmpty
              ? const SizedBox()
          : Consumer<PaymentInfoProvider>(
            builder: (context, revenue, child) {
              return RevenueReferDataBox("${Strings.rupee} ${revenue.revenueTeamListModel.totalRevenue.toString()}", 2);
            }
          ),
          SizedBox(height: 2.h),
          Expanded(
            child: loading
                ? const Loader()
            : MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: revenueTeamList.isEmpty
                    ? Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 4.h),
                      SvgPicture.asset(
                        Images.revenueImage,
                        width: 40.w,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        "You don’t have any revenue yet",
                        style: fontMedium.copyWith(
                            fontSize: 12.sp, color: AppColor.redColor),
                      ),
                    ],
                  ),
                )
                    : FutureBuilder(
                  future: futureData,
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const Loader();
                    } if(snapshot.connectionState == ConnectionState.done){
                      return FadeIn(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          separatorBuilder: (context, _){
                            return SizedBox(height: 1.5.h);
                          },
                          itemCount: revenueTeamList.length,
                          itemBuilder: (context, index){
                            return RevenueListCard(
                              revenueTeamList[index].logo.toString(),
                              revenueTeamList[index].paidPrice.toString(),
                              revenueTeamList[index].totalPrice.toString(),
                              revenueTeamList[index].bookingDate.toString(),
                              revenueTeamList[index].bookingSlotStart.toString(),
                              revenueTeamList[index].teamName.toString(),
                              revenueTeamList[index].paidStatus.toString(),
                              revenueTeamList[index].matchNumber.toString(),
                            );
                          },
                        ),
                      );
                    } else {
                      return const Loader();
                    }
                  }
                )),
          ),
        ],
      ),
    );
  }
}
