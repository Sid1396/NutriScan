import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutriscan/app_utils/colors.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../app_utils/widgets.dart';

class BmiResultScreenUi extends StatefulWidget {
  const BmiResultScreenUi({super.key});

  @override
  State<BmiResultScreenUi> createState() => _BmiResultScreenUiState();
}

class _BmiResultScreenUiState extends State<BmiResultScreenUi> {

  final double bmi = 25.9; // Example BMI value
  final String status = "Overweight"; // Example status
  final int height = 163; // Example height value
  final int weight = 87; // Example weight value
  final int weightToLose = 3; // E


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevents resizing
      backgroundColor: appWhite,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 60.w,vertical: 20.h),
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
                  Text('Your Health, Your Score',
                    style: GoogleFonts.geologica(
                      fontSize: 32.spMax,
                      textStyle: Theme.of(context).textTheme.titleLarge,
                      color:appGreen,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text('Here’s what your Body Mass Index reveals about your health.',
                    style: GoogleFonts.poppins(
                      fontSize: 12.spMax,
                      color:appBlack,
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
                          maximum: 40, // BMI range (0-40)
                          ranges: <GaugeRange>[
                            GaugeRange(
                              startValue: 0,
                              endValue: 18.5,
                              color: Colors.blue, // Underweight
                              startWidth: 20,
                              endWidth: 20,
                            ),
                            GaugeRange(
                              startValue: 18.5,
                              endValue: 24.9,
                              color: Colors.green, // Normal
                              startWidth: 20,
                              endWidth: 20,
                            ),
                            GaugeRange(
                              startValue: 24.9,
                              endValue: 30,
                              color: Colors.orange, // Overweight
                              startWidth: 20,
                              endWidth: 20,
                            ),
                            GaugeRange(
                              startValue: 30,
                              endValue: 40,
                              color: Colors.red, // Obesity
                              startWidth: 20,
                              endWidth: 20,
                            ),
                          ],
                          pointers: <GaugePointer>[
                            NeedlePointer(
                              value: bmi,
                              needleColor: Colors.black,
                              knobStyle: KnobStyle(color: Colors.black, sizeUnit: GaugeSizeUnit.logicalPixel, knobRadius: 0.07),
                              needleLength: 0.7,
                              needleStartWidth: 1,
                              needleEndWidth: 3,
                            ),
                          ],
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                              axisValue: 50, positionFactor: 0.4,
                              widget: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 50.h,
                                  ),
                                  Text(bmi.toStringAsFixed(1),
                                    style: GoogleFonts.geologica(
                                      fontSize: 40.spMax,
                                      color:appBlack,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(status,
                                    style: GoogleFonts.poppins(
                                      fontSize: 18.spMax,
                                      color:status == "Overweight"
                                          ? Colors.orange
                                          : (status == "Normal" ? Colors.green : Colors.red),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Container(
                                    padding:EdgeInsets.all(5.h),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        color: appLightGreen
                                    ),
                                    child: Text('Your BMI is 25.9, indicating your weight is in the Overweight category for adults of your height.\nFor your height, a normal weight range would be from 53.5 to 72 kilograms.',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12.spMax,
                                        color:appBlack,
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
            submitTextButton("Get started")

          ],
        ),
      ),
    );
  }
}

