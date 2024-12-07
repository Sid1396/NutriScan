import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutriscan/app_utils/colors.dart';
import 'package:nutriscan/login_screen/login_screen_ui.dart';

class SplashScreenUi extends StatefulWidget {
  const SplashScreenUi({super.key});

  @override
  State<SplashScreenUi> createState() => _SplashScreenUiState();
}

class _SplashScreenUiState extends State<SplashScreenUi> {
  double _titleOpacity = 0.0; // Initial opacity for the title
  double _subtitleOpacity = 0.0; // Initial opacity for the subtitle

  @override
  void initState() {
    super.initState();
    _animateText();
  }
  
  void _animateText() async {
    // Animate the title first
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _titleOpacity = 1.0;
    });

    // Animate the subtitle after the title
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _subtitleOpacity = 1.0;
    });

    await Future.delayed(Duration(seconds: 4));
    Get.to(LoginScreenUi());

  }

  
  @override
  Widget build(BuildContext context) {
    // var height = MediaQuery.of(context).size.height;
    // var width = MediaQuery.of(context).size.width;
    // log("$height ,$width");
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 60.w,vertical: 20.h),
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash_bg.png'),
            fit: BoxFit.cover, // How the image should fit the container
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            AnimatedOpacity(
              opacity: _titleOpacity,
              duration: Duration(seconds: 1),
              child: Text('NutriScan',
                style: GoogleFonts.geologica(
                  fontSize: 48.spMax,
                  color:appGreen,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: _subtitleOpacity,
              duration: Duration(seconds: 1),
              child: Text('AI-Powered Nutrition Scoring App',
                style: GoogleFonts.poppins(
                  fontSize: 16.spMax,
                  color:appBlack,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
