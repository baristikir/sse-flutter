import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter_sockets/model/case_model.dart';
// import 'package:flutter_sockets/socket/stream_socket.dart';

class SocketBloc extends ChangeNotifier {
  bool _connected;
  bool get connected => _connected;

  String _message;
  String get message => _message;


  SocketBloc() {
    // Socket.emit("patient feed");
    // Socket.subscribe(
    //     "patient feed",
    //     (dynamic val) => {_message = val});
  }
  set connected(bool status) {
    _connected = status;
    notifyListeners();
  }
}
