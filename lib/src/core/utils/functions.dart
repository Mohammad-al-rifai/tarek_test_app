import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void popScreen(context) => Navigator.of(context).pop();

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (route) => false,
    );

getScreenWidth(BuildContext context) => MediaQuery.of(context).size.width;

getScreenHeight(BuildContext context) => MediaQuery.of(context).size.height;

myPrint({required String text}) {
  if (kDebugMode) {
    print(text);
  }
}

getDeco() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadiusDirectional.circular(12.0),
    boxShadow: const [
      BoxShadow(
        color: Colors.deepPurple,
        blurRadius: 1.0,
        spreadRadius: 1.0,
        blurStyle: BlurStyle.outer,
      ),
      BoxShadow(
        color: Colors.deepPurple,
        blurRadius: 1.0,
        spreadRadius: 1.0,
        blurStyle: BlurStyle.outer,
      ),
      BoxShadow(
        color: Colors.yellowAccent,
        blurRadius: 1.0,
        spreadRadius: 1.0,
        blurStyle: BlurStyle.outer,
      ),
    ],
  );
}

// Function to convert File to bytes
Future<List<int>> getImageBytes(File file) async {
  List<int> imageBytes = await file.readAsBytes();
  return imageBytes;
}

Widget displayEmployeeImage(List<int> imageBytes) {
  Uint8List bytes = Uint8List.fromList(imageBytes);
  return Image.memory(
    bytes,
    width: 100,
    height: 100,
  ); // Adjust width and height as needed
}

Future<String> fileToBase64(File file) async {
  List<int> imageBytes = await file.readAsBytes();
  String base64String = base64Encode(imageBytes);
  return base64String;
}

Future<Uint8List> fileToUnit8List(File file) async {
  List<int> bytes = await file.readAsBytes();
  return Uint8List.fromList(bytes);
}

File base64ToFile(String base64String, String fileName) {
  try {
    // Decode the base64 string
    Uint8List bytes = base64.decode(base64String);

    // Create a File from the decoded bytes
    File file = File(fileName);

    // Write the bytes to the file
    file.writeAsBytesSync(bytes);

    return file;
  } catch (error) {
    print('Error converting base64 to File: $error');
    return File(''); // You can handle the error as needed
  }
}
