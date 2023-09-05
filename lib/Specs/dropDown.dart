// import 'package:flutter/material.dart';

// class DropDownWid extends State {
//   String selectedValue = 'Option 1';
//   List<String> options = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text('Select an option:'),
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: 16),
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: DropdownButton<String>(
//             value: selectedValue,
//             onChanged: (newValue) {
//               setState(() {
//                 selectedValue = newValue!;
//               });
//             },
//             items: options.map<DropdownMenuItem<String>>((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Text(value),
//               );
//             }).toList(),
//           ),
//         ),
//         SizedBox(height: 20),
//         Text('Selected Value: $selectedValue'),
//       ],
//     );
//   }
// }
