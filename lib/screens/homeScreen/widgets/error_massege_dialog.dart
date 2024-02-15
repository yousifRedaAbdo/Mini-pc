import 'package:flutter/material.dart';
import '../view/home_screen.dart';

showErrorDialog(BuildContext context, reloadPage) {
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
        content: Text('Sorry, Don’t have a cell assigned to you',
            style: TextStyle(fontSize: 25)),
      );
    },
  );

  Future.delayed(Duration(seconds: 6), () {
    // if (ModalRoute.of(context)!.isCurrent == false)
    // {
    Navigator.of(context).pop();
    // reloadPage();
    // Nav.pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false)
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false);
    // }// Close the dialog
  });
}
