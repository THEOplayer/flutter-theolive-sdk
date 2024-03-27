import 'dart:async';

import 'package:flutter/material.dart';
import 'package:theolive/theolive.dart';

class TestApp extends StatefulWidget {
  final _playerReady = Completer();

  TestApp({super.key});

  @override
  State<TestApp> createState() => _TestAppState();

  Future<void> waitForPlayerReady() {
    return _playerReady.future;
  }
}

class _TestAppState extends State<TestApp> with THEOliveEventListener {
  late THEOlive player;

  @override
  void initState() {
    super.initState();

    print("_DEBUG: TestApp init");

    player = THEOlive(
        playerConfig: PlayerConfig(AndroidConfig()),
        onCreate: () {
          print("_DEBUG: TestApp - THEOplayer - onCreate");
          player.addEventListener(this);
          widget._playerReady.complete();
        });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('THEOlive Test App'),
        ),
        body: Builder(
            builder: (context) {
              return Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: 400,
                      height: 300,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                            ChromelessPlayer(key: const Key("testChromelessPlayer"), player: player),
                        ],

                      ),
                    ),
                  ],
                ),
              );
            }
        ),
      ),
    );
  }


  @override
  void onChannelLoadStart(String channelID) {
    print("_DEBUG: - THEOliveEventListener - onChannelLoadStart: $channelID");
  }

  @override
  void onChannelLoaded(String channelID) {
    print("_DEBUG:  - THEOliveEventListener - onChannelLoaded: $channelID");
  }

  @override
  void onChannelOffline(String channelID) {
    print("_DEBUG:  - THEOliveEventListener - onChannelOffline: $channelID");
  }

  @override
  void onWaiting() {
    print("_DEBUG:  - THEOliveEventListener - onWaiting");
  }

  @override
  void onPlay() {
    print("_DEBUG:  - THEOliveEventListener - onPlay");
  }

  @override
  void onPlaying() {
    print("_DEBUG:  - THEOliveEventListener - onPlaying");
  }

  @override
  void onPause() {
    print("_DEBUG:  - THEOliveEventListener - onPause");
  }

  @override
  void onMutedChange() {
    print("_DEBUG:  - THEOliveEventListener - onMutedChange");
  }

  @override
  void onIntentToFallback() {
    print("_DEBUG:  - THEOliveEventListener - onIntentToFallback");
  }

  @override
  void onEnterBadNetworkMode() {
    print("_DEBUG:  - THEOliveEventListener - onEnterBadNetworkMode");
  }

  @override
  void onExitBadNetworkMode() {
    print("_DEBUG:  - THEOliveEventListener - onExitBadNetworkMode");
  }

  @override
  void onReset() {
    print("_DEBUG:  - THEOliveEventListener - onReset");
  }

  @override
  void onError(String message) {
    print("_DEBUG:  - THEOliveEventListener - onError: $message");
  }
  
  
}


class ChromelessPlayer extends StatelessWidget {
  static GlobalKey globalKey = GlobalKey();

  const ChromelessPlayer({
    super.key,
    required this.player,
  });

  final THEOlive player;

  @override
  Widget build(BuildContext context) {
    return player.getView();
  }
}