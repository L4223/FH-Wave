// import 'package:flutter/material.dart';
// import 'app_colors.dart';
//
// class AppButtons {
//   final screenWidth = MediaQuery.of(context).size.width;
//   final width = screenWidth * 0.41;
//
//   static Widget primaryButton({
//     required VoidCallback onTap,
//     double width = 220.0,
//     double height = 50.0,
//     Color buttonColor = AppColors.black,
//     Color borderColor = AppColors.black,
//     Color textColor = AppColors.white,
//     required String text,
//     double fontSize = 16.0,
//     FontWeight fontWeight = FontWeight.bold,
//   }) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: width,
//         height: height,
//         decoration: BoxDecoration(
//           color: buttonColor,
//           borderRadius: BorderRadius.circular(50.0),
//           border: Border.all(
//             color: borderColor,
//             width: 2.0,
//           ),
//         ),
//         child: Center(
//           child: Text(
//             text,
//             style: TextStyle(
//               color: textColor,
//               fontSize: fontSize,
//               fontWeight: fontWeight,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   static Widget secondaryButton({
//     required VoidCallback onTap,
//     required String text,
//     double fontSize = 16.0,
//     FontWeight fontWeight = FontWeight.bold,
//     double buttonWidth = 220.0,
//     double buttonHeight = 50.0,
//     Color buttonColor = AppColors.transparent,
//     Color borderColor = AppColors.black,
//     Color textColor = AppColors.black,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: buttonWidth,
//         height: buttonHeight,
//         decoration: BoxDecoration(
//           color: buttonColor,
//           borderRadius: BorderRadius.circular(50.0),
//           border: Border.all(
//             color: borderColor,
//             width: 2.0,
//           ),
//         ),
//         child: Center(
//           child: Text(
//             text,
//             style: TextStyle(
//               color: textColor,
//               fontSize: fontSize,
//               fontWeight: fontWeight,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   static Widget quickLinksButton({}) {
//     return
// }
// }
