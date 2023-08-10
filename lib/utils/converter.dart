import 'package:intl/intl.dart';

class Converter {

  String convertTo12HourFormat(String time) {
    DateFormat inputFormat = DateFormat('HH:mm:ss');
    DateFormat outputFormat = DateFormat('hh:mm a');

    DateTime dateTime = inputFormat.parse(time);
    String formattedTime = outputFormat.format(dateTime);

    return formattedTime;
  }

}