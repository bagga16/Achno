// import 'package:flutter/material.dart';

// class CommonButton extends StatelessWidget {
//   final String text;
//   final TextStyle? textStyle;
//   final Color? buttonColor;
//   final VoidCallback? onPressed;
//   final double width;
//   final double height;

//   const CommonButton({
//     Key? key,
//     required this.text,
//     this.textStyle,
//     this.buttonColor,
//     this.onPressed,
//     this.width = double.infinity,
//     this.height = 50,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: width,
//       height: height,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: buttonColor ?? Color.fromRGBO(0, 110, 255, 1),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8),
//           ),
//           elevation: 0, // Flat look
//         ),
//         onPressed: onPressed ?? () {}, // Default empty function
//         child: Text(
//           text,
//           style: textStyle ??
//               const TextStyle(
//                 color: Colors.white, // White text color
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold, // Bold text
//               ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? const Color(0xFF16706E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: textColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
