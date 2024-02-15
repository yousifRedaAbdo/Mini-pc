
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mini_pc/components/texts.dart';
import 'package:mini_pc/screens/homeScreen/widgets/change_massage_dialog.dart';
import 'package:mini_pc/screens/homeScreen/widgets/error_massege_dialog.dart';
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


  bool isHidden = true;
  var controller = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);

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
                WidgetsBinding.instance!.addPostFrameCallback((_) async{
                await  showSuccessDialog(context, jsonData['data']);
                });
              } else if (key == 'error_no_cell_assigned') {
                WidgetsBinding.instance!.addPostFrameCallback((_) async{
                await  showErrorDialog(context);
                });
              } else {
                WidgetsBinding.instance!.addPostFrameCallback((_) async{
                await  showChangeDialog(context, jsonData['data']);
                });
              }
            } else {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      image: const AssetImage(
                        "assets/images/imbox.png",
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            title("Welcome"),
                            mediumText("Please Enter Your ID"),
                            Form(
                              key: formKey,
                              child: SizedBox(
                                width: 300,
                                child: TextFormField(
                                  controller: controller,
                                  obscureText: isHidden,
                                  decoration: InputDecoration(
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isHidden = !isHidden;
                                        });
                                      },
                                      child: isHidden == true
                                          ? const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                                        child: Icon(
                                          Icons.visibility_off,
                                          color: Colors.black,
                                          size: 22,
                                        ),
                                      )
                                          : const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                                        child: Icon(
                                          Icons.visibility,
                                          color: Colors.black,
                                          size: 22,
                                        ),
                                      ),
                                    ),
                                    prefixIcon: InkWell(
                                      onTap: (){
                                        controller.clear();
                                      },
                                        child: Icon(Icons.clear)
                                    )
                                  ),
                                  onFieldSubmitted: (value){
                                    dataProvider.setLoading(true);
                                    if (formKey.currentState!.validate()) {
                                      dataProvider.openLocker(
                                          card_id: controller.text,
                                          controller: controller,
                                          context: context
                                      );
                                    }
                                  },
                                  autofocus: true,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter Your ID';
                                    }
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            SizedBox(
                              width: 100,
                              child: dataProvider.isLoading == false? MaterialButton(
                                color: Colors.blue,

                                onPressed: (){
                                  if (formKey.currentState!.validate()) {
                                    dataProvider.setLoading(true);
                                    dataProvider.openLocker(
                                        card_id: controller.text,
                                        controller: controller,
                                        context: context
                                    );
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Open Cell",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ),
                              )
                                  :
                              Center(child: CircularProgressIndicator()),
                            )
                          ],
                        )
                    ),
                    Expanded(
                      flex: 1,
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
            return Text((""));
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
