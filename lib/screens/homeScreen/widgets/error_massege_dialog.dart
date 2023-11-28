import 'package:flutter/material.dart';

void showErrorDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Icon(
          Icons.error,
          color: Colors.red,
          size: 55.0,
        ),
        content: Text('Sorry, Don’t have a cell assigned to you'),
      );
    },
  );

  Future.delayed(Duration(seconds: 3), () {
    Navigator.of(context).pop(); // Close the dialog
  });
}