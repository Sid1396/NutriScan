import 'package:get/get.dart';
import 'package:nutriscan/app_utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController{

  var mobileNumber = RxnString();
  var name = RxnString();
  var gender = RxnString();
  var dob = RxnString();
  var height = RxnString();
  var weight = RxnString();
  var bmi = RxnString();

  var todaysDate = RxnString();

  Future<void> getUserDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    name.value = prefs.getString(NAME);

  }

  void getTodaysFormattedDate() {
    final now = DateTime.now();
    final months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    String day = now.day.toString();
    String month = months[now.month - 1];
    String year = now.year.toString();

    todaysDate.value = "$day $month $year";
  }



}