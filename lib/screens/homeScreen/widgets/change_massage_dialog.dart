import 'package:flutter/material.dart';

void showChangeDialog(BuildContext context,dynamic data) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Icon(
          Icons.lock,
          color: Colors.red,
          size: 55.0,
        ),
        content: Container(
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Sorry,The cell not belong to this locker'),
              Text('Locker ID: ${data['locker_id']}'),
              Text('Locker Location: ${data['location']}'),
              Text('Cell ID: ${data['cell_id']}'),
            ],
          ),
        ),
      );
    },
  );

  // Set a timer to close the dialog after a certain period (e.g., 3 seconds)
  Future.delayed(Duration(seconds: 3), () {
    Navigator.of(context).pop(); // Close the dialog
  });
}