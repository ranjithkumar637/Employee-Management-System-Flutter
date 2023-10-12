import 'package:elevens_organizer/utils/styles.dart';
import 'package:flutter/material.dart';

import '../../utils/colours.dart';

class Dialogs {
  static snackbar(String message, context, {bool isLong = false, bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor:
      isError ? AppColor.error : AppColor.availableSlot,
      elevation: 5,
      content: Text(
        message,
        style: fontMedium.copyWith(color: AppColor.lightColor),
      ),
      duration: Duration(seconds: isLong ? 4 : 2),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(10),
      dismissDirection: DismissDirection.horizontal,
    ));
  }
}
