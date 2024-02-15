import 'package:flutter/material.dart';

 showSuccessDialog(BuildContext context, dynamic data) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Icon(
          Icons.lock_open_outlined,
          color: Colors.green,
          size: 55.0,
        ),
        content: Text(
          'The locker has been opened Cell ID: ${data['cell_id']}',
            style: TextStyle(fontSize: 25)
        ),
      );
    },
  );

  // Set a timer to close the dialog after a certain period (e.g., 3 seconds)
  Future.delayed(Duration(seconds: 6), () {
    if (ModalRoute.of(context)!.isCurrent == false)
    {
      Navigator.of(context).pop();
    } // Close the dialog
  });
}