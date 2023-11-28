import 'package:flutter/material.dart';
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
    String url =
        'ws://51.20.73.175:8000/ws/open_cell_employee/';
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
             snapshot.hasData ?
            showChangeDialog(context,snapshot.data)
                :
             Padding(
              padding: const EdgeInsets.all(16.0),
              child:Text('No data')
            );
             return Padding(
                 padding: const EdgeInsets.all(16.0),
            child:Text('No data')
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