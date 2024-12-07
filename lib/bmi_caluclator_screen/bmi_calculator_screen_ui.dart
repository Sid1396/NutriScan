import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutriscan/app_utils/colors.dart';
import 'package:nutriscan/app_utils/widgets.dart';
import 'package:nutriscan/bmi_caluclator_screen/bmi_result_screen_ui.dart';

class BmiCalculatorScreenUi extends StatefulWidget {
  const BmiCalculatorScreenUi({super.key});

  @override
  State<BmiCalculatorScreenUi> createState() => _BmiCalculatorScreenUiState();
}

class _BmiCalculatorScreenUiState extends State<BmiCalculatorScreenUi> {

  double height = 0;
  double weight = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevents resizing
      backgroundColor: appWhite,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 60.w,vertical: 20.h),
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bmi_bg.png'),
            fit: BoxFit.cover, // How the image should fit the container
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Text('Lets Calculate Your BMI',
              style: GoogleFonts.geologica(
                fontSize: 32.spMax,
                textStyle: Theme.of(context).textTheme.titleLarge,
                color:appGreen,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text('Please Provide your weight and height to understand your health status',
              style: GoogleFonts.poppins(
                fontSize: 12.spMax,
                color:appBlack,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical:5.h),
              decoration: BoxDecoration(
                color: appLightGreen,
                borderRadius: BorderRadius.circular(10),
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal:10.h),
                    child: Row(
                      children: [
                        Icon(Icons.accessible_sharp,color: appGreen,),
                        SizedBox(width: 2.h,),
                        Text('Weight in Kg',
                          style: GoogleFonts.poppins(
                            fontSize: 12.spMax,
                            color:appBlack,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal:10.h),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [

                        Text(weight.toInt().toString(),
                          style: GoogleFonts.geologica(
                            fontSize: 40.spMax,
                            color:appBlack,
                            textStyle: Theme.of(context).textTheme.titleLarge,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        Text('Kg',
                          style: GoogleFonts.geologica(
                            fontSize: 20.spMax,
                            color:appBlack,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Slider(
                    value: weight,
                    min: 0,
                    max: 200,
                    activeColor: appGreen,
                    onChanged: (value) => setState(() => weight = value),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical:5.h),
              decoration: BoxDecoration(
                color: appLightGreen,
                borderRadius: BorderRadius.circular(10),
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal:10.h),
                    child: Row(
                      children: [
                        Icon(Icons.accessibility_new_rounded,color: appGreen,),
                        SizedBox(width: 2.h,),
                        Text('Height in Cm',
                          style: GoogleFonts.poppins(
                            fontSize: 12.spMax,
                            color:appBlack,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal:10.h),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [

                        Text(height.toInt().toString(),
                          style: GoogleFonts.geologica(
                            fontSize: 40.spMax,
                            color:appBlack,
                            textStyle: Theme.of(context).textTheme.titleLarge,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        Text('Cm',
                          style: GoogleFonts.geologica(
                            fontSize: 20.spMax,
                            color:appBlack,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Slider(
                    value: height,
                    min: 0,
                    max: 300,
                    activeColor: appGreen,
                    onChanged: (value) => setState(() => height = value),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            GestureDetector(
                onTap: (){
                  if(weight==0){
                    showErrorSnackBar("Please enter weight");
                  }else if(height==0){
                    showErrorSnackBar("Please enter height");
                  }else{
                    Get.to(BmiResultScreenUi());
                  }
                },
                child: submitButton())
          ],
        ),
      ),
    );
  }
}
