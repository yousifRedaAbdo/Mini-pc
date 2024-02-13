import 'package:flutter/material.dart';
import 'package:mini_pc/services/dio.dart';

class DataProvider extends ChangeNotifier {
  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

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
      setLoading(false);
      controller.clear();
      notifyListeners();
    }).catchError((erorr) {
      setLoading(false);
      print(erorr.toString());
    });
  }
}
