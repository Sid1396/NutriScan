import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutriscan/app_utils/colors.dart';
import 'package:nutriscan/app_utils/strings.dart';
import 'package:nutriscan/app_utils/widgets.dart';
import 'package:nutriscan/bmi_caluclator_screen/bmi_result_screen_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivityScreenUi extends StatefulWidget {
  const ActivityScreenUi({super.key});

  @override
  State<ActivityScreenUi> createState() => _ActivityScreenUiState();
}

class _ActivityScreenUiState extends State<ActivityScreenUi> {

  String? _selectedActivityLevel;
  double bmi = Get.arguments[0];
  String bmiStatus = Get.arguments[1];

  final List<ActivityLevel> _activityLevels = [
    ActivityLevel("Sedentary", "Little or no exercise"),
    ActivityLevel("Lightly active", "Light exercise/sports 1–3 days/week"),
    ActivityLevel("Moderately active", "Moderate exercise/sports 3–5 days/week"),
    ActivityLevel("Very active", "Hard exercise/sports 6–7 days/week"),
    ActivityLevel("Super active", "Very hard exercise or a physically demanding job")
  ];


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
            Text('Tell Us About Your Activity Level',
              style: GoogleFonts.geologica(
                fontSize: 32.spMax,
                textStyle: Theme.of(context).textTheme.titleLarge,
                color:appGreen,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text('Let us know how active you are to tailor your health recommendations',
              style: GoogleFonts.poppins(
                fontSize: 12.spMax,
                color:appBlack,
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _activityLevels.length,
                itemBuilder: (context, index) {
                  ActivityLevel level = _activityLevels[index];
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: appLightGreen
                    ),
                    margin: EdgeInsets.only(top: 10.h),
                    child: ListTile(
                      title: Text(level.activityTitle,
                        style: GoogleFonts.poppins(
                          fontSize: 14.spMax,
                          color:appBlack,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(level.activitySubTitle,
                        style: GoogleFonts.poppins(
                          fontSize: 10.spMax,
                          color:appGrey,
                          fontWeight: FontWeight.w600,
                        ),
                      ) ,
                      leading: Radio<String>(
                        value: level.activityTitle,
                        activeColor: appGreen,
                        groupValue: _selectedActivityLevel,
                        onChanged: (value) {
                          setState(() {
                            _selectedActivityLevel = value;
                          });
                        },
                      ),

                      onTap: (){
                        setState(() {
                          _selectedActivityLevel = level.activityTitle;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            GestureDetector(
                onTap: () async {
                  if(_selectedActivityLevel==null){
                    showErrorSnackBar("Please select activity");
                  }else{
                    final SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setString(ACTIVITYLEVEL,_selectedActivityLevel!);
                    Get.to(BmiResultScreenUi(),arguments: [bmi,bmiStatus]);
                  }
                },
                child: submitButton())
          ],
        ),
      ),
    );
  }
}


class ActivityLevel{
  String activityTitle;
  String activitySubTitle;

  ActivityLevel(this.activityTitle,this.activitySubTitle);
}