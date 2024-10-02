import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mini_pc/components/keyboard_number.dart';
import 'package:mini_pc/components/texts.dart';
import 'package:mini_pc/screens/homeScreen/success_screen.dart';
import 'package:mini_pc/screens/homeScreen/widgets/change_massage_dialog.dart';
import 'package:mini_pc/screens/homeScreen/widgets/error_massege_dialog.dart';
import 'package:mini_pc/screens/homeScreen/widgets/exaption_message_dialog.dart';
import 'package:mini_pc/screens/homeScreen/widgets/success_massage_dialog.dart';
import 'package:mini_pc/services/provider.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final WebSocketChannel channel;
  void reloadPage() {
    setState(() {});
  }
  void updatePin(String pin) {
    setState(() {
      controller.text = pin;
    });
  }

  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // String url =
    //     'ws://51.20.73.175:8000/ws/open_cell_employee/';
    String url = 'ws://127.0.0.1:8000/ws/open_cell_employee/';
    final urlChanged = Uri.parse(url);
    channel = WebSocketChannel.connect(urlChanged);
    channel.stream.handleError((error) {
      // Print the error if it occurs during the WebSocket stream
      print('WebSocket stream error: $error');
    });
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      }
    });
  }

  bool isHidden = true;
  var controller = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: StreamBuilder(
          stream: channel.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map<String, dynamic> jsonData = json.decode(snapshot.data);

              String key = jsonData['data']['key'];

              if (key == 'success_open') {
                // showSuccessDialog(context, jsonData['data']);
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                   showSuccessDialog(context, jsonData['data'], reloadPage);
                  //Navigator.of(context).push(MaterialPageRoute(builder: ((context) => SuccessScreen(jsonData['data']))));
                });
              } else if (key == 'error_no_cell_assigned') {
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  showErrorDialog(context, reloadPage);
                });
              } else if (key == 'error_message') {
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  showExaptionDialog(context,jsonData['data'], reloadPage);
                });
              }
              else {
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  showChangeDialog(context, jsonData['data'], reloadPage);
                });
              }
            }
            return Stack(
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
                        child: Form(
                          key: formKey,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      mediumText("Please Enter Your ID To Open Cell",color: Color(0xffF28021)),
                                      SizedBox(height: 10,),
                                      SizedBox(
                                        width: 300,
                                        child: TextFormField(
                                          controller: controller,
                                          obscureText: isHidden,
                                          focusNode: focusNode,
                                           readOnly: false,
                                           keyboardType: TextInputType.none,
                                           autofocus: true,
                                          decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color:Color(0xff437EEB),
                                                  ),
                                                  borderRadius: BorderRadius.circular(35)
                                              ),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(color:Color(0xff437EEB),
                                                  ),
                                                  borderRadius: BorderRadius.circular(35)
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color:Color(0xff437EEB),
                                                  ),
                                                  borderRadius: BorderRadius.circular(35)
                                              ),
                                              suffixIcon: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    isHidden = !isHidden;
                                                  });
                                                },
                                                child: isHidden == true
                                                    ? const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 12.0),
                                                  child: Icon(
                                                    Icons.visibility_off,
                                                    color: Color(0xffF28021),
                                                    size: 22,
                                                  ),
                                                )
                                                    : const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 12.0),
                                                  child: Icon(
                                                    Icons.visibility,
                                                    color: Color(0xffF28021),
                                                    size: 22,
                                                  ),
                                                ),
                                              ),
                                              prefixIcon: InkWell(
                                                  onTap: () {
                                                    controller.clear();
                                                  },
                                                  child: Icon(Icons.clear,color: Color(0xffF28021),))),
                                          onFieldSubmitted: (value) {
                                            dataProvider.setLoading(true);
                                            if (formKey.currentState!.validate()) {
                                              dataProvider.openLocker(
                                                  card_id: controller.text,
                                                  controller: controller,
                                                  context: context);
                                            }
                                          },
                                          validator: (String? value) {
                                            if (value!.isEmpty) {
                                              return 'Please Enter Your ID';
                                            }
                                          },
                                          onTap: ()
                                          {
                                            SystemChannels.textInput.invokeMethod('TextInput.hide');
                                            setState(() {
                                              // Additional logic if needed
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  mediumText("OR"),
                                  mediumText("Scan Your QR-Code Below",color: Color(0xff437EEB)),
                                  SvgPicture.asset(
                                    "assets/images/arrow.svg",
                                    // width: 250,
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 300,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    NumericKeyboardScreen(
                                      controller: controller,
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: dataProvider.isLoading == false
                                          ? ClipRRect(
                                        borderRadius: BorderRadius.circular(35),
                                            child: MaterialButton(
                                              color: Colors.blue,
                                              onPressed: () {
                                                if (formKey.currentState!.validate()) {
                                              dataProvider.setLoading(true);
                                              dataProvider.openLocker(
                                                  card_id: controller.text,
                                                  controller: controller,
                                                  context: context);
                                            }
                                            },
                                              child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Open Cell",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                                                                        ),
                                                                                      ),
                                          )
                                          : Center(child: CircularProgressIndicator()),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    focusNode.dispose();
    controller.dispose();
    super.dispose();
  }
}
