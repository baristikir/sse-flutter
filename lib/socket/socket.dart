import 'dart:async';

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
class WebSocketConstants {
  static const url = 'wss://echo.websocket.org';
}
class Socket {
  static IOWebSocketChannel _websocketChannel;
  static const _url = WebSocketConstants.url;

  static _initialize() {
    _websocketChannel = IOWebSocketChannel.connect(Uri.parse(_url));
    try {
      _websocketChannel.stream.listen((event) {
        _websocketChannel.sink.add("Received!");
        _websocketChannel.sink.close(status.goingAway);
      }).onDone(() {print("Stream closed");});
    } catch (e) {
      print(e);
    }
  }

  // static emit(String event, {dynamic arguments}) {
  //   _initialize(); // Ensure it's initialized
  //   _socket.emit(event, arguments ?? {});
  //   // _socket.emit(event, msg);
  // }

  // static subscribe(String event, Function function) {
  //   _initialize(); // Ensure it's initialized
  //   _socket.on(event, function);
  // }

  // static unsubscribe(String event, Function function) {
  //   _initialize(); // Ensure it's initialized
  //   _socket.off(event, function);
  // }
}

class SocketManager {}
