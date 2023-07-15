import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:io';

class THEOplayerViewController {
  static const String _TAG = "FL_DART_THEOliveViewController";
  late MethodChannel _channel;
  int _id;

  THEOplayerViewController(this._id) {
    _channel = MethodChannel('THEOliveView/$_id');
    _channel.setMethodCallHandler(_handleMethod);
  }


  // handle calls from Android
  Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case 'onChannelLoaded':
        dynamic channelId = call.arguments;
        if (kDebugMode) {
          print("$_TAG  onChannelLoaded received: $channelId");
        }
        return Future.value("ok"); // whatever, if we want to send back something
      default:
        print("$_TAG  unexpected received: ${call.method}");


    }

  }

  // if we need to wait for a result:
  Future<void> play() async {
    try {
      final Bool result = await _channel.invokeMethod('play');
      if (kDebugMode) {
        print("$_TAG Result from native: $result");
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("$_TAG Error from native: $e.message");
      }
    }
  }

  // if we want to call async
  loadChannel(String channelId)  {
    _channel.invokeMethod("loadChannel", { "channelId": channelId } );
  }

}