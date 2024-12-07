import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutriscan/app_utils/colors.dart';
import 'package:nutriscan/app_utils/strings.dart';
import 'package:nutriscan/app_utils/widgets.dart';
import 'package:nutriscan/sign_up_screen/sign_up_screen_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreenUi extends StatefulWidget {
  const LoginScreenUi({super.key});

  @override
  State<LoginScreenUi> createState() => _LoginScreenUiState();
}

class _LoginScreenUiState extends State<LoginScreenUi> {

  TextEditingController _mobileNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevents resizing
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
            Text('Good to See You!',
              style: GoogleFonts.geologica(
                fontSize: 35.spMax,
                textStyle: Theme.of(context).textTheme.titleLarge,
                color:appGreen,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text('Log in to discover healthier choices tailored just for you just enter your mobile number.',
              style: GoogleFonts.poppins(
                fontSize: 12.spMax,
                color:appBlack,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            editText(
              controller: _mobileNumberController,
              isEnabled: true,
              hintText: 'Enter mobile number here... ',
              maxLength: 10,
              cursorColor: appBlack,
              fillColor: appLightGreen,
              textColor: appBlack,
              fontSize: 14.0,
              letterSpacing: 1.0,
              keyboardType: TextInputType.phone,
              prefixIcon: Icon(Icons.phone,color: appGreen,),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly, // Allows only digits to be entered
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            GestureDetector(
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());

                  if(validateMobileNumber(_mobileNumberController.text.trim())){
                    final SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setString(MOBILENUMBER, _mobileNumberController.text.trim());
                    Get.to(SignUpScreenUi());
                  }else{
                    showErrorSnackBar("Please write valid mobile number");
                  }
                },
                child: submitButton())
          ],
        ),
      ),
    );
  }

  bool validateMobileNumber(String mobileNumber) {
    if (mobileNumber.isEmpty) {
      return false; // Mobile number is empty
    } else if (!RegExp(r'^[6-9]\d{9}$').hasMatch(mobileNumber)) {
      return false; // Invalid mobile number
    }
    return true; // Valid mobile number
  }
}
