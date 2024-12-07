import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutriscan/common_controllers/user_controller.dart';

import '../app_utils/colors.dart';

class HomeScreenUi extends StatefulWidget {
  const HomeScreenUi({super.key});

  @override
  State<HomeScreenUi> createState() => _HomeScreenUiState();
}

class _HomeScreenUiState extends State<HomeScreenUi> {

  UserController userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    userController.getUserDetails();
    userController.getTodaysFormattedDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevents resizing
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 60.w,vertical: 20.h),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Obx(() {
                return Text('Hello ${userController.name}',
                  style: GoogleFonts.geologica(
                    fontSize: 35.spMax,
                    textStyle: Theme.of(context).textTheme.titleLarge,
                    color:appGreen,
                    fontWeight: FontWeight.w800,
                  ),
                );
              }
            ),
            Obx(() {
                return Text('Today, ${userController.todaysDate}',
                  style: GoogleFonts.poppins(
                    fontSize: 12.spMax,
                    color:appBlack,
                    fontWeight: FontWeight.w600,
                  ),
                );
              }
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }


}
