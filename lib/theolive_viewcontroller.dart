import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:io';

class THEOplayerViewController {
  static const String _TAG = "FL_DART_THEOplayerViewController";
  late MethodChannel _channel;
  int _id;

  THEOplayerViewController(this._id) {
    _channel = MethodChannel('THEOplayerView/$_id');
    //_channel.setMethodCallHandler(_handleMethod);
  }

  /*
  Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case 'sendFromNative':
        dynamic text = call.arguments;
        if (kDebugMode) {
          print("$_TAG  sendFromNative received: $text");
        }
        return Future.value("Text from native: $text");
      case 'currentTime':
        dynamic text = call.arguments;
        if (kDebugMode) {
          print("$_TAG currentTime received: $text");
        }
        return Future.value("ok");

    }
  }
  Future<void> receiveFromFlutter(String text) async {
    try {
      final String result = await _channel.invokeMethod('receiveFromFlutter', {"text": text});
      if (kDebugMode) {
        print("$_TAG Result from native: $result");
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("$_TAG Error from native: $e.message");
      }
    }
  }

  Future<void> play() async {
    try {
      final String result = await _channel.invokeMethod('play');
      if (kDebugMode) {
        print("$_TAG Result from native: $result");
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("$_TAG Error from native: $e.message");
      }
    }
  }
   */
}