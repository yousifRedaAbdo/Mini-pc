import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mini_pc/components/texts.dart';

class SuccessScreen extends StatelessWidget {
  dynamic data;
   SuccessScreen(this.data);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 4), () {
      Navigator.of(context).pop();
    });
    return Scaffold(
      body: Expanded(
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
                            height: 100,
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
      ),
    );
  }
}
