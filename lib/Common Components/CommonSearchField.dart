// import 'package:flutter/material.dart';

// class CommonSearchBar extends StatelessWidget {
//   final TextEditingController? controller;
//   final Function(String)? onSearch;
//   final String hintText;

//   const CommonSearchBar({
//     Key? key,
//     this.controller,
//     this.onSearch,
//     this.hintText = "Search here",
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16.w),
//       height: 42.h,
//       decoration: BoxDecoration(
//         color: Colors.grey[100],
//         borderRadius: BorderRadius.circular(25.r),
//         border: Border.all(
//           width: 1,
//           color: const Color.fromRGBO(188, 186, 186, 1),
//         ),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               controller: controller,
//               decoration: InputDecoration(
//                 hintText: hintText,
//                 border: InputBorder.none,
//                 hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
//               ),
//               onSubmitted: onSearch, // Calls onSearch when pressing "Enter"
//             ),
//           ),
//           Icon(Icons.search, color: Colors.grey, size: 20.w),
//         ],
//       ),
//     );
//   }
// }
