import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mini_pc/components/texts.dart';
import '../view/home_screen.dart';

showSuccessDialog(BuildContext context, dynamic data, reloadPage) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Expanded(
        child: Container(
          color: Colors.white,
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SvgPicture.asset(
                    "assets/images/circle.svg",
                  )
                ],
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            "assets/images/logo.svg",
                            height: 70,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: title('The locker has been opened Cell ID: ${data['cell_id'].toString()}',color: Color(0xff437EEB)
                              ),
                            ),
                            SizedBox(height: 40,),
                            Center(
                              child: SvgPicture.asset(
                                "assets/images/box.svg",
                                height: 300,
                              ),
                            )
                          ],
                        )
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          "assets/images/small_circle.svg",
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
      //   AlertDialog(
      //   title: Icon(
      //     Icons.lock_open_outlined,
      //     color: Colors.green,
      //     size: 55.0,
      //   ),
      //   content: Text('The locker has been opened Cell ID: ${data['cell_id']}',
      //       style: TextStyle(fontSize: 25)),
      // );
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
