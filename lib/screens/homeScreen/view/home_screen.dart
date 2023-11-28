import 'package:flutter/material.dart';
import 'package:mini_pc/components/texts.dart';
import 'package:mini_pc/screens/homeScreen/widgets/change_massage_dialog.dart';
import 'package:mini_pc/screens/homeScreen/widgets/error_massege_dialog.dart';
import 'package:mini_pc/screens/homeScreen/widgets/success_massage_dialog.dart';

class HomeScreens extends StatelessWidget {
  const HomeScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Image(
                image: const AssetImage(
                  "assets/images/imbox.png",
                ),
              ),
            ),
            SizedBox(height: 10,),
            Expanded(
                child: Column(
                    children: [
                      title("Welcome"),
                      mediumText("Please Enter You ID"),
                    ],
                )
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                        child:  InkWell(
                          onTap: (){
                            showErrorDialog(context);
                          },
                          child: Image(
                            image: const AssetImage(
                              "assets/images/card.png",
                            ),
                          ),
                        ),
                      ),
                     Expanded(
                        child:  InkWell(
                          onTap: (){
                            showSuccessDialog(context);
                          },
                          child: Image(
                            image: const AssetImage(
                              "assets/images/phone.png",
                            ),
                          ),
                        ),
                      ),
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          showChangeDialog(context,"");
                        },
                        child: Image(
                          image: const AssetImage(
                            "assets/images/finger_print.jpg",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
