import 'package:flutter/material.dart';
import 'package:flutter_theolive_example/debug_tools.dart';
import 'package:flutter_theolive_example/fullscreen_page.dart';
import 'package:theolive/theolive.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> implements THEOliveViewControllerEventListener {

  late THEOliveViewController _theoController;
  GlobalKey playerUniqueKey = GlobalKey(debugLabel: "playerUniqueKey");

  void _callLoadChannel(String channelID) {
    _theoController.loadChannel(channelID);

  }

  bool playing = false;
  bool loaded = false;
  bool inFullscreen = false;

  late THEOliveView theoLiveView;

  @override
  void initState() {
    dprint("_MoviePageState with THEOliveView: initState ");
    super.initState();
    theoLiveView = THEOliveView(
      key: playerUniqueKey,
      playerConfig: PlayerConfig(
          AndroidConfig(
              useHybridComposition: false,
              nativeRenderingTarget: AndroidNativeRenderingTarget.textureView
          )
      ),
      onTHEOliveViewCreated:(THEOliveViewController controller) {
        // assign the controller to interact with the player
        _theoController = controller;
        //TODO: check this!
        (_theoController as THEOliveViewControllerMobile).eventListener = this;

        NativePlayerConfiguration nativePlayerConfiguration = NativePlayerConfiguration();
        nativePlayerConfiguration.sessionId = "sessionIdForTracking";

        // Updates the config of the player, make sure to call this before loading a channel.
        _theoController.updateNativePlayerConfiguration(nativePlayerConfiguration);
        //_theoController.preloadChannels(["38yyniscxeglzr8n0lbku57b0"]);

        // automatically load the channel once the view is ready
        _callLoadChannel("38yyniscxeglzr8n0lbku57b0");
      },
    );

  }

  @override
  void dispose() {
    dprint("_MoviePageState with THEOliveView: dispose ");

    // NOTE: this would be nicer, if we move it inside the THEOliveView that's a StatefulWidget
    // FIX for https://github.com/flutter/flutter/issues/97499
    //_theoController.manualDispose();
    super.dispose();
  }

  void _playPause() {
    bool newState = false;
    if (playing) {
      _theoController.pause();
      newState = false;
    } else {
      _theoController.play();
      newState = true;
    }
    setState(() {
      playing = newState;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          //check orientation variable to identify the current mode
          double w = 300;
          double h = 300;
          bool landscape = false;

          if(orientation == Orientation.landscape){
            dprint("The screen is on Landscape mode.");
            w = MediaQuery.of(context).size.width;
            h = MediaQuery.of(context).size.height * 0.5;
            landscape = true;
          }

          return Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
              // Column is also a layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              //
              // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
              // action in the IDE, or press "p" in the console), to see the
              // wireframe for each widget.
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'THEOlive',
                ),
                Stack(
                    alignment: Alignment.center,
                    children: [
                      !inFullscreen ? Container(width: w, height: h, color: Colors.black, child: theoLiveView) : Container(),
                      !loaded ? Container(width: w, height: h, color: Colors.black, child: const Center(child: SizedBox(width: 50, height: 50, child: RefreshProgressIndicator()))) : Container(),
                    ]
                ),
                !landscape ? FilledButton(onPressed: (){
                  Navigator.pop(context);
                }, child: const Text("Go back")) : Container(),
                !landscape ? FilledButton(onPressed: () {
                  setState(() {
                    inFullscreen = true;
                  });

                  //Navigator.push(context, MaterialPageRoute(builder: (context) =>  FullscreenPage(playerViewKey: playerUniqueKey,)));
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return FullscreenPage(playerWidget: theoLiveView,);
                    //return FullscreenPage(playerViewKey: playerUniqueKey);
                  }, settings: null)).then((value){
                    dprint("_MoviePageState with THEOliveView: return from fullscreen ");
                    setState(() {
                      inFullscreen = false;
                    });
                  });

                }, child: const Text("Open Fullscreen")) : Container(),
                !landscape ? FilledButton(onPressed: (){
                  _callLoadChannel("38yyniscxeglzr8n0lbku57b0");
                }, child: const Text("Change channel")) : Container(),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _playPause,
        tooltip: 'Load',
        child: playing ? const Icon(Icons.pause) : const Icon(Icons.play_arrow),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


  // THEOliveViewControllerEventListener interface methods
  @override
  void onChannelLoadedEvent(String channelID) {}

  @override
  void onPlaying() {
    setState(() {
      loaded = true;
    });
  }

  @override
  void onChannelLoadStartEvent(String channelID) {
    // TODO: implement onChannelLoadStartEvent
  }

  @override
  void onChannelOfflineEvent(String channelID) {
    // TODO: implement onChannelOfflineEvent
  }

  @override
  void onError(String message) {
    // TODO: implement onError
  }

  @override
  void onIntentToFallback() {
    // TODO: implement onIntentToFallback
  }

  @override
  void onPause() {
    // TODO: implement onPause
  }

  @override
  void onPlay() {
    // TODO: implement onPlay
  }

  @override
  void onReset() {
    // TODO: implement onReset
  }

  @override
  void onWaiting() {
    // TODO: implement onWaiting
  }
}