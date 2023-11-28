import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mini_pc/screens/homeScreen/widgets/error_massege_dialog.dart';
import 'package:mini_pc/screens/homeScreen/widgets/success_massage_dialog.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'screens/homeScreen/widgets/change_massage_dialog.dart';

class MyWebSocketPage extends StatefulWidget {
  @override
  _MyWebSocketPageState createState() => _MyWebSocketPageState();
}

class _MyWebSocketPageState extends State<MyWebSocketPage> {
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
      appBar: AppBar(
        title: Text('WebSocket Example'),
      ),
      body: Center(
        child: StreamBuilder(
          stream: channel.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map<String, dynamic> jsonData = json.decode(snapshot.data);

              String key = jsonData['data']['key'];

              if (key == 'success_open')
              {
                // showSuccessDialog(context, jsonData['data']);
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  showSuccessDialog(context, jsonData['data']);
                });
              }else if(key == 'error_no_cell_assigned')
              {
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  showErrorDialog(context);
                });

             }else
             {
               WidgetsBinding.instance!.addPostFrameCallback((_) {
                 showChangeDialog(context, jsonData['data']);
               });
             }
              }else{
             return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('No data')
              );
            }
            return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('No data')
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          channel.sink.add('Hello, WebSocket!');
        },
        tooltip: 'Send Message',
        child: Icon(Icons.send),
      ),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}