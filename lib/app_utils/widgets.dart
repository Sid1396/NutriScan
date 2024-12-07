import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts package
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'colors.dart';


// Widget logoText(
//     String text, {
//       Color? textColor,
//       double fontSize = 14.0,
//       FontWeight fontWeight = FontWeight.normal,
//     }) {
//   return Text(
//     text,
//     textAlign: TextAlign.start,
//     style: GoogleFonts.poppins(
//       textStyle: TextStyle(
//         color: textColor ?? red, // Use textColor or default to black
//         fontSize: ScreenUtil().setSp(fontSize), // Use ScreenUtil to scale font size
//         fontWeight: fontWeight,
//       ),
//     ),
//   );
// }

Widget text(
    String text, {
      TextAlign? textAlign,
      Color? textColor,
      double fontSize = 14.0,
      FontWeight fontWeight = FontWeight.normal,
      int? maxlines = 1,
    }) {
  return Text(
    text,
    textAlign: textAlign ?? TextAlign.start,
    maxLines: maxlines,// Set text alignment to the provided value or default to start
    style: GoogleFonts.geologica(
      textStyle: TextStyle(
        color: textColor ?? appGreen, // Use textColor or default to black
        fontSize: fontSize.spMax, // Use ScreenUtil to scale font size
        fontWeight: fontWeight,
      ),
    ),
  );
}

Widget editText({
  required TextEditingController controller,
  required String hintText,
  int maxLength = 100,
  Color cursorColor = Colors.black,
  Color fillColor = Colors.white,
  Color textColor = Colors.black,
  double fontSize = 15.0,
  double letterSpacing = 1.0,
  TextInputType keyboardType = TextInputType.text,
  List<TextInputFormatter> inputFormatters = const [],
  double borderRadius = 10.0,
  double paddingLeft = 20.0,
  bool isEnabled = true,
  bool capitalizeFirstLetter = false,
  bool allCaps = false,
  Widget? prefixIcon, // Optional prefix icon
}) {
  return TextFormField(
    controller: controller,
    enabled: isEnabled,
    cursorColor: cursorColor,
    maxLength: maxLength,
    decoration: InputDecoration(
      counterText: "", // Hides the character counter
      hintText: hintText, // Placeholder text
      hintStyle: GoogleFonts.poppins(
        textStyle: TextStyle(
          color: Colors.grey,
          fontSize: fontSize.spMax,
          fontWeight: FontWeight.w500,
          letterSpacing: letterSpacing,
        ),
      ),
      filled: true, // Fill the background with color
      fillColor: fillColor, // Background color
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius), // Border radius
        borderSide: BorderSide.none, // Remove border side
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius), // Border radius
        borderSide: BorderSide(color: fillColor), // Border color when focused
      ),
      contentPadding: EdgeInsets.only(left: paddingLeft.w, right: paddingLeft.w), // Padding inside the text field
      prefixIcon: prefixIcon, // Add the prefix icon if provided
    ),
    style: GoogleFonts.poppins(
      textStyle: TextStyle(
        color: textColor,
        fontSize: fontSize.spMax,
        fontWeight: FontWeight.w600,
        letterSpacing: letterSpacing,
      ),
    ),
    keyboardType: keyboardType, // Sets the keyboard type
    inputFormatters: [
      ...inputFormatters,
      if (allCaps)
        UpperCaseTextFormatter(), // Converts all text to uppercase
      if (capitalizeFirstLetter)
        CapitalizeFirstLetterTextFormatter(), // Capitalizes the first letter
    ], // Allows only specified input formatters
  );
}


class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class CapitalizeFirstLetterTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty) {
      return TextEditingValue(
        text: newValue.text[0].toUpperCase() + newValue.text.substring(1),
        selection: newValue.selection,
      );
    }
    return newValue;
  }
}

Widget dropdown({
  required String hintText,
  required List<String> items,
  required String? selectedItem,
  required ValueChanged<String?> onChanged,
  Color fillColor = Colors.white,
  Color textColor = Colors.black,
  double fontSize = 15.0,
  double letterSpacing = 1.0,
  double borderRadius = 10.0,
  double paddingLeft = 20.0,
}) {
  return SizedBox(
    height: 60.h,
    child: DropdownButtonFormField<String>(
      value: selectedItem,
      onChanged: onChanged,
      isExpanded: true,
      icon: Icon(Icons.expand_circle_down,color: Colors.grey.shade300,),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.questrial(
          textStyle: TextStyle(
            color: Colors.grey,
            fontSize: fontSize.sp,
            fontWeight: FontWeight.w900,
            letterSpacing: letterSpacing,
          ),
        ),
        filled: true,
        fillColor: fillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: fillColor),
        ),
        contentPadding: EdgeInsets.only(left: paddingLeft.w, right: paddingLeft.w),
      ),
      style: GoogleFonts.questrial(
        textStyle: TextStyle(
          color: textColor,
          fontSize: fontSize.sp,
          fontWeight: FontWeight.w900,
          letterSpacing: letterSpacing,
        ),
      ),
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
    ),
  );
}



