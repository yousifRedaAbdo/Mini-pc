import 'package:flutter/material.dart';
import 'package:mini_pc/services/dio.dart';

showMessageDialog(
  BuildContext context,
  String data,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Icon(
          Icons.lock_rounded,
          color: Colors.red,
          size: 55.0,
        ),
        content: Text(
          data,
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      );
    },
  );

  // Set a timer to close the dialog after a certain period (e.g., 3 seconds)
  Future.delayed(Duration(seconds: 6), () {
    Navigator.of(context).pop(); // Close the dialog
  });
}

class DataProvider extends ChangeNotifier {
  // bool isLoading = false;
  //
  // void setLoading(bool value) {
  //   isLoading = value;
  //   notifyListeners();
  // }

  openLocker({
    required String card_id,
    required TextEditingController controller,
    required context,
  }) {
    // print(card_id);
    dioHelper.postdata(
      url: 'open-locker/',
      data: {
        "card_id": card_id,
      },
    ).then((value) {
      notifyListeners();
    }).catchError((erorr) {
      print(erorr.toString());
      showMessageDialog(
          context, 'Something went wrong, please try again later!');
      notifyListeners();
    });
    controller.clear();
  }
}
