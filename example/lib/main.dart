import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_theolive/flutter_theolive.dart';

import 'movie_page.dart';


void main() {
  runApp(const MaterialApp( home: MyApp(),));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _flutterTheolivePlugin = FlutterTheolive();

  @override
  void initState() {
    super.initState();
    initPlatformState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('THEOlive SDK Sample app'),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
          const Text(
            'THEOlive',
          ),

          FilledButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  const MoviePage(title: "Movie",)));
          }, child: const Text("Open Movie")),

          Center(child: Text('Running on: $_platformVersion\n'),),
        ],)

      );
  }

}
