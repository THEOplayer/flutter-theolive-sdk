import 'package:flutter/material.dart';
import 'package:flutter_theolive_example/debug_tools.dart';
import 'package:flutter_theolive_example/fullscreen_page.dart';
import 'package:theolive/theolive.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({super.key, required this.title});

  final String title;

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> with THEOliveEventListener {
  late THEOlive _theoLive;
  bool inFullscreen = false;

  @override
  void initState() {
    dprint("MoviePageState: initState ");
    super.initState();
    _theoLive = THEOlive(
        playerConfig: PlayerConfig(
          AndroidConfig(
            useHybridComposition: true,
            nativeRenderingTarget: AndroidNativeRenderingTarget.surfaceView,
          ),
        ),
        onCreate: () {
          NativePlayerConfiguration nativePlayerConfiguration = NativePlayerConfiguration();
          nativePlayerConfiguration.sessionId = "sessionIdForTracking";

          _theoLive.setStateListener(() => setState(() {}));
          _theoLive.addEventListener(this);

          // Updates the config of the player, make sure to call this before loading a channel.
          _theoLive.updateNativePlayerConfiguration(nativePlayerConfiguration);

          // automatically load the channel once the view is ready
          // _theoLive.preloadChannels(["2vqqekesftg9zuvxu9tdme6kl"]);
          _theoLive.loadChannel("2vqqekesftg9zuvxu9tdme6kl");
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

          if (orientation == Orientation.landscape) {
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
                Stack(alignment: Alignment.center, children: [
                  inFullscreen
                      ? Container()
                      : Container(width: w, height: h, color: Colors.black, child: _theoLive.getView()),
                  _theoLive.isWaiting()
                      ? Container(
                          width: w,
                          height: h,
                          color: Colors.transparent,
                          child: const Center(child: SizedBox(width: 50, height: 50, child: RefreshProgressIndicator())))
                      : Container(),
                ]),
                !landscape
                    ? FilledButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Go back"))
                    : Container(),
                !landscape
                    ? FilledButton(
                        onPressed: () {
                          setState(() {
                            inFullscreen = true;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullscreenPage(theoLive: _theoLive),
                              settings: null,
                            ),
                          ).then((value) {
                            dprint("MoviePage: return from fullscreen");
                            setState(() {
                              inFullscreen = false;
                            });
                          });
                        },
                        child: const Text("Open Fullscreen"))
                    : Container(),
                !landscape
                    ? FilledButton(
                        onPressed: () {
                          _theoLive.loadChannel("2vqqekesftg9zuvxu9tdme6kl");
                        },
                        child: const Text("Change channel"))
                    : Container(),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _playPause,
        tooltip: 'Load',
        child: _theoLive.isPaused() ? const Icon(Icons.play_arrow) : const Icon(Icons.pause),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _playPause() {
    if (_theoLive.isPaused()) {
      _theoLive.play();
    } else {
      _theoLive.pause();
    }
  }

  @override
  void dispose() {
    _theoLive.dispose();
    super.dispose();
  }

  @override
  void onChannelLoadStart(String channelID) {
    dprint("MoviePage - THEOliveEventListener - onChannelLoadStart: $channelID");
  }

  @override
  void onChannelLoaded(String channelID) {
    dprint("MoviePage - THEOliveEventListener - onChannelLoaded: $channelID");
  }

  @override
  void onChannelOffline(String channelID) {
    dprint("MoviePage - THEOliveEventListener - onChannelOffline: $channelID");
  }

  @override
  void onWaiting() {
    dprint("MoviePage - THEOliveEventListener - onWaiting");
  }

  @override
  void onPlay() {
    dprint("MoviePage - THEOliveEventListener - onPlay");
  }

  @override
  void onPlaying() {
    dprint("MoviePage - THEOliveEventListener - onPlaying");
  }

  @override
  void onPause() {
    dprint("MoviePage - THEOliveEventListener - onPause");
  }

  @override
  void onMutedChange() {
    dprint("MoviePage - THEOliveEventListener - onMutedChange");
  }

  @override
  void onIntentToFallback() {
    dprint("MoviePage - THEOliveEventListener - onIntentToFallback");
  }

  @override
  void onEnterBadNetworkMode() {
    dprint("MoviePage - THEOliveEventListener - onEnterBadNetworkMode");
  }

  @override
  void onExitBadNetworkMode() {
    dprint("MoviePage - THEOliveEventListener - onExitBadNetworkMode");
  }

  @override
  void onReset() {
    dprint("MoviePage - THEOliveEventListener - onReset");
  }

  @override
  void onError(String message) {
    dprint("MoviePage - THEOliveEventListener - onError: $message");
  }

}
