// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class MyPage extends StatefulWidget {
//   @override
//   _MyPageState createState() => _MyPageState();
// }

// class _MyPageState extends State<MyPage> {
//   /// Variables
//   File? imageFile;

//   /// Widget
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("Image Picker"),
//         ),
//         body: Container(
//             child: imageFile == null
//                 ? Container(
//                     alignment: Alignment.center,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         ElevatedButton(
//                           onPressed: () {
//                             _getFromGallery();
//                           },
//                           child: const Text("PICK FROM GALLERY"),
//                         ),
//                         Container(
//                           height: 40.0,
//                         ),
//                       ],
//                     ),
//                   )
//                 : Image.file(
//                     imageFile!,
//                     fit: BoxFit.cover,
//                   )));
//   }

//   _getFromGallery() async {
//     XFile? pickedFile = await ImagePicker().pickImage(
//       source: ImageSource.gallery,
//     );
//     if (pickedFile != null) {
//       setState(() {
//         imageFile = File(pickedFile.path);
//       });
//     }
//   }
// }
