import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:sizer/sizer.dart';

import '../../utils/images.dart';
import 'grid_item.dart';

class HomeGridOptions extends StatelessWidget {
  const HomeGridOptions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 5.w
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Bounceable(
                  onTap:(){
                    Navigator.pushNamed(context, "payment_information");
                  },
                  child: const GridItem("Payment\nInformation", Images.gridImage2, Color(0xffF2EBE5)))),
              SizedBox(width: 5.w),
              Expanded(child: Bounceable(
                  onTap: (){
                    Navigator.pushNamed(context, "toss");
                  },
                  child: const GridItem("Flip / Call\n(Toss)", Images.gridImage3, Color(0xffE6E6E6)))),
            ],
          ),
        ],
      ),
    );
  }
}
