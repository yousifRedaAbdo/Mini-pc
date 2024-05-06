
import 'package:flutter/material.dart';
import '../view/home_screen.dart';

showExaptionDialog(BuildContext context, dynamic data, reloadPage) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Icon(
          Icons.error,
          color: Colors.red,
          size: 55.0,
        ),
        content: Text('${data['message']}',
            style: TextStyle(fontSize: 25)),
      );
    },
  );
  // Set a timer to close the dialog after a certain period (e.g., 3 seconds)
  Future.delayed(Duration(seconds: 6), () {
    // if (ModalRoute.of(context)!.isCurrent == false) {
    Navigator.of(context).pop();
    // reloadPage();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false);
    // } // Close the dialog
  });
}
