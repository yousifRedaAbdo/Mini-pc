import 'package:flutter/material.dart';

void showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Icon(
          Icons.lock_open_outlined,
          color: Colors.green,
          size: 55.0,
        ),
        content: Text('The locker has been opened Cell ID: 55'),
      );
    },
  );

  // Set a timer to close the dialog after a certain period (e.g., 3 seconds)
  Future.delayed(Duration(seconds: 3), () {
    Navigator.of(context).pop(); // Close the dialog
  });
}