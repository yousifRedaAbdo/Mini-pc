import 'package:flutter/material.dart';
import 'package:mini_pc/services/dio.dart';

class DataProvider extends ChangeNotifier {

  openLocker({
    required String card_id,
    required context
  }) {
    dioHelper.postdata(
        url: 'open-locker/',
        data: {
          "card_id": "38882993004"
        }).then((value) {
      notifyListeners();
    }).catchError((erorr) {
      print(erorr.toString());
    });
  }
}
