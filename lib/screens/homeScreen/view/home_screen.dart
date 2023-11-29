import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mini_pc/components/texts.dart';
import 'package:mini_pc/screens/homeScreen/widgets/change_massage_dialog.dart';
import 'package:mini_pc/screens/homeScreen/widgets/error_massege_dialog.dart';
import 'package:mini_pc/screens/homeScreen/widgets/success_massage_dialog.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final WebSocketChannel channel;
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  showSuccessDialog(context, jsonData['data']);
                });
              } else if (key == 'error_no_cell_assigned') {
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  showErrorDialog(context);
                });
              } else {
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  showChangeDialog(context, jsonData['data']);
                });
              }
            } else {
              return Center(
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
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                        child: Column(
                          children: [
                            title("Welcome"),
                            mediumText("Please Enter You ID"),
                          ],
                        )),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Image(
                                image: const AssetImage(
                                  "assets/images/card.png",
                                ),
                              ),
                            ),
                            Expanded(
                              child: Image(
                                image: const AssetImage(
                                  "assets/images/phone.png",
                                ),
                              ),
                            ),
                            Expanded(
                              child: Image(
                                image: const AssetImage(
                                  "assets/images/finger_print.jpg",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
            return Center(
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
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: Column(
                        children: [
                          title("Welcome"),
                          mediumText("Please Enter You ID"),
                        ],
                      )),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
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
                            child: Image(
                              image: const AssetImage(
                                "assets/images/phone.png",
                              ),
                            ),
                          ),
                          Expanded(
                            child: Image(
                              image: const AssetImage(
                                "assets/images/finger_print.jpg",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}