// Widget dropdownWithSearch({
//   required String hintText,
//   required List<String> items,
//   required String? selectedItem,
//   required ValueChanged<String?> onChanged,
//   Color fillColor = Colors.white,
//   Color textColor = Colors.black,
//   double fontSize = 15.0,
//   double letterSpacing = 1.0,
//   double borderRadius = 10.0,
//   double paddingLeft = 20.0,
// }) {
//   return SizedBox(
//     height: 60.h,
//     child: DropdownSearch<String>(
//       items: items,
//       selectedItem: selectedItem,
//       onChanged: onChanged,
//
//       dropdownBuilder: (context, selectedItem) {
//         return Text(
//           selectedItem ?? hintText,
//           style: GoogleFonts.questrial(
//             textStyle: TextStyle(
//               color: selectedItem == null ? Colors.grey : textColor,
//               fontSize: fontSize.sp,
//               fontWeight: FontWeight.w900,
//               letterSpacing: letterSpacing,
//             ),
//           ),
//         );
//       },
//       popupProps: PopupProps.menu(
//           menuProps: MenuProps(elevation: 0, backgroundColor: white),
//           searchFieldProps: TextFieldProps(
//             decoration: InputDecoration(
//               counterText: "", // Hides the character counter
//               hintText: "Search here", // Placeholder text
//               hintStyle: GoogleFonts.questrial(
//                 textStyle: TextStyle(
//                   color: Colors.grey,
//                   fontSize: fontSize.sp,
//                   fontWeight: FontWeight.w900,
//                   letterSpacing: letterSpacing,
//                 ),
//               ),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(borderRadius), // Border radius
//                 borderSide: BorderSide(color: Colors.grey.shade100), // Border color when focused
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(borderRadius), // Border radius
//                 borderSide: BorderSide(color: Colors.grey.shade100), // Border color when focused
//               ),
//               contentPadding: EdgeInsets.only(left: paddingLeft.w,right: paddingLeft.w), // Padding inside the text field
//             ),
//           ),
//           showSearchBox: true,
//           itemBuilder: (context, item, isSelected) {
//             return Container(
//               padding: EdgeInsets.all( 10.h),
//               child: Text(
//                 item,
//                 style: GoogleFonts.questrial(
//                   textStyle: TextStyle(
//                     color: textColor,
//                     fontSize: fontSize.sp,
//                     fontWeight: FontWeight.w900,
//                     letterSpacing: letterSpacing,
//                   ),
//                 ),
//               ),
//             );
//           },
//         emptyBuilder: (context, searchEntry) {
//           return Center(child: Text('No items found'));
//         },
//       ),
//       dropdownDecoratorProps: DropDownDecoratorProps(
//         dropdownSearchDecoration: InputDecoration(
//           hintText: "Search here",
//           hintStyle: GoogleFonts.questrial(
//             textStyle: TextStyle(
//               color: Colors.grey,
//               fontSize: fontSize.sp,
//               fontWeight: FontWeight.w900,
//               letterSpacing: letterSpacing,
//             ),
//           ),
//           suffixIcon: Icon(
//             Icons.expand_circle_down,
//             color: Colors.grey.shade300,
//           ),
//           filled: true,
//           fillColor: fillColor,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(borderRadius),
//             borderSide: BorderSide.none,
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(borderRadius),
//             borderSide: BorderSide(color: fillColor),
//           ),
//           contentPadding: EdgeInsets.only(left: paddingLeft.w, right: paddingLeft.w),
//         ),
//       ),
//
//     ),
//   );
// }
//
//
Widget submitButton({Color mColor=appGreen}) {
  return SizedBox(
    height: 25.h,
    width: 25.h,
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: mColor
      ),
      child: Center(child: Icon(Icons.arrow_forward,color: appWhite,)),
    ),
  );
}

Widget submitTextButton(String text,{Color mColor=appGreen}) {
  return SizedBox(
    height: 25.h,
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: mColor
      ),
      child: Center(child: Text(text,
        style: GoogleFonts.poppins(
          fontSize: 18.spMax,
          color:appWhite,
          fontWeight: FontWeight.w600,
        ),
      )),
    ),
  );
}

void showSuccessSnackBar(String message){
  Get.showSnackbar(
    GetSnackBar(
      messageText: text(message,textColor: appWhite),
      backgroundColor: appGreen,
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.TOP, // Set the snackbar position to top
    ),
  );
}

void showErrorSnackBar(String message){
  Get.showSnackbar(
    GetSnackBar(
      messageText: text(message,textColor: appWhite),
      backgroundColor: appRed,
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.TOP, // Set the snackbar position to top
    ),
  );
}