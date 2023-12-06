import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_theolive/flutter_theolive.dart';
import 'package:flutter_theolive/theolive_view.dart';
import 'package:flutter_theolive/theolive_viewcontroller.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> implements THEOliveViewControllerEventListener {
  String _platformVersion = 'Unknown';
  final _flutterTheolivePlugin = FlutterTheolive();

  late THEOliveView theoLiveView;
  GlobalKey playerUniqueKey = GlobalKey(debugLabel: "playerUniqueKey");

  @override
  void initState() {
    super.initState();
    initPlatformState();

      theoLiveView = THEOliveView(key: playerUniqueKey, onTHEOliveViewCreated:(THEOliveViewController controller) {
        // assign the controller to interact with the player
        _theoController = controller;
        _theoController.eventListener = this;
        //_theoController.preloadChannels(["38yyniscxeglzr8n0lbku57b0"]);

        // automatically load the channel once the view is ready
        _callLoadChannel();
      }
      );

  }

  void _callLoadChannel() {
    _theoController.loadChannel("38yyniscxeglzr8n0lbku57b0");
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _flutterTheolivePlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  late THEOliveViewController _theoController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
          Container(width: 300, height: 300, child: theoLiveView),
          Center(child: Text('Running on: $_platformVersion\n'),),
        ],)

      ),
    );
  }

  @override
  void onChannelLoadedEvent(String channelID) {
    // TODO: implement onChannelLoadedEvent
  }

  @override
  void onPlaying() {
    // TODO: implement onPlaying
  }
}
