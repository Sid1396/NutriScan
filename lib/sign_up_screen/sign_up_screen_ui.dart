import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nutriscan/app_utils/colors.dart';
import 'package:nutriscan/app_utils/strings.dart';
import 'package:nutriscan/app_utils/widgets.dart';
import 'package:nutriscan/bmi_caluclator_screen/bmi_calculator_screen_ui.dart';
import 'package:nutriscan/sign_up_screen/height_selector_screen_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreenUi extends StatefulWidget {
  const SignUpScreenUi({super.key});

  @override
  State<SignUpScreenUi> createState() => _SignUpScreenUiState();
}

class _SignUpScreenUiState extends State<SignUpScreenUi> {

  TextEditingController _nameController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _dobController = TextEditingController();


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
            image: AssetImage('assets/images/sign_up_bg.png'),
            fit: BoxFit.cover, // How the image should fit the container
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Text('New User? Join NutriScan!',
              style: GoogleFonts.geologica(
                fontSize: 32.spMax,
                textStyle: Theme.of(context).textTheme.titleLarge,
                color:appGreen,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text('Create your account to start making smarter, healthier food choices.',
              style: GoogleFonts.poppins(
                fontSize: 12.spMax,
                color:appBlack,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text('Full Name',
              style: GoogleFonts.poppins(
                fontSize: 12.spMax,
                color:appBlack,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),

            editText(
              controller: _nameController,
              isEnabled: true,
              hintText: 'Eg. Renuka Rawool',
              maxLength: 100,
              cursorColor: appBlack,
              fillColor: appLightGreen,
              textColor: appBlack,
              fontSize: 14.0,
              letterSpacing: 1.0,
              keyboardType: TextInputType.text,
              capitalizeFirstLetter: true,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')), // Allows alphabets and spaces
              ],
              prefixIcon: Icon(Icons.account_circle_rounded,color: appGreen,),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text('Gender',
              style: GoogleFonts.poppins(
                fontSize: 12.spMax,
                color:appBlack,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),

            GestureDetector(
              onTap: (){
                FocusScope.of(context).requestFocus(FocusNode());
                showGenderBottomSheet();
              },
              child: editText(
                controller: _genderController,
                isEnabled: false,
                hintText: 'Eg. Female',
                maxLength: 100,
                cursorColor: appBlack,
                fillColor: appLightGreen,
                textColor: appBlack,
                fontSize: 14.0,
                letterSpacing: 1.0,
                keyboardType: TextInputType.text,
                prefixIcon: Icon(Icons.accessibility_new_rounded,color: appGreen,),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text('Date of birth',
              style: GoogleFonts.poppins(
                fontSize: 12.spMax,
                color:appBlack,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),

            GestureDetector(
              onTap: (){
                FocusScope.of(context).requestFocus(FocusNode());
                showDatePickerDialog();
              },
              child: editText(
                controller: _dobController,
                isEnabled: false,
                hintText: '21 Jan 1908',
                maxLength: 100,
                cursorColor: appBlack,
                fillColor: appLightGreen,
                textColor: appBlack,
                fontSize: 14.0,
                letterSpacing: 1.0,
                keyboardType: TextInputType.text,
                prefixIcon: Icon(Icons.calendar_month_rounded,color: appGreen,),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            GestureDetector(
                onTap: () async {
                  if(validateFields(_nameController.text.trim(),_genderController.text.trim(),_dobController.text.trim())){
                    final SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setString(NAME, _nameController.text.trim());
                    prefs.setString(GENDER, _genderController.text.trim());
                    prefs.setString(DOB, _dobController.text.trim());
                    Get.to(BmiCalculatorScreenUi());
                  }
                },
                child: submitButton())
          ],
        ),
      ),
    );
  }


  void showGenderBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(0.0)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Please select gender",
                style: GoogleFonts.poppins(
                  fontSize: 18.spMax,
                  color:appBlack,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16.0), // Space between title and options
              ListTile(
                leading: Icon(Icons.male,color: appGreen,),
                title: Text("Male", style: GoogleFonts.poppins(
                  fontSize: 14.spMax,
                  color:appBlack,
                  fontWeight: FontWeight.w600,
                )),
                onTap: () {
                  setState(() {
                    _genderController.text = "Male";
                  });
                  Navigator.pop(context); // Close the bottom sheet
                },
              ),
              ListTile(
                leading: Icon(Icons.female,color: appGreen,),
                title: Text("Female", style: GoogleFonts.poppins(
                  fontSize: 14.spMax,
                  color:appBlack,
                  fontWeight: FontWeight.w600,
                )),
                onTap: () {
                  setState(() {
                    _genderController.text = "Female";
                  });
                  Navigator.pop(context); // Close the bottom sheet
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> showDatePickerDialog() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000), // Default initial date
      firstDate: DateTime(1900), // Earliest date
      lastDate: DateTime.now(), // Latest date (today)
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: appGreen, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: appGreen, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      // Format the selected date (e.g., DD/MM/YYYY)
      final formattedDate = DateFormat('d MMM yyyy').format(selectedDate);


      setState(() {
        _dobController.text = formattedDate; // Set the selected date in the controller
      });
    }
  }


  bool validateFields(String name,String gender,String dob) {
    if (name.isEmpty) {
      showErrorSnackBar("Please write full name");
      return false; // Mobile number is empty
    } else if  (gender.isEmpty) {
      showErrorSnackBar("Please select gender");
      return false; // Invalid mobile number
    } else if  (dob.isEmpty) {
      showErrorSnackBar("Please select date of birth");
      return false; // Invalid mobile number
    }
    return true; // Valid mobile number
  }



}
