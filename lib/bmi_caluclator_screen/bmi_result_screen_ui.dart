import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutriscan/app_utils/colors.dart';
import 'package:nutriscan/app_utils/strings.dart';
import 'package:nutriscan/home_screen/home_screen_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../app_utils/widgets.dart';

class BmiResultScreenUi extends StatefulWidget {
  const BmiResultScreenUi({super.key});

  @override
  State<BmiResultScreenUi> createState() => _BmiResultScreenUiState();
}

class _BmiResultScreenUiState extends State<BmiResultScreenUi> {
  double bmi = Get.arguments[0];
  String bmiStatus = Get.arguments[1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevents resizing
      backgroundColor: appWhite,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 20.h),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'Your Health, Your Score',
                    style: GoogleFonts.geologica(
                      fontSize: 32.spMax,
                      textStyle: Theme.of(context).textTheme.titleLarge,
                      color: appGreen,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'Here’s what your Body Mass Index reveals about your health.',
                    style: GoogleFonts.poppins(
                      fontSize: 12.spMax,
                      color: appBlack,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(
                    height: 10.h,
                  ),

                  // Circular BMI Visualization

                  SizedBox(
                    child: SfRadialGauge(
                      enableLoadingAnimation: true,
                      animationDuration: 4500,
                      axes: <RadialAxis>[
                        RadialAxis(
                          startAngle: 180,
                          endAngle: 0,
                          minimum: 0,
                          maximum: 40,
                          // BMI range (0-40)
                          ranges: <GaugeRange>[
                            GaugeRange(
                              startValue: 0,
                              endValue: 18.5,
                              color: Colors.blue,
                              // Underweight
                              startWidth: 20,
                              endWidth: 20,
                            ),
                            GaugeRange(
                              startValue: 18.5,
                              endValue: 24.9,
                              color: Colors.green,
                              // Normal
                              startWidth: 20,
                              endWidth: 20,
                            ),
                            GaugeRange(
                              startValue: 24.9,
                              endValue: 30,
                              color: Colors.orange,
                              // Overweight
                              startWidth: 20,
                              endWidth: 20,
                            ),
                            GaugeRange(
                              startValue: 30,
                              endValue: 40,
                              color: Colors.red,
                              // Obesity
                              startWidth: 20,
                              endWidth: 20,
                            ),
                          ],
                          pointers: <GaugePointer>[
                            NeedlePointer(
                              value: bmi,
                              needleColor: Colors.black,
                              knobStyle: KnobStyle(
                                  color: Colors.black,
                                  sizeUnit: GaugeSizeUnit.logicalPixel,
                                  knobRadius: 0.07),
                              needleLength: 0.7,
                              needleStartWidth: 1,
                              needleEndWidth: 3,
                            ),
                          ],
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                              axisValue: 50,
                              positionFactor: 0.4,
                              widget: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 50.h,
                                  ),
                                  Text(
                                    bmi.toStringAsFixed(1),
                                    style: GoogleFonts.geologica(
                                      fontSize: 40.spMax,
                                      color: appBlack,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    bmiStatus,
                                    style: GoogleFonts.poppins(
                                      fontSize: 18.spMax,
                                      color: bmiStatus == "Overweight"
                                          ? Colors.orange
                                          : (bmiStatus == "Normal"
                                              ? Colors.green
                                              : Colors.red),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(5.h),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: appLightGreen),
                                    child: Text(
                                      'Your BMI is 25.9, indicating your weight is in the Overweight category for adults of your height.\nFor your height, a normal weight range would be from 53.5 to 72 kilograms.',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12.spMax,
                                        color: appBlack,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              angle: 90,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
            GestureDetector(
                onTap: () async {
                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setBool(ISLOGGEDIN,true);
                  Get.to(HomeScreenUi());
                },
                child: submitTextButton("Get started"))
          ],
        ),
      ),
    );
  }
}
