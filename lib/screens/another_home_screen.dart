import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:websocket_tests/utils/sse.dart';

class SSEHomePage extends StatefulWidget {
  final String title;

  SSEHomePage({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SSEHomePage> {
  StreamController<bool> _controller;
  String streamText;
  final Stream<dynamic> _myStream = Sse.connect(
      uri: Uri.parse('https://192.168.178.60:12529/sse'),
      closeOnError: true,
      withCredentials: false,
    ).stream.asBroadcastStream();

  @override
  void initState() {
    super.initState();
    // this._myStream = Sse.connect(
    //   uri: Uri.parse('https://192.168.178.60:12529/sse'),
    //   closeOnError: true,
    //   withCredentials: false,
    // ).stream;

        _controller = StreamController<bool>.broadcast();

    this._myStream.listen((event) {
      print('Received:' + DateTime.now().millisecondsSinceEpoch.toString() + ' : ' + event.toString());
    });
    _myStream.asBroadcastStream();
    // print(_myStream.isBroadcast);
  }

  @override
  void dispose() {
    _controller?.close();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Builder(
          builder: (context) {
            _myStream.listen((_) {
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                const SnackBar(content: Text('There is a new update available!'), backgroundColor: Colors.indigo,),
              );
            });
            return  StreamBuilder(
            stream: _myStream,
            builder: (context, snapshot) =>
              // return Text(snapshot.hasData ? '${snapshot.data}' : '');
               !snapshot.hasData
                      ? const CircularProgressIndicator()
                      : snapshot.hasError
                          ? const Icon(Icons.error)
                          : const Text("Got Some Updates"),
          );
          },
          
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendEvent,
        tooltip: 'Emit event',
        child: Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.

    );
  }

  void _sendEvent() {
    // Send POST to req
    
  }
}