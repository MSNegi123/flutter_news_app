import 'package:intl/intl.dart';

String formattedDateString({required DateTime date}){
  var dateString = DateFormat("MMM d, yyyy").format(date);
  return dateString;
}