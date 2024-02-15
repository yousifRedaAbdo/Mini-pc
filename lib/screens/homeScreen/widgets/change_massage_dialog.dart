import 'package:flutter/material.dart';
 showChangeDialog(BuildContext context,dynamic data) {
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
              Text('Sorry,The cell not belong to this locker',
                  style: TextStyle(fontSize: 25)
              ),
              Text('Locker ID: ${data['locker_id']}',
                  style: TextStyle(fontSize: 25)
              ),
              Text('Locker Location: ${data['location']}',
                  style: TextStyle(fontSize: 25)
              ),
              Text('Cell ID: ${data['cell_id']}',
                  style: TextStyle(fontSize: 25)
              ),
            ],
          ),
        ),
      );
    },
  );
  Future.delayed(Duration(seconds: 6), () {
    if (ModalRoute.of(context)!.isCurrent == false)
    {
      Navigator.of(context).pop();
    }// Close the dialog
  });
}